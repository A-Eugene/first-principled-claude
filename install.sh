#!/usr/bin/env bash
# Claude Code: copy the skill into ~/.claude/skills. Copies, never symlinks.
set -eu; cd "$(dirname "$0")"; ./build.sh >/dev/null
mkdir -p ~/.claude/skills/first-principled
cp skills/first-principled/SKILL.md ~/.claude/skills/first-principled/SKILL.md
echo "installed: ~/.claude/skills/first-principled/SKILL.md"
echo "claude.ai: upload dist/first-principled.zip under Settings > Customize > Skills"
