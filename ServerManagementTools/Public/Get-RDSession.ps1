function Get-RDSession {
    <#
    .SYNOPSIS
        Lists Remote Desktop sessions on a given server.
    .DESCRIPTION
        The Get-RDSession cmdlet retrieves a list of Remote Desktop sessions from a local or remote computer.
    .PARAMETER ComputerName
        Specifies the name of the computer to query.  Default value is the local computer.
    .PARAMETER UserName

    .EXAMPLE
    .EXAMPLE
    .NOTES
    .LINK
        https://github.com/twillin912/ServerManagementTools
    .LINK
        http://code.msdn.microsoft.com/PSTerminalServices
    .LINK
        http://code.google.com/p/cassia/
    #>

    [CmdletBinding()]
    [OutputType('Cassia.Impl.TerminalServicesSession')]

    param (
        [Parameter(
            ValueFromPipelineByPropertyName=$true
        )]
        [Alias('DSNHostName','Name','Computer')]
        [string] $ComputerName='localhost',

        [Parameter()]
        [ValidateSet('Active','Connected','ConnectQuery','Disconnected','Down','Idle','Initializing','Listening','Reset','Shadowing')]
        [Alias('ConnectionState')]
        [string] $State='*',

        [Parameter()]
        [string] $ClientName='*',

        [Parameter()]
        [string] $UserName='*'
    )

    begin {
        try {
            Write-Verbose -Message 'Creating instance of the Cassia TSManager.'
            $TSManager = New-Object -TypeName Cassia.TerminalServicesManager
        }
        catch {
            throw
        }
    }

    process {
        Write-Debug -Message "ComputerName: $ComputerName"
        Write-Verbose -Message "Attempting remote connection to '$ComputerName'."
        if (!(Test-Connection -ComputerName $ComputerName -Count 1 -Quiet)) {
            Write-Warning -Message ('Cannot connect to "{0}" because it is offline.' -f $ComputerName)
            return
        }
        try {
            $TSRemoteServer = $TSManager.GetRemoteServer($ComputerName)
            $TSRemoteServer.Open()
            if (!($TSRemoteServer.IsOpen)) {
                throw ('Remote connection to "{0}" failed.' -f $ComputerName)
            }

            $Session = $TSRemoteServer.GetSessions()
            if ($Session) {
                $Session | Where-Object {$_.ConnectionState -like $State -and $_.UserName -like $UserName -and $_.ClientName -like $ClientName} |
                Add-Member -MemberType AliasProperty -Name IPAddress -Value ClientIPAddress -PassThru |
                Add-Member -MemberType AliasProperty State -Value ConnectionState -PassThru
            }
        }
        catch {
            throw
        }
        finally {
            $TSRemoteServer.Close()
            $TSRemoteServer.Dispose()
        }
    }

    end { }
}
