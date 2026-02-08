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
Write-Host "== $projectName : Setup ==" -ForegroundColor Cyan

function Test-Jdk11($path) {
    if (-not $path) { return $false }
    $javaExe = Join-Path $path "bin\java.exe"
    if (-not (Test-Path $javaExe)) { return $false }
    try {
        $ver = & $javaExe -version 2>&1 | Out-String
        return ($ver -match 'version "11\.')
    } catch {
        return $false
    }
}

function Expand-Candidates($cands) {
    $out = @()
    foreach ($c in $cands) {
        if (-not $c) { continue }
        if ($c -like "*`**") {
            $out += @(Get-ChildItem -Path $c -Directory -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
        } elseif ($c -like "*`*") {
            $out += @(Get-ChildItem -Path $c -Directory -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName })
        } else {
            $out += $c
        }
    }
    return ($out | Where-Object { $_ } | Select-Object -Unique)
}

function Find-Jdk11 {
    $candidates = @()

    # Prefer JAVA_HOME if it’s already 11
    if ($env:JAVA_HOME) { $candidates += $env:JAVA_HOME }

    # Common Windows installs
    $candidates += @(
        "$env:USERPROFILE\.jdks\corretto-11*",
        "$env:USERPROFILE\.jdks\temurin-11*",
        "$env:ProgramFiles\Amazon Corretto\jdk11*",
        "$env:ProgramFiles\Java\jdk-11*",
        "$env:ProgramFiles\Microsoft\jdk-11*",
        "$env:ProgramFiles\Eclipse Adoptium\jdk-11*",
        "$env:ProgramFiles\AdoptOpenJDK\jdk-11*",
        "$env:LOCALAPPDATA\Programs\Eclipse Adoptium\jdk-11*"
    )

    # If java is on PATH, climb up from ...\bin\java.exe
    try {
        $whereJava = (where.exe java 2>$null)
        foreach ($j in $whereJava) {
            $p = Split-Path -Parent $j      # ...\bin
            $p = Split-Path -Parent $p      # JDK root
            $candidates += $p
        }
    } catch { }

    $expanded = Expand-Candidates $candidates

    foreach ($p in $expanded) {
        if (Test-Jdk11 $p) { return $p }
    }
    return $null
}

$jdk11Home = Find-Jdk11

# Optional: auto-install Java 11 via winget if missing
if (-not $jdk11Home) {
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($winget) {
        Write-Host "No JDK 11 found. Attempting install via winget (Temurin 11)..." -ForegroundColor Yellow
        try {
            & winget install --id EclipseAdoptium.Temurin.11.JDK -e --silent --accept-package-agreements --accept-source-agreements
        } catch { }
        $jdk11Home = Find-Jdk11
    }
}

if (-not $jdk11Home) {
    Write-Host ""
    Write-Host "ERROR: Could not find a Java 11 JDK." -ForegroundColor Red
    Write-Host "Install Temurin 11 or Corretto 11, then re-run this script."
    exit 1
}

Write-Host ("Found JDK 11: " + $jdk11Home) -ForegroundColor Green

# Update/insert org.gradle.java.home in gradle.properties without nuking other lines
$gp = ".\gradle.properties"
$lines = @()
if (Test-Path $gp) { $lines = Get-Content $gp -ErrorAction SilentlyContinue }

$lines = $lines | Where-Object { $_ -notmatch '^\s*org\.gradle\.java\.home\s*=' }
$lines += "org.gradle.java.home=$jdk11Home"
Set-Content -Encoding ASCII -Path $gp -Value ($lines -join "`r`n")

Write-Host "Updated gradle.properties -> org.gradle.java.home" -ForegroundColor Green

# Verify
Write-Host ""
Write-Host "Verifying toolchains / Gradle..." -ForegroundColor Cyan
if (Test-Path ".\gradlew.bat") {
    & .\gradlew.bat -q javaToolchains
} elseif (Test-Path ".\gradlew") {
    & .\gradlew -q javaToolchains
} else {
    Write-Host "ERROR: gradlew/gradlew.bat not found in project root." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
