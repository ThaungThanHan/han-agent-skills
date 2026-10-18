#Requires -Version 5.1
[CmdletBinding()]
param(
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Skills = @(),

    [ValidateNotNullOrEmpty()]
    [string]$Dest = (Join-Path $HOME '.agents/skills'),

    [switch]$Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Help) {
    @'
Usage: .\install.ps1 [-Dest DIRECTORY] [SKILL ...]

Install all skills, or only the named skills. Existing installations are skipped.
Default destination: ~/.agents/skills

Examples:
  .\install.ps1
  .\install.ps1 han-learn
  .\install.ps1 -Dest C:\Projects\my-app\.agents\skills han-learn
'@
    exit 0
}

try {
    $sourceRoot = Join-Path $PSScriptRoot 'skills'
    if ($Skills.Count -eq 0) {
        $Skills = @(
            Get-ChildItem -LiteralPath $sourceRoot -Directory |
                Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md') -PathType Leaf } |
                Sort-Object Name |
                ForEach-Object { $_.Name }
        )
    }

    if ($Skills.Count -eq 0) {
        throw "No skills found in $sourceRoot."
    }

    # Validate every selection before creating or copying anything.
    foreach ($skill in $Skills) {
        if ($skill -cnotmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
            throw "Unknown skill '$skill'. See README.md for available skills."
        }
        $source = Join-Path $sourceRoot $skill
        if (-not (Test-Path -LiteralPath (Join-Path $source 'SKILL.md') -PathType Leaf)) {
            throw "Unknown skill '$skill'. See README.md for available skills."
        }
    }

    # Resolve relative destinations against the caller's current directory.
    $destination = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Dest)
    [System.IO.Directory]::CreateDirectory($destination) | Out-Null
    foreach ($skill in $Skills) {
        $target = Join-Path $destination $skill
        # Enumerating the parent also finds dangling links without following them.
        $existing = @(Get-ChildItem -LiteralPath $destination -Force |
            Where-Object { $_.Name -ieq $skill })
        if ($existing.Count -gt 0) {
            Write-Output "Skipped ${skill}: $target already exists."
        }
        else {
            Copy-Item -LiteralPath (Join-Path $sourceRoot $skill) -Destination $target -Recurse -Force
            Write-Output "Installed ${skill}: $target"
        }
    }
}
catch {
    [Console]::Error.WriteLine("Error: " + $_.Exception.Message)
    exit 1
}
