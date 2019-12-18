---
external help file: ServerManagement-help.xml
Module Name: ServerManagement
online version: http://psservermanagement.readthedocs.io/en/latest/functions/Invoke-LogRotation
schema: 2.0.0
---

# Invoke-LogRotation

## SYNOPSIS
Compresses log files by month.

## SYNTAX

```
Invoke-LogRotation [-Path] <String[]> [[-KeepRaw] <Int32>] [-KeepArchives <Int32>] [-Include <String>]
 [-Exclude <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Invoke-LogRotation cmdlet retrieves a list of log file in the specified locations and compressed them into a ZIP archive by month. 
Once the contents of the archive are verified the original log files are deleted.

## EXAMPLES

### EXAMPLE 1
```
Invoke-LogRotation -Path C:\Inetpub\Logs\LogFiles\W3SVC1
Archives the log files for the IIS 'Default Website' using the default 5 day retention
```

### EXAMPLE 2
```
Invoke-LogRotation -Path C:\Inetpub\Logs\LogFiles\W3SVC1 -KeepRaw 10
Archives the log files for the IIS 'Default Website' using the specified 10 day retention
```

## PARAMETERS

### -Path
Specifies a path to one or more locations. 
Invoke-LogRotation processes the log files in the specified locations.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeepRaw
Specifies the number of days to keep uncompressed log files. 
If you do not specify this parameter, the cmdlet will retain 5 days.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: CompressDays

Required: False
Position: 2
Default value: 5
Accept pipeline input: False
Accept wildcard characters: False
```

### -KeepArchives
Specifies the number of months to keep compresses log archives. 
If you do not specify this parameter, the archives will be retained indefinately.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Include
Specifies a wildcard selection string of files to include.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: *.log
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Specifies a wildcard selection string of files to exclude.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Trent Willingham
Check out my other projects on GitHub https://github.com/twillin912

## RELATED LINKS

[http://psservermanagement.readthedocs.io/en/latest/functions/Invoke-LogRotation](http://psservermanagement.readthedocs.io/en/latest/functions/Invoke-LogRotation)

