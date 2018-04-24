# What is new in ServerManagementTools v0.5

## New Functions

- The `Get-LinuxCdpInfo` cmdlet queries a Linux server for CDP information by capturing the network packets using tcpdump.

- The `Install-DiskCleanupTool` cmdlet copies the Disk Cleanup executable and supporting files from the WinSxS folder the to correct installed location and creates the shortcut.

## Updates

- Invoke-LogRotation: Refactored the parameter name 'CompressDays' to 'KeepRaw'
- Register-LogRotationTask: Refactored the parameter name 'CompressDays' to 'KeepRaw'
