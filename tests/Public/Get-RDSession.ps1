[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot/../Shared.ps1

InModuleScope -ModuleName 'ServerManagementTools' {
    Describe 'Get-RDSession Function' {
        Context 'Unit testing' {
            It '' {

            }
        }
    }
}
