---
external help file: ServerManagement-help.xml
Module Name: ServerManagement
online version: http://psservermanagement.readthedocs.io/en/latest/functions/Install-DiskCleanupTool
schema: 2.0.0
---

# Install-DiskCleanupTool

## SYNOPSIS
Install Disk Cleanup utlility.

## SYNTAX

```
Install-DiskCleanupTool [[-ComputerName] <String[]>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Copies the Disk Cleanup utility and supporting files from the WinSxS folder on the system to the installed locations and created a shortcut in the Administrative Tools folder.

## EXAMPLES

### EXAMPLE 1
```
Install-DiskCleanupTools
Installs the Disk Cleanup utility on the local system.
```

### EXAMPLE 2
```
Install-DiskCleanupTools -ComputerName Server01
Installs the Disk Cleanup utility on the system named 'Server01'.
```

## PARAMETERS

### -ComputerName
Specifies the name of the computer to query. 
Default value is the local computer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
{{ Fill Credential Description }}

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### ComputerName as String or Array of strings
## OUTPUTS

### None
## NOTES
Author: Trent Willingham
Check out my other projects on GitHub https://github.com/twillin912

## RELATED LINKS

[http://psservermanagement.readthedocs.io/en/latest/functions/Install-DiskCleanupTool](http://psservermanagement.readthedocs.io/en/latest/functions/Install-DiskCleanupTool)

