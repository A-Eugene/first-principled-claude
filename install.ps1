# Claude Code on Windows: copy the skill into %USERPROFILE%\.claude\skills. Copies, never symlinks.
$ErrorActionPreference="Stop"; Set-Location $PSScriptRoot
$d = Join-Path $env:USERPROFILE ".claude\skills\first-principled"
New-Item -ItemType Directory -Force $d | Out-Null
Copy-Item "skills\first-principled\SKILL.md" (Join-Path $d "SKILL.md") -Force
Write-Host "installed: $d\SKILL.md"
Write-Host "claude.ai: upload dist\first-principled.zip under Settings > Customize > Skills"
