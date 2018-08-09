[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot/../Shared.ps1

InModuleScope -ModuleName $env:BHProjectName {
    function Get-Website {}
    Describe 'Get-IISLogPath' {
        $Website1 = [PSCustomObject]@{Id=1;Name='Default Web Site';logfile=[PSCustomObject]@{directory='%SystemDrive%\inetpub\Logs\Logfiles'}
        }
        $Website2 = [PSCustomObject]@{Id=2;Name='MyAdminSite';logfile=[PSCustomObject]@{directory='%SystemDrive%\inetpub\Logs\Logfiles'}
        }
        $Website3 = [PSCustomObject]@{Id=3;Name='MySite';logfile=[PSCustomObject]@{directory='%SystemDrive%\inetpub\Logs\Logfiles'}
        }
        $AllSites = @( $Website1, $Website2, $Website3 )

        Mock -CommandName 'Get-Website' -MockWith { return $AllSites }

        Context 'Mock unit tests' {

            It 'Retrieve website configuration by calling Get-Website' {
                Get-IISLogPath
                Assert-MockCalled -CommandName Get-Website -Scope 'It' -Times 1 -Exactly
            }

            It 'Calls Get-Website only once' {
                Get-IISLogPath -Name 'Site1','Site2'
                Assert-MockCalled -CommandName Get-Website -Scope 'It' -Times 1 -Exactly
            }

            It 'Accepts Name values from Pipeline' {
                @('Site1','Site2') | Get-IISLogPath
                Assert-MockCalled -CommandName Get-Website -Scope 'It' -Times 1 -Exactly
            }

        }

        Context 'Integration test' {
            It 'Without Name parameter, return all configured sites' {
                $Return = Get-IISLogPath
                ($Return | Get-Member).TypeName | Should Match 'ServerManagementTools.IISLogPath'
                $Return.Collection.Count | Should Be 3
            }

            It 'With valid Name parameter, returns only that site' {
                $Return = Get-IISLogPath -Name 'MyAdminSite'
                ($Return | Get-Member).TypeName | Should Match 'ServerManagementTools.IISLogPath'
                $Return.Collection | Should BeNullOrEmpty
                $Return | Should Not BeNullOrEmpty
            }

            It 'With invalid Name parameter, returns nothing' {
                $Return = Get-IISLogPath -Name 'NotMySite'
                $Return | Should BeNullOrEmpty
            }

            It 'Supports wildcard in Name parameter' {
                $Return = Get-IISLogPath -Name 'My*'
                ($Return | Get-Member).TypeName | Should Match 'ServerManagementTools.IISLogPath'
                $Return.Collection.Count | Should Be 2
            }

            It 'Supports array in Name parameter' {
                $Return = Get-IISLogPath -Name @('MyAdminSite','MySite')
                ($Return | Get-Member).TypeName | Should Match 'ServerManagementTools.IISLogPath'
                $Return.Collection.Count | Should Be 2
            }

        }
    }
}
