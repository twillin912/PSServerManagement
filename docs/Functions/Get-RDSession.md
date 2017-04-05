---
external help file: ServerManagementTools-help.xml
online version: https://github.com/twillin912/ServerManagementTools
schema: 2.0.0
---

# Get-RDSession

## SYNOPSIS
Lists Remote Desktop sessions on a given server.

## SYNTAX

```
Get-RDSession [[-ComputerName] <String>] [[-State] <String>] [[-ClientName] <String>] [[-UserName] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The Get-RDSession cmdlet retrieves a list of Remote Desktop sessions from a local or remote computer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```

```

### -------------------------- EXAMPLE 2 --------------------------
```

```

## PARAMETERS

### -ComputerName
Specifies the name of the computer to query. 
Default value is the local computer.

```yaml
Type: String
Parameter Sets: (All)
Aliases: DSNHostName, Name, Computer

Required: False
Position: 1
Default value: Localhost
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -State
{{Fill State Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: ConnectionState

Required: False
Position: 2
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -ClientName
{{Fill ClientName Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 3
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
{{Fill UserName Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 4
Default value: *
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Cassia.Impl.TerminalServicesSession

## NOTES

## RELATED LINKS

[https://github.com/twillin912/ServerManagementTools](https://github.com/twillin912/ServerManagementTools)

[http://code.msdn.microsoft.com/PSTerminalServices](http://code.msdn.microsoft.com/PSTerminalServices)

[http://code.google.com/p/cassia/](http://code.google.com/p/cassia/)

