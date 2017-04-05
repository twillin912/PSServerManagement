[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot/../Shared.ps1

InModuleScope -ModuleName 'ServerManagementTools' {
    Describe 'Get-DfsrBacklogStatus Function' {
        function Invoke-CimMethod {
            [CmdletBinding()]
            param ( $InputObject, $MethodName, $Arguments )
        }
        function Invoke-WmiMethod {
            [CmdletBinding()]
            param ( $InputObject, $Name, $ArgumentList )
        }

        $FolderInfo = @()
        $FolderInfo += New-Object -TypeName PSCustomObject -Property @{
            ReplicatedFolderGUID = 'a60ffaf2-b4c4-44db-88b4-ec021c9554df'; ReplicatedFolderName = 'Folder01'
            ReplicationGroupGUID = 'b88b534f-4ce0-4e70-8ee3-0507078c8bc0'; ReplicationGroupName = 'ReplGroup'
            State = 4
        }

        $FolderInfo += New-Object -TypeName PSCustomObject -Property @{
            ReplicatedFolderGUID = '8452a016-fd9a-4b39-9de3-99c3d68225de'; ReplicatedFolderName = 'Folder02'
            ReplicationGroupGUID = 'b88b534f-4ce0-4e70-8ee3-0507078c8bc0'; ReplicationGroupName = 'ReplGroup'
            State = 4
        }

        $ConnectInbound = @{ Inbound = $true; PartnerName = ''; ReplicationGroupGUID = 'b88b534f-4ce0-4e70-8ee3-0507078c8bc0' }
        $ConnectOutbound = @{ Inbound = $false; PartnerName = ''; ReplicationGroupGUID = 'b88b534f-4ce0-4e70-8ee3-0507078c8bc0' }

        $WarningPrefs = @{ WarningAction = 'SilentlyContinue'; WarningVariable = 'WarnOut' }
        $ErrorPrefs = @{ ErrorAction = 'SilentlyContinue'; ErrorVariable = 'ErrorOut' }

        $CimTest = New-Object -TypeName PSCustomObject -Property @{
            Source = 'Server01'; CimPartner = 'Server02'; WmiPartner = 'Server03'; ConnectInfo = @()
        }
        $ConnectInbound['PartnerName'] = $CimTest.CimPartner
        $CimTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectInbound
        $ConnectInbound['PartnerName'] = $CimTest.WmiPartner
        $CimTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectInbound
        $ConnectOutbound['PartnerName'] = $CimTest.CimPartner
        $CimTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectOutbound
        $ConnectOutbound['PartnerName'] = $CimTest.WmiPartner
        $CimTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectOutbound

        $WmiTest = New-Object -TypeName PSCustomObject -Property @{
            Source = 'Server11'; CimPartner = 'Server12'; WmiPartner = 'Server13'; ConnectInfo = @()
        }
        $ConnectInbound['PartnerName'] = $WmiTest.CimPartner
        $WmiTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectInbound
        $ConnectInbound['PartnerName'] = $WmiTest.WmiPartner
        $WmiTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectInbound
        $ConnectOutbound['PartnerName'] = $WmiTest.CimPartner
        $WmiTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectOutbound
        $ConnectOutbound['PartnerName'] = $WmiTest.WmiPartner
        $WmiTest.ConnectInfo += New-Object -TypeName PSCustomObject -Property $ConnectOutbound

        $BrokenComputer = 'Server31'
        $OfflineComputer = 'Server32'

        $CimServers = @($CimTest.Source, $CimTest.CimPartner, $WmiTest.CimPartner)
        $WmiServers = @($WmiTest.Source, $CimTest.WmiPartner, $WmiTest.WmiPartner)

        Mock -CommandName 'Test-Connection' -MockWith { $true }
        Mock -CommandName 'Test-Connection' -MockWith { $false } -ParameterFilter { $ComputerName -eq $OfflineComputer }

        Mock -CommandName 'Get-CimInstance' -MockWith { Write-Error "MockNoCimSupport" }
        Mock -CommandName 'Get-CimInstance' -MockWith { $CimTest.ConnectInfo } -ParameterFilter {
            $ComputerName -eq $CimTest.Source -and $ClassName -eq 'DfsrConnectionInfo' }
        Mock -CommandName 'Get-CimInstance' -MockWith { $FolderInfo } -ParameterFilter {
            $ComputerName -in $CimServers -and $ClassName -eq 'DfsrReplicatedFolderInfo' }

        Mock -CommandName 'Get-WmiObject' -MockWith { $WmiTest.ConnectInfo } -ParameterFilter {
            $ComputerName -eq $WmiTest.Source -and $Class -eq 'DfsrConnectionInfo' }
        Mock -CommandName 'Get-WmiObject' -MockWith { $FolderInfo } -ParameterFilter {
            $ComputerName -in $WmiServers -and $Class -eq 'DfsrReplicatedFolderInfo' }
        Mock -CommandName 'Get-WmiObject' -MockWith { } -ParameterFilter { $ComputerName -eq $BrokenComputer }

        Mock -CommandName 'Invoke-CimMethod' -MockWith { } -ParameterFilter { $MethodName -eq 'GetVersionVector' }
        Mock -CommandName 'Invoke-WmiMethod' -MockWith { } -ParameterFilter { $Name -eq 'GetVersionVector' }

        Mock -CommandName 'Invoke-CimMethod' -MockWith { } -ParameterFilter { $MethodName -eq 'GetOutboundBacklogFileCount' }
        Mock -CommandName 'Invoke-WmiMethod' -MockWith { } -ParameterFilter { $Name -eq 'GetOutboundBacklogFileCount' }

        Context 'CIM Compatible Server' {

            Get-DfsrBacklogStatus -ComputerName $CimTest.Source @WarningPrefs @ErrorPrefs

            It 'Calls Test-Connection to verify computer is reachable'  {
                $MockParams = @{
                    CommandName = 'Test-Connection'; Exactly = $true; Times = 1
                    ParameterFilter = { $ComputerName -eq $CimTest.Source }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrConnectionInfo" CIM class from target computer'  {
                $MockParams = @{
                    CommandName = 'Get-CimInstance'; Exactly = $true; Times = 1
                    ParameterFilter = {
                        $ComputerName -eq $CimTest.Source -and $ClassName -eq 'DfsrConnectionInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" CIM class from target computer'  {
                $MockParams = @{
                    CommandName = 'Get-CimInstance'; Exactly = $true; Times = 1
                    ParameterFilter = {
                        $ComputerName -eq $CimTest.Source -and $ClassName -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "VersionVector" for each replicated folder'  {
                $MockParams = @{
                    CommandName = 'Invoke-CimMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $MethodName -eq 'GetVersionVector' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" CIM class from partner'  {
                $MockParams = @{
                    CommandName = 'Get-CimInstance'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = {
                        $ComputerName -eq $CimTest.CimPartner -and $ClassName -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" WMI class from partner'  {
                $MockParams = @{
                    CommandName = 'Get-WmiObject'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = {
                        $ComputerName -eq $CimTest.WmiPartner -and $Class -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Calls Invoke-CimMethod for each partner and folder to get backlog'  {
                $MockParams = @{
                    CommandName = 'Invoke-CimMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $MethodName -eq 'GetOutboundBacklogFileCount' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Calls Invoke-WmiMethod for each partner and folder to get backlog'  {
                $MockParams = @{
                    CommandName = 'Invoke-WmiMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $Name -eq 'GetOutboundBacklogFileCount' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Generates warning when falling back to WMI' {
                $WarnOut.Count | Should Be 2
            }

            It 'Does not generate errors' {
                $FilteredErrors = $ErrorOut | Where-Object { $PSItem.Exception -notmatch 'MockNoCimSupport' }
                $FilteredErrors.Exception | Should BeNullOrEmpty
            }
        }

        Context 'Non CIM Compatible Server' {
            $ErrOut = $null
            $Return = Get-DfsrBacklogStatus -ComputerName $WmiTest.Source @WarningPrefs @ErrorPrefs

            It 'Calls Test-Connection to verify computer is reachable'  {
                $MockParams = @{
                    CommandName = 'Test-Connection'; Exactly = $true; Times = 1
                    ParameterFilter = { $ComputerName -eq $WmiTest.Source }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrConnectionInfo" WMI class from target computer'  {
                $MockParams = @{
                    CommandName = 'Get-WmiObject'; Exactly = $true; Times = 1
                    ParameterFilter = {
                        $ComputerName -eq $WmiTest.Source -and $Class -eq 'DfsrConnectionInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" WMI class from target computer'  {
                $MockParams = @{
                    CommandName = 'Get-WmiObject'; Exactly = $true; Times = 1
                    ParameterFilter = {
                        $ComputerName -eq $WmiTest.Source -and $Class -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "VersionVector" for each replicated folder'  {
                $MockParams = @{
                    CommandName = 'Invoke-WmiMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $Name -eq 'GetVersionVector' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" CIM class from partner'  {
                $MockParams = @{
                    CommandName = 'Get-CimInstance'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = {
                        $ComputerName -eq $WmiTest.CimPartner -and $ClassName -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Retrieve "DfsrReplicatedFolderInfo" WMI class from partner'  {
                $MockParams = @{
                    CommandName = 'Get-WmiObject'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = {
                        $ComputerName -eq $WmiTest.WmiPartner -and $Class -eq 'DfsrReplicatedFolderInfo'
                    }
                }
                Assert-MockCalled @MockParams
            }

            It 'Calls Invoke-CimMethod for each partner and folder to get backlog'  {
                $MockParams = @{
                    CommandName = 'Invoke-CimMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $MethodName -eq 'GetOutboundBacklogFileCount' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Calls Invoke-WmiMethod for each partner and folder to get backlog'  {
                $MockParams = @{
                    CommandName = 'Invoke-WmiMethod'; Exactly = $true; Times = $FolderInfo.Count
                    ParameterFilter = { $Name -eq 'GetOutboundBacklogFileCount' }
                }
                Assert-MockCalled @MockParams
            }

            It 'Generates warning when falling back to WMI' {
                $WarnOut.Count | Should Be 3
            }

            It 'Does not generate errors' {
                $FilteredErrors = $ErrorOut | Where-Object { $PSItem.Exception -notmatch 'MockNoCimSupport' }
                $FilteredErrors.Exception | Should BeNullOrEmpty
            }
        }

        Context 'Validate output' {
            $ReturnAll = Get-DfsrBacklogStatus -ComputerName $CimTest.Source @WarningPrefs @ErrorPrefs
            $ReturnFiltered = Get-DfsrBacklogStatus -ComputerName $CimTest.Source -FolderName 'Folder01' @WarningPrefs @ErrorPrefs

            It 'Returns a PSObject with type "BacklogStatus"' {
                ($ReturnAll | GM).TypeName | Should Match 'BacklogStatus'
            }

            It 'Returns four entries without Folder filter' {
                $ReturnAll.Count | Should Be 4
            }

            It 'Returns two entries with Folder filter' {
                $ReturnFiltered.Count | Should Be 2
            }


        }

        Context 'DFS Replication Not Installed' {
            Get-DfsrBacklogStatus -ComputerName $BrokenComputer  @WarningPrefs @ErrorPrefs
            It 'Should throw an error' {
                $ErrorOut | Should Not BeNullOrEmpty
            }
            It 'Error should contain descriptive message' {
                $FilteredErrors = $ErrorOut | Where-Object { $PSItem.Exception -notmatch 'MockNoCimSupport' }
                $FilteredErrors.Exception | Should Match "Cannot bind .* '$BrokenComputer'."
            }
        }

        Context 'Offline Server' {
            Get-DfsrBacklogStatus -ComputerName $OfflineComputer  @WarningPrefs @ErrorPrefs
            It 'Should throw an error' {
                $ErrorOut | Should Not BeNullOrEmpty
            }

            It 'Error should contain descriptive message' {
                $ErrorOut.Exception -match $OfflineComputer | Should Be $true
            }
        }
    }
}
