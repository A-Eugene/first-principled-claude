# Claude Code on Windows: copy the skill into %USERPROFILE%\.claude\skills. Copies, never symlinks.
$ErrorActionPreference="Stop"; Set-Location $PSScriptRoot
$d = Join-Path $env:USERPROFILE ".claude\skills\first-principled"
New-Item -ItemType Directory -Force $d | Out-Null
Copy-Item "SKILL.md" (Join-Path $d "SKILL.md") -Force
Write-Host "installed: $d\SKILL.md"
Write-Host "claude.ai: download the GitHub zip (Code > Download ZIP) and upload it under Settings > Customize > Skills"
