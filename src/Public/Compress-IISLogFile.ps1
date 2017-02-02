function Compress-IISLogFile {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .PARAMETER Path
    .PARAMETER Months
    .EXAMPLE
    .EXAMPLE
    .LINK
    .NOTES
    #>

    [CmdletBinding()]
    [OutputType()]
    Param (
        [Parameter(Mandatory=$true,
            Position=1)]
        [string[]] $Path,

        [Parameter(Position=2)]
        [int] $Months = 1
    )

    Begin {
        $DisplayFormat = 'MM/dd/yyyy'
        $FileFormat = 'yyyy-MM'
        $CurrentDate = Get-Date
        $CurrentMonth = Get-Date -Year $CurrentDate.Year -Month $CurrentDate.Month -Day 1
        $ArchiveMonth = $CurrentMonth.AddMonths(-$Months)
        Write-Verbose -Message "Log files older that '$($ArchiveMonth.ToString($DisplayFormat))' will be archived."
    }

    Process {
        foreach ( $LogPath in $Path ) {
            Write-Verbose -Message "Searching for log files in '$LogPath'"
            try {
                $LogsToCompress = Get-ChildItem -Path "$($LogPath)\*" -Include '*.log' -ErrorAction Stop |
                    Where-Object { $PSItem.PSIsContainer -eq $false -and $PSItem.LastWriteTime -lt $ArchiveMonth }
            }
            catch {
                Write-Error -Message "Cannot find path '$LogPath' because it does not exist."
                continue
            }

            $LogCount = $LogsToCompress.Count
            $SiteCode = Split-Path -Path $LogPath -Leaf

            if ( $null -eq $LogCount -or $LogCount -eq 0 ) {
                Write-Warning -Message "No log files older than $($ArchiveMonth.ToString($DisplayFormat)) found in path '$LogPath'"
                continue
            }

            Write-Verbose -Message "Found $LogCount log(s) to be processed"
            $LogHash = @{}
            foreach ( $LogFile in $LogsToCompress ) {
                $LogHash.Add($LogFile.FullName,$LogFile.LastWriteTime.ToString($FileFormat))
            }
            $LogHash = $LogHash.GetEnumerator() | Sort-Object -Property Value,Name
            $ZipMonths = @($LogHash | Group-Object -Property Value | Select-Object -Property Name)

            foreach ( $Month in $ZipMonths ) {
                $ZipFileName = "$LogPath\$env:ComputerName-$SiteCode-$($Month.Name).zip"
                if( -not ( Test-Path -Path $ZipFileName ) ) {
                    Set-Content $ZipFileName ("PK" + [char]5 + [char]6 + ("$([char]0)" * 18))
                    (Get-Item -Path $ZipFileName).IsReadOnly = $false
                }

                $ZipPackage = (New-Object -Com Shell.Application).NameSpace($ZipFileName)
                $FilesForZip = $LogHash | Where-Object { $PSItem.Value -eq "$($Month.Name)" }

                foreach ( $File in $FilesForZip ) {
                    $FileName = $File.Key.ToString()
                    Write-Verbose -Message "Adding file '$FileName' to archive '$ZipFileName'"
                    $ZipPackage.CopyHere("$FileName", 0x14)
                    # TODO: Replace sleep with wait
                    Start-Sleep -Seconds 2
                }

                Write-Verbose -Message "$($ZipPackage.Items().Count) logs of $($FilesForZip.Count) have been written to the archive"
                if ( $ZipPackage.Items().Count -eq $FilesForZip.Count ) {
                    foreach ( $File in $FilesForZip ) {
                        $FileName = $File.Key.ToString()
                        Remove-Item -Path $FileName
                    }
                }
            }
        }
    }
}
