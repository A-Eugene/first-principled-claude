#!/usr/bin/env bash
# Claude Code: install the skill as a plugin in its own skills folder. The
# folder is both the skill and a plugin (.claude-plugin/plugin.json), and the
# plugin's startup hook puts the skill's text into every session. Copies,
# never symlinks. Takes effect in the next session, or after /reload-plugins.
set -eu; cd "$(dirname "$0")"
./build.sh >/dev/null
dest=~/.claude/skills/first-principled
mkdir -p "$dest"
cp -r SKILL.md .claude-plugin hooks "$dest"/
echo "installed: $dest (skill and plugin first-principled@skills-dir)"
echo "claude.ai: download the GitHub zip (Code > Download ZIP) and upload it under Settings > Customize > Skills"
