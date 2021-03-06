[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot/../Shared.ps1

InModuleScope -ModuleName $env:BHProjectName {
    Describe 'Invoke-LogRotation' {

        Context 'Mock unit tests' {
            Mock -CommandName Test-Path -MockWith { $true }
            Mock -CommandName Get-ChildItem -MockWith { }

            It 'Calls Test-Path to verify $Path exists' {
                Invoke-LogRotation -Path 'Path1'
                Assert-MockCalled -CommandName 'Test-Path' -Scope 'It' -Times 1 -Exactly
            }

            It 'Accepts array of Path values' {
                Invoke-LogRotation -Path 'Path2','Path3'
                Assert-MockCalled -CommandName 'Test-Path' -Scope 'It' -Times 2 -Exactly
            }

            It 'Calls Get-ChildItem to retrive log files in $Path' {
                Invoke-LogRotation -Path 'Path5'
                Assert-MockCalled -CommandName Get-ChildItem -Scope 'It' -Times 1 -Exactly
            }

            It 'Throws error if Test-Path fails' {
                Mock -CommandName Test-Path { $false }
                Invoke-LogRotation -Path 'Path4' -EA SilentlyContinue -EV ErrOut
                $ErrOut.Exception | Should Match "Cannot find path"
            }
        }

        Context 'Integration test' {
            In $TestDrive {
                $TestPath = 'Logs\W3SVC1'
                $TestFullPath = Join-Path $TestDrive $TestPath
                Setup -Path $TestPath -Dir

                for ( $i=0; $i -le 10; $i++ ) {
                    $FileDate = (Get-Date).AddDays(-$i)
                    $LabelDate = $FileDate.ToString('yyyyMMdd')
                    (Setup -File "$TestPath\ex_$LabelDate.log" -Content "Test" -PassThru | Get-Item).LastWriteTime = $FileDate
                }

                $Return = Invoke-LogRotation -Path $TestFullPath -CompressDays 3
                $LogFiles = Get-ChildItem -Path $TestFullPath -Include '*.log' -Recurse
                $ZipFiles = Get-ChildItem -Path $TestFullPath -Include '*.zip' -Recurse

                It 'Creates archive file' {
                    $ZipFiles.Count -ge 1 | Should Be True
                }

                It 'Archive name includes ComputerName' {
                    $ZipFiles.BaseName | Should Match $env:COMPUTERNAME
                }

                It 'Archive name includes folder name' {
                    $ZipFiles.BaseName | Should Match 'W3SVC1'
                }

                It 'Removes archived files' {
                    $LogFiles.Count | Should Be 4
                }

                It 'Should not have a return' {
                    $Return | Should BeNullOrEmpty
                }
            }
        }
    }
}
