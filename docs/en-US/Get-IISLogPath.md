---
external help file: ServerManagementTools-help.xml
online version: https://github.com/twillin912/ServerManagementTools
schema: 2.0.0
---

# Get-IISLogPath

## SYNOPSIS
Retrieve webiste logging path.

## SYNTAX

```
Get-IISLogPath [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The Get-IISLogPath cmdlet retrieves the log file path for one or more websites configured on the target computer.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-IISLogPath
```

Returns log path information for all sites

### -------------------------- EXAMPLE 2 --------------------------
```
Get-IISLogPath -Name 'Default Web Site'
```

Returns log path information for the 'Default Web Site'

### -------------------------- EXAMPLE 3 --------------------------
```
Get-IISLogPath -Name 'Admin*'
```

Returns log path information for all sites whose Name begin with 'Admin'

### -------------------------- EXAMPLE 4 --------------------------
```
Get-IISLogPath -Name @('MySite1','MySite2')
```

Returns log path information for the sites 'MySite1' and 'MySite2'

## PARAMETERS

### -Name
Specifies a name of one or more websites. 
Get-IISLogPath retrieves the logging path for the website specified. 
If you do not specify this parameter, the cmdlet will return all configured sites.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES
Author: Trent Willingham
Check out my other scripts and projects @ https://github.com/twillin912

## RELATED LINKS

[https://github.com/twillin912/ServerManagementTools](https://github.com/twillin912/ServerManagementTools)

