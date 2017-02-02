---
external help file: ServerManagementTools-help.xml
online version: https://github.com/twillin912/ServerManagementTools
schema: 2.0.0
---

# Get-IISLogPath

## SYNOPSIS
Get the configured IIS log file path for one or more websites

## SYNTAX

```
Get-IISLogPath [[-Name] <String[]>]
```

## DESCRIPTION
Reads the IIS website configuration data to determine the log file path for the given website

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-IISLogPath
```

Get log file path for all configured websites

### -------------------------- EXAMPLE 2 --------------------------
```
Get-IISLogPath -Name 'Default Web Site'
```

Get log file path for the website named 'Default Web Site'

## PARAMETERS

### -Name
Optional parameter the specifies the name of the website

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

### System.Management.Automation.PSObject

## NOTES
Author: Trent Willingham
Check out my other scripts and projects @ https://github.com/twillin912

## RELATED LINKS

[https://github.com/twillin912/ServerManagementTools](https://github.com/twillin912/ServerManagementTools)

