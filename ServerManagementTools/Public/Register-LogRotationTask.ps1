function Register-LogRotationTask {
    <#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>
    [CmdletBinding()]
    Param (
        # Parameter help description
        [Parameter(Mandatory, Position = 1)]
        [string] $Name,

        #
        [Parameter(Mandatory, Position = 2)]
        [string] $Path,

        #
        [Parameter(Position = 3)]
        [int] $CompressDays,

        #
        [Parameter()]
        [string] $StartTime = '22:00',

        #
        [Parameter()]
        [string] $Include,

        #
        [Parameter()]
        [string] $Exclude
    )

    $Command = "Invoke-LogRotation -Path '$Path'"
    if ( $CompressDays ) {
        $Command += " -CompressDays $CompressDays"
    }
    if ( $Include ) {
        $Command += " -Include '$Include'"
    }
    if ( $Exclude ) {
        $Command += " -Exclude '$Exclude'"
    }

    $TaskParams = @{
        TaskName    = "LogRotation - $Name"
        Trigger     = New-ScheduledTaskTrigger -At $StartTime -Daily
        User        = 'NT AUTHORITY\SYSTEM'
        Action      = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument "-NonInteractive -NoProfile -WindowStyle Hidden -Command `"$Command`""
    }
    Register-ScheduledTask @TaskParams -Force
}
