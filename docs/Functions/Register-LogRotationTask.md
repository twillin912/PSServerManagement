---
external help file: ServerManagementTools-help.xml
Module Name: ServerManagementTools
online version: http://servermanagementtools.readthedocs.io/en/stable/functions/Invoke-LogRotation
schema: 2.0.0
---

# Register-LogRotationTask

## SYNOPSIS
Short description

## SYNTAX

```
Register-LogRotationTask [-Name] <String> [-Path] <String[]> [[-KeepRaw] <Int32>] [-StartTime <String>]
 [-Include <String>] [-Exclude <String>] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
An example
```

## PARAMETERS

### -Name
Specifies the name of the scheduled task with ' - LogRotation' appended.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specifies a path to one or more locations. 
Invoke-LogRotation processes the log files in the specified locations.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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
Position: 4
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTime
Specifies the start time for the scheduled task. 
The default value is 10:00 PM.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 22:00
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
Default value: None
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
