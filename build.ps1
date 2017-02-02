[CmdletBinding()]
Param (
    [string[]] $Task = 'default'
)

$RequiredModules = @('Pester', 'PlatyPS', 'Psake', 'PSScriptAnalyzer')

Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null
foreach ( $Module in $RequiredModules ) {
    if ( ! ( Get-Module -Name $Module -ListAvailable ) ) { Install-Module -Module $Module -Force | Out-Null }
}

Invoke-psake -buildFile "$PSScriptRoot\build\build.psake.ps1" -taskList $Task -Verbose:$VerbosePreference
