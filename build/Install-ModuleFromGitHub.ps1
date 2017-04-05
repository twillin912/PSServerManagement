<#
#>
[CmdletBinding()]
param (
    #[Parameter(Mandatory=$true)]
    #[ValidateNotNullOrEmpty]
    [string] $Repository = 'twillin912/ServerManagementTools',

    [Parameter()]
    [ValidateSet('CurrentUser','AllUsers')]
    [string] $Scope = 'CurrentUser'
)

process {
    $ModuleName = ($Repository -split '/')[1]
    $DownloadFile = "$env:TEMP/Module.zip"
    $RequestUri = "https://github.com/$Repository/archive/develop.zip"
    Invoke-WebRequest -Uri $RequestUri -OutFile $DownloadFile


}

end { }
