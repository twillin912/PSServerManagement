Param(
    [Parameter(Mandatory=$true)]
    [string] $ProjectRoot
)

###############################################################################
# Customize these properties and tasks for your module.
###############################################################################

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$ArtifactPath = Join-Path -Path $ProjectRoot -ChildPath 'artifacts'

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$BuildPath = Join-Path -Path $ProjectRoot -ChildPath 'build'

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$DocsPath = Join-Path -Path $ProjectRoot -ChildPath 'docs'

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$TestPath = Join-Path -Path $ProjectRoot -ChildPath 'tests'

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$UseAppVeyor = $false

$Version = (Test-ModuleManifest -Path "$env:BHPSModuleManifest").Version
[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$ModuleVersion = New-Object -TypeName Version -ArgumentList $Version.Major, $Version.Minor, $Version.Build, ($Version.Revision + 1)

###############################################################################
# Before/After Hooks for the Core Task: Clean
###############################################################################

# Synopsis: Executes before the Clean task.
Add-BuildTask BeforeClean {}

# Synopsis: Executes after the Clean task.
Add-BuildTask AfterClean {}

###############################################################################
# Before/After Hooks for the Core Task: Analyze
###############################################################################

# Synopsis: Executes before the Analyze task.
Add-BuildTask BeforeAnalyze {}

# Synopsis: Executes after the Analyze task.
Add-BuildTask AfterAnalyze {}

###############################################################################
# Before/After Hooks for the Core Task: Build
###############################################################################

# Synopsis: Executes before the Test Task.
Add-BuildTask BeforeBuild {}

# Synopsis: Executes after the Test Task.
Add-BuildTask AfterBuild {}

###############################################################################
# Before/After Hooks for the Core Task: Test
###############################################################################

# Synopsis: Executes before the Test Task.
Add-BuildTask BeforeTest {}

# Synopsis: Executes after the Test Task.
Add-BuildTask AfterTest {}

###############################################################################
# Before/After Hooks for the Core Task: Archive
###############################################################################

# Synopsis: Executes before the Archive task.
Add-BuildTask BeforeArchive {}

# Synopsis: Executes after the Archive task.
Add-BuildTask AfterArchive {}

###############################################################################
# Before/After Hooks for the Core Task: Publish
###############################################################################

# Synopsis: Executes before the Publish task.
Add-BuildTask BeforePublish {}

# Synopsis: Executes after the Publish task.
Add-BuildTask AfterPublish {}
