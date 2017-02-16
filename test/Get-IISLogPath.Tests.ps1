[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

InModuleScope -ModuleName 'ServerManagementTools' {
    Describe 'Get-IISLogPath' {

        Context 'Mock unit tests' {
            Mock -CommandName Get-Website { }
            Get-IISLogPath

            It 'Retrieve website configuration by calling Get-Website' {
                Assert-MockCalled -CommandName Get-Website -Scope 'It' -Times 1 -Exactly
            }
        }

        Context 'Integration test' {

        }
    }
}
