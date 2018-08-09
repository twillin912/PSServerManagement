---
external help file: ServerManagement-help.xml
Module Name: ServerManagement
online version: http://servermanagementtools.readthedocs.io/en/latest/functions/Disable-SChannelFeature
schema: 2.0.0
---

# Disable-SChannelFeature

## SYNOPSIS
Disable SChannel featuers on one or more computers.

## SYNTAX

```
Disable-SChannelFeature [-ComputerName] <String[]> [-All] [-3Des] [-Dhe] [-Rc4] [-Ssl2] [-Ssl3] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Disable-SChannelFeature cmdlet disables features in the SChannel security suite on Windows computers. 
This cmdlet can be used to disable ciphers, key exchanges, and protocols that are consider insecure.

## EXAMPLES

### EXAMPLE 1
```
Disable-SChannelFeature -ComputerName 'MyServer' -Rc4
```

Disable the RC4 cipher on the computer 'MyServer'.

## PARAMETERS

### -ComputerName
Specifies the name of the system to target.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -All
Disables all insecure SChannel features.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -3Des
Disables SChannel 3DES cipher usage.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Dhe
Disables SChannel Diffe-Hellman key exchange.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Rc4
Disables SChannel RC4 cipher usage.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ssl2
Disables SChannel SSL v2 protocol usage.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Ssl3
Disables SChannel SSL v3 protocol usage.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### None

## NOTES
Author: Trent Willingham
Check out my other projects on GitHub https://github.com/twillin912

## RELATED LINKS

[http://servermanagementtools.readthedocs.io/en/latest/functions/Disable-SChannelFeature](http://servermanagementtools.readthedocs.io/en/latest/functions/Disable-SChannelFeature)

