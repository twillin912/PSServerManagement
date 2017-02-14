[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1
<#
Describe 'Get-DfsrBacklog Function' {

    $ConnectInfo = New-Object -TypeName PSObject -Property @{
        Inbound                 = 'True'
        PartnerName             = 'Server02'
        ReplicationGroupGUID    = 'c0662e34-ed46-41c6-a89c-301b80f57a6d'
    }

    $FolderInfo = New-Object -TypeName PSObject -Property @{
        ReplicatedFolderName    = 'Folder01'
        ReplicatedFolderGUID    = '0c1b63e5-8d05-4bc6-92ba-10c901b2a899'
        ReplicationGroupName    = 'Group01'
        ReplicationGroupGUID    = 'c0662e34-ed46-41c6-a89c-301b80f57a6d'
        State                   = 'Active'
    }

    $BacklogInfo = @{

    }

    Mock -CommandName 'Test-Connection' -ParameterFilter { $ComputerName -iin @('Server01','Server02')} -MockWith { $true }
    Mock -CommandName 'Test-Connection' -ParameterFilter { $ComputerName -iin @('Server03')} -MockWith { $false }

    Mock -CommandName Get-CimInstance -ParameterFilter {
        $ComputerName -iin @( 'Server01' ) -and $ClassName -ieq 'DfsrConnectionInfo'
    } -MockWith { $ConnectInfo }

    Mock -CommandName Get-CimInstance -ParameterFilter {
        $ComputerName -ieq 'Server01' -and $ClassName -ieq 'DfsrReplicatedFolderInfo'
    } -MockWith { $FolderInfo }

    Mock -CommandName Get-WmiObject -ParameterFilter {
        $Class -ieq 'DfsrConnectionInfo'
    } -MockWith { $ConnectInfo }

    Mock -CommandName Get-WmiObject -ParameterFilter {
        $Class -ieq 'DfsrReplicatedFolderInfo'
    } -MockWith { $FolderInfo }

    Mock -CommandName Invoke-WmiMethod -MockWith { $true }

    Mock -CommandName Invoke-CimMethod -MockWith { $true }

    Mock -CommandName Get-CimInstance -ParameterFilter {
        $ComputerName -ieq 'Server02' -and $ClassName -ieq 'DfsrReplicatedFolderInfo'
    } -MockWith { [CimInstance]$FolderInfo }

    Get-DfsrBacklog -ComputerName 'Server01'

    It 'Verify computer is online' {
        $MockParams = @{
            CommandName     = 'Test-Connection'
            Exactly         = $false
            Scope           = 'It'
            Times           = 1
            ParameterFilter = {
                $ComputerName -eq 'Server01'
            }
        }
        Assert-MockCalled @MockParams
    }

    It 'Queries server CIM for DfsrConnectionInfo class' {
        $MockParams = @{
            CommandName     = 'Get-CimInstance'
            Exactly         = $false
            Scope           = 'It'
            Times           = 1
            ParameterFilter = {
                $ComputerName   -ieq 'Server01'
                $ClassName      -ieq 'DfsrConnectionInfo'
            }
        }
        Assert-MockCalled @MockParams
    }

    It 'Queries server CIM for DfsrReplicatedFolderInfo class' {
        $MockParams = @{
            CommandName     = 'Get-CimInstance'
            Exactly         = $true
            Scope           = 'It'
            Times           = 1
            ParameterFilter = {
                $ComputerName   -ieq 'Server01'
                $ClassName      -ieq 'DfsrReplicatedFolderInfo'
            }
        }
        Assert-MockCalled @MockParams
    }



    It 'Queries partner CIM for DfsrReplicatedFolderInfo class' {
        $MockParams = @{
            CommandName     = 'Get-CimInstance'
            Exactly         = $true
            Scope           = 'It'
            Times           = 1
            ParameterFilter = {
                $ComputerName   -ieq 'Server02'
                $ClassName      -ieq 'DfsrReplicatedFolderInfo'
            }
        }
        Assert-MockCalled @MockParams
    }

    It 'OutputType is PSObject' {
        (Get-Command Get-DfsrBacklog).OutputType.Type -icontains [PSObject] | Should be $true
    }

}
#>
