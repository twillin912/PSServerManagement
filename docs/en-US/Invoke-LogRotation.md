---
external help file: ServerManagementTools-help.xml
online version: https://github.com/twillin912/ServerManagementTools
schema: 2.0.0
---

# Invoke-LogRotation

## SYNOPSIS
Compresses log files by month.

## SYNTAX

```
Invoke-LogRotation [-Path] <String[]> [[-CompressDays] <Int32>] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Invoke-LogRotation cmdlet retrieves a list of log file in the specified locations and compressed them into a ZIP archive by month. 
Once the contents of the archive are verified the original log files are deleted.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Invoke-LogRotation -Path C:\Inetpub\Logs\LogFiles\W3SVC1
```

Archives the log files for the IIS 'Default Website' using the default 5 day retention

### -------------------------- EXAMPLE 2 --------------------------
```
Invoke-LogRotation -Path C:\Inetpub\Logs\LogFiles\W3SVC1 -CompressDays 10
```

Archives the log files for the IIS 'Default Website' using the specified 10 day retention

## PARAMETERS

### -Path
Specifies a path to one or more locations. 
Invoke-LogRotation processes the log files in the specified locations.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CompressDays
Specifies the number of days to keep uncompressed log files. 
If you do not specify this parameter, the cmdlet will retain 5 days.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES
Author: Trent Willingham
Check out my other projects on GitHub https://github.com/twillin912

## RELATED LINKS

[https://github.com/twillin912/ServerManagementTools](https://github.com/twillin912/ServerManagementTools)
