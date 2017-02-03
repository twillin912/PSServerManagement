function Invoke-LogRotation {
    <#
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Medium'
    )]

    Param (
        [string[]] $Path,
        [string] $ArchivePath,
        [int] $CompressDays
    )

    Begin {
        $DateDisplayFormat = 'MM/dd/yyyy'
        $DateFileFormat = 'yyyy-MM'
        $CurrentDate = Get-Date -Hour 0 -Minute 0 -Second 0

        if ($CompressDays) {
            $CompressBefore = (Get-Date -Date $CurrentDate).AddDays(-$CompressDays)
        }

        $null = [Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" )

    }

    Process {
        foreach ( $LogPath in $Path ) {
            if ( ! ( Test-Path -Path $LogPath ) ) {
                Write-Error -Message "Cannot find path '$LogPath' because it does not exist."
                break
            }

            $LogFolder = Split-Path -Path $($LogPath) -Leaf

            if ( $CompressDays ) {
                $LogsToCompress = Get-ChildItem -Path "$($LogPath)" -Include '*.log' -Recurse |
                    Where-Object { $PSItem.PSIsContainer -eq $false -and $PSItem.LastWriteTime -lt $CompressBefore }
                Write-Verbose -Message "Compressing $($LogsToCompress.Count) older than $($CompressBefore.ToString($DateDisplayFormat))"

                $LogHashTable = @{}
                foreach ( $File in $LogsToCompress ) {
                    $LogHashTable.Add("$($File.FullName)","$($File.LastWriteTime.ToString($DateFileFormat))")
                }
                $LogHashTable = $LogHashTable.GetEnumerator() | Sort-Object -Property Value,Name
                $MonthsToProcess = @( $LogHashTable | Group-Object -Property Value | Select-Object -Property Name )

                foreach ( $Month in $MonthsToProcess ) {
                    $ZipFileName = "$($env:ComputerName)-$($LogFolder)-$($Month.Name).zip"
                    $ZipFullName = Join-Path -Path $LogPath -ChildPath $ZipFileName
                    $CurrentMonthLogs = $LogHashTable | Where-Object { $PSItem.Value -eq "$($Month.Name)" }

                    foreach ( $LogFile in $CurrentMonthLogs ) {
                        $LogName = Split-Path -Path "$($LogFile.Name)" -Leaf

                        if ( $PSCmdlet.ShouldProcess("$ZipFullName","Create/Update Archive") ) {
                            $ZipFile = [System.IO.Compression.ZipFile]::Open($ZipFullName, "Update")
                        }

                        if ( $PSCmdlet.ShouldProcess("$($LogFile.Name)","Get Content") ) {
                            $LogContent = Get-Content -Path $LogFile.Name -Raw
                        }

                        if ( ! ( $ZipFile.GetEntry($LogName) ) ) {
                            if ( $PSCmdlet.ShouldProcess("$($LogFile.Name)","Add to Archive") ) {
                                $ZipFileEntry = $ZipFile.CreateEntry($LogName)
                                $StreamWriter = [System.IO.StreamWriter] $ZipFileEntry.Open()
                                $StreamWriter.Write($LogContent)
                                $StreamWriter.Dispose()
                                $ZipFileEntry.LastWriteTime = (Get-Item -Path "$($LogFile.Name)").LastWriteTime
                            }
                        }

                        if ( $PSCmdlet.ShouldProcess("$ZipFullName","Save Archive") ) {
                            $ZipFile.Dispose()
                        }

                        if ( $PSCmdlet.ShouldProcess("$($LogFile.Name)","Compare to Archive") ) {
                            $ZipFile = [System.IO.Compression.ZipFile]::Open($ZipFullName, "Read")
                            $ZipFileEntry = [System.IO.StreamReader] $ZipFile.GetEntry($LogName).Open()
                            $ZipContent = $ZipFileEntry.ReadToEnd()
                            $ZipFile.Dispose()

                            if ( $ZipContent -eq $LogContent ) {
                                Remove-Item -Path $LogFile.Name
                            }
                        }
                        [System.GC]::Collect()
                    }
                }
            }
        }
    }

    End {

    }
}
