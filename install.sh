#!/usr/bin/env bash
# Claude Code: copy the skill into ~/.claude/skills. Copies, never symlinks.
set -eu; cd "$(dirname "$0")"; ./build.sh >/dev/null
mkdir -p ~/.claude/skills/first-principled
cp SKILL.md ~/.claude/skills/first-principled/SKILL.md
echo "installed: ~/.claude/skills/first-principled/SKILL.md"
echo "claude.ai: download the GitHub zip (Code > Download ZIP) and upload it under Settings > Customize > Skills"
