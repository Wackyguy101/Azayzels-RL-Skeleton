$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Get-ProjectName {
    if (Test-Path ".\settings.gradle") {
        $s = Get-Content ".\settings.gradle" -Raw
        $m = [regex]::Match($s, "rootProject\.name\s*=\s*['""]([^'""]+)['""]")
        if ($m.Success) { return $m.Groups[1].Value }
    }
    return (Split-Path -Leaf (Get-Location))
}

$projectName = Get-ProjectName
Write-Host "== $projectName : Run ==" -ForegroundColor Cyan

if (-not (Test-Path ".\gradle.properties")) {
    Write-Host "NOTE: gradle.properties not found. If build/run fails, run 01_setup_vscode_windows.ps1." -ForegroundColor Yellow
}

# Prefer bat on Windows
if (Test-Path ".\gradlew.bat") {
    & .\gradlew.bat --no-daemon run @Args
    exit $LASTEXITCODE
}

if (Test-Path ".\gradlew") {
    & .\gradlew --no-daemon run @Args
    exit $LASTEXITCODE
}

Write-Host "ERROR: gradlew/gradlew.bat not found in project root." -ForegroundColor Red
exit 1
