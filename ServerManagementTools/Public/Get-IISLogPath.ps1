function Get-IISLogPath {
    <#
    .SYNOPSIS
        Retrieve webiste logging path.
    .DESCRIPTION
        The Get-IISLogPath cmdlet retrieves the log file path for one or more websites configured on the target computer.
    .PARAMETER Name
        Specifies a name of one or more websites.  Get-IISLogPath retrieves the logging path for the website specified.  If you do not specify this parameter, the cmdlet will return all configured sites.
    .EXAMPLE
        Get-IISLogPath
        Returns log path information for all sites
    .EXAMPLE
        Get-IISLogPath -Name 'Default Web Site'
        Returns log path information for the 'Default Web Site'
    .EXAMPLE
        Get-IISLogPath -Name 'Admin*'
        Returns log path information for all sites whose Name begin with 'Admin'
    .EXAMPLE
        Get-IISLogPath -Name @('MySite1','MySite2')
        Returns log path information for the sites 'MySite1' and 'MySite2'
    .LINK
        http://servermanagementtools.readthedocs.io/en/stable/functions/Get-IISLogPath
    .NOTES
        Author: Trent Willingham
        Check out my other scripts and projects @ https://github.com/twillin912
    #>

    [CmdletBinding()]
    [OutputType([PSObject])]
    Param (
        [Parameter(ValueFromPipeline=$true)]
        [string[]] $Name
    )

    Begin {
        $WebsiteObjects = Get-Website
        $FilteredSites = @()
    }

    Process {
        if ( $Name ) {
            foreach ( $SiteName in $Name ) {
                $FilteredSites += $WebsiteObjects | Where-Object { $PSItem.Name -like $Sitename }
            }
        } else {
            $FilteredSites = $WebsiteObjects
        }

        foreach ( $Site in $FilteredSites ) {
            $LogPath = "$($Site.logFile.directory)\W3SVC$($Site.id)"
            $LogPath = [System.Environment]::ExpandEnvironmentVariables($LogPath)

            $Object = New-Object -TypeName PSCustomObject -Property @{
                Id          = $Site.id
                Name        = $Site.name
                LogPath     = $LogPath
            }
            $Object.PSObject.TypeNames.Insert(0, 'ServerManagementTools.IISLogPath')
            Write-Output -InputObject $Object
        }
    }
} #end function
