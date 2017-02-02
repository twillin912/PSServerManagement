function Get-IISLogPath {
    <#
    .SYNOPSIS
        Get the configured IIS log file path for one or more websites
    .DESCRIPTION
        Reads the IIS website configuration data to determine the log file path for the given website
    .PARAMETER Name
        Optional parameter the specifies the name of the website
    .EXAMPLE
        Get-IISLogPath
        Get log file path for all configured websites
    .EXAMPLE
        Get-IISLogPath -Name 'Default Web Site'
        Get log file path for the website named 'Default Web Site'
    .LINK
        https://github.com/twillin912/ServerManagementTools
    .NOTES
        Author: Trent Willingham
        Check out my other scripts and projects @ https://github.com/twillin912
    #>

    [CmdletBinding()]
    [OutputType([PSObject])]
    Param (
        [Parameter()]
        [string[]] $Name
    )

    Begin {
        $WebsiteObjects = @()
    }

    Process {
        if ( $PSBoundParameters.ContainsKey('Name') ) {
            foreach ( $SiteName in $Name ) {
                $WebsiteObjects += Get-Website -Name $SiteName
            }
        } else {
            $WebsiteObjects = Get-Website
        }

        foreach ( $Website in $WebsiteObjects ) {
            $LogPath = "$($Website.logFile.directory)\W3SVC$($Website.id)"
            $LogPath = [System.Environment]::ExpandEnvironmentVariables($LogPath)

            $Object = New-Object -TypeName PSObject -Property @{
                Id          = $Website.id
                Name        = $Website.name
                LogPath     = $LogPath
            }
            $Object.PSObject.TypeNames.Insert(0, 'ServerManagementTools.IISLogPath')
            Write-Output -InputObject $Object
        }
    }
} #end function
