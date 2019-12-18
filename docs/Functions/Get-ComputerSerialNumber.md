---
external help file: ServerManagement-help.xml
Module Name: ServerManagement
online version: http://psservermanagement.readthedocs.io/en/latest/functions/Disable-SChannelFeature
schema: 2.0.0
---

# Get-ComputerSerialNumber

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### Default (Default)
```
Get-ComputerSerialNumber [-ComputerName] <String[]> [[-Credentials] <PSCredential>] [<CommonParameters>]
```

### Linux
```
Get-ComputerSerialNumber [-ComputerName] <String[]> [-Credentials] <PSCredential> [-Linux] [<CommonParameters>]
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -ComputerName
{{Fill ComputerName Description}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credentials
{{Fill Credentials Description}}

```yaml
Type: PSCredential
Parameter Sets: Default
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: PSCredential
Parameter Sets: Linux
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Linux
{{Fill Linux Description}}

```yaml
Type: SwitchParameter
Parameter Sets: Linux
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
