[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '', Scope='*', Target='SuppressImportModule')]
$SuppressImportModule = $false
. $PSScriptRoot\Shared.ps1

Describe 'Module root' {
    $PrivateFunctions = Get-ChildItem -Path "$SrcRootDir\Private" -Include '*.ps1' -Recurse -ErrorAction SilentlyContinue
    $PublicFunctions = Get-ChildItem -Path "$SrcRootDir\Public" -Include '*.ps1' -Recurse -ErrorAction SilentlyContinue
    $ExportedFunctions = (Get-Command -Module $ModuleName).Name

    $AllFunctions = New-Object System.Collections.Generic.List[System.Object]
    $AllFunctions.Add($PrivateFunctions)
    $AllFunctions.Add($PublicFunctions)

    Context 'Private Functions not exported' {
        foreach ( $Function in $PrivateFunctions.BaseName ) {
            It "Function $Function not exported" {
                ( $Function -in $ExportedFunctions ) | Should Be $false
            }
        }
    }

    Context 'Public Functions exported' {
        foreach ( $Function in $PublicFunctions.BaseName ) {
            It "Function $Function exported" {
                ( $Function -in $ExportedFunctions ) | Should Be $true
            }
        }
    }

    Context 'Pester coverage' {
        foreach ( $Function in $AllFunctions.BaseName ) {
            It "Function $Function has pester test" {
                "$TestRootDir\$Function.Tests.ps1" | Should Exist
            }
        }
    }
}
