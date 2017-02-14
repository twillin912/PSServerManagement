function Get-DfsrBacklog {
    <#
    .SYNOPSIS
        The Get-DfsrBacklog get the DFSR inbound replication backlog.
    .DESCRIPTION
        This cmdlet queries the specified computer and its replication parteners for DFS replication senarios and their current inbound replication backlog.  The connection are made using CIM and WMI.
    .PARAMETER ComputerName
        The name of the computer to query for DFS replication senarios.  This defaults to the local machine if no value is given.
    .PARAMETER FolderName
        The name of the replicated folder.  If no value is provided, then all folders are returned.
    .EXAMPLE
        Get-DfsrBacklog -ComputerName 'MyServer'
        Retrieves all configured replicated folders and their inbound backlog from each partner.
    .EXAMPLE
        Get-DfsrBacklog -ComputerName 'MyServer' -FolderName 'Folder01'
        Retrieves the replicated folder 'Folder01' and its inbound backlog from each partner.
    .LINK
        https://github.com/twillin912/ServerManagementTools
    .NOTES
        Author: Trent Willingham
        Check out my other projects on GitHub https://github.com/twillin912
    #>
    [CmdletBinding()]
    [OutputType([PSObject])]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWMICmdlet", "", Scope="Function", Target="*")]
    Param
    (
        [Parameter()]
        [string[]] $ComputerName = "localhost",

        [Parameter()]
        [string[]] $FolderName
    )

    Begin {
        $Output = @()
    }

    Process {
        foreach ( $Computer in $ComputerName ) {
            if ( ! ( Test-Connection -ComputerName $Computer -Count 1 -Quiet ) ) {
                Write-Error -Message "Cannot connect to '$Computer' because it is offline."
                continue
            }

            try {
                $DfsrConnInfo = Get-CimInstance -ComputerName $Computer -Namespace 'root\MicrosoftDFS' -ClassName 'DfsrConnectionInfo' -ErrorAction Stop
                $DfsrFolderInfo = Get-CimInstance -ComputerName $Computer -Namespace 'root\MicrosoftDFS' -ClassName 'DfsrReplicatedFolderInfo' -ErrorAction Stop
            }
            catch {
                Write-Warning -Message 'Cannot bind to CIM instance on $Computer, failing back to WMI.'
                $WmiFailback = $true
                $DfsrConnInfo = Get-WmiObject -ComputerName $Computer -Namespace 'root\MicrosoftDFS' -Class 'DfsrConnectionInfo'
                $DfsrFolderInfo = Get-WmiObject -ComputerName $Computer -Namespace 'root\MicrosoftDFS' -Class 'DfsrReplicatedFolderInfo'
            }
            if ( -not ( $DfsrConnInfo -and $DfsrFolderInfo ) ) {
                Write-Error -Message "Cannot bind to DfsrReplicated classes."
            }

            if ( $FolderName ) {
                $DfsrFolderInfo = $DfsrFolderInfo | Where-Object { $PSItem.ReplicatedFolderName -in $FolderName }
            }

            foreach ( $Folder in $DfsrFolderInfo ) {

                $FolderValues = @{
                    'FolderName'    = $Folder.ReplicatedFolderName
                    'GroupName'     = $Folder.ReplicationGroupName
                    'State'         = $Folder.State
                }

                if ( $WmiFailback ) {
                    $VersionVector = (Invoke-WmiMethod -InputObject $Folder -Name 'GetVersionVector').VersionVector
                } else {
                    $VersionVector = (Invoke-CimMethod -InputObject $Folder -MethodName 'GetVersionVector').VersionVector
                }


                $InboundPartner = $DfsrConnInfo | Where-Object { $PSItem.ReplicationGroupGUID -eq $Folder.ReplicationGroupGUID -and $PSItem.Inbound -eq $true }
                foreach ( $Partner in $InboundPartner ) {
                    try {
                        $ParterFolderInfo = Get-CimInstance -ComputerName $Partner.PartnerName -Namespace 'root\MicrosoftDFS' -ClassName 'DfsrReplicatedFolderInfo' -ErrorAction SilentlyContinue
                        $PartnerFolder = $ParterFolderInfo | Where-Object { $PSItem.ReplicatedFolderGuid -eq $Folder.ReplicatedFolderGuid }
                        $Backlog = Invoke-CimMethod -InputObject $PartnerFolder -MethodName 'GetOutboundBacklogFileCount' -Arguments @{ VersionVector = $VersionVector }

                    }
                    catch {
                        Write-Verbose -Message 'Cannot bind to CIM instance on $($Partner.PartnerName), failing back to WMI.'
                        $ParterFolderInfo = Get-WmiObject -ComputerName $Partner.PartnerName -Namespace 'root\MicrosoftDFS' -Class 'DfsrReplicatedFolderInfo'
                        $PartnerFolder = $ParterFolderInfo | Where-Object { $PSItem.ReplicatedFolderGuid -eq $Folder.ReplicatedFolderGuid }
                        $Backlog = $PartnerFolder.GetOutboundBacklogFileCount($VersionVector)
                    }
                    finally {
                        $OutputValues = $FolderValues.Clone()
                        $OutputValues.Add('PartnerName',$Partner.PartnerName)
                        $OutputValues.Add('Backlog',$Backlog.BacklogFileCount)
                        $OutputObject = New-Object -TypeName PSObject -Property $OutputValues
                        $OutputObject.PSObject.TypeNames.Insert(0,'ServerManagementTools.DFS.Backlog')
                        $Output += $OutputObject
                    }
                } #foreach Partner
            } #foreach Folder
        } #foreach Computer
        Write-Output -InputObject $Output
    } #Process
}
