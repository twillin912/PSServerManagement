# ServerManagement Release History

## v0.5 (2018-04-24)

- New Functions

  - The `Get-LinuxCdpInfo` cmdlet queries a Linux server for CDP information by capturing the network packets using tcpdump.
  - The `Install-DiskCleanupTool` cmdlet copies the Disk Cleanup executable and supporting files from the WinSxS folder the to correct installed location and creates the shortcut.

- Updates

  - Invoke-LogRotation: Refactored the parameter name 'CompressDays' to 'KeepRaw'
  - Register-LogRotationTask: Refactored the parameter name 'CompressDays' to 'KeepRaw'


## v0.4 (2017-04-05)

- New Functions

  - The `Disable-SChannelFeature` cmdlet disables features in the SChannel security suite on Windows computers.  This cmdlet can be used to disable ciphers, key exchanges, and protocols that are consider insecure.
  - The `Get-RDSession` cmdlet uses the Cassia.dll to query local or remote computers for active and disconnection Remote Desktop sessions.

- Updates

  - Updated the build process use utilize the InvokeBuild module.

## v0.3 (2017-02-17)

- New Functions
  - `Get-IISLogPath`: This function uses the WebAdministration module to query the IIS configuration and retreive the log file locations.

## v0.2 (2017-02-16)

- New Functions
  - `Invoke-LogRotation`: Compresses log files by month

## v0.1 (2017-02-15)

- New Functions
  - `Get-DfsrBacklogStatus`: Query DFSR replication backlog
