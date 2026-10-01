#!/usr/bin/env bash
# Claude Code: copy the skill into its own folder under ~/.claude/skills.
# The folder is also a plugin (.claude-plugin/plugin.json) so a claude.ai
# account can install it from this repo. Copies, never symlinks.
set -eu; cd "$(dirname "$0")"
./build.sh >/dev/null
dest=~/.claude/skills/first-principled
mkdir -p "$dest"
cp -r SKILL.md .claude-plugin "$dest"/
rm -rf "$dest/hooks"
echo "installed: $dest (skill and plugin first-principled@skills-dir)"

# Codex always reads ~/.codex/AGENTS.md. --codex writes this skill there as a
# marked block, which a later install replaces in place.
if [ "${1:-}" = "--codex" ]; then
  /usr/bin/env python3 - "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" "first-principled" "AGENTS.md" <<'CODEX'
import os, re, sys
path, name, src = sys.argv[1:4]
body = open(src).read()
if body.startswith("---\n"):
    body = body.split("\n---\n", 1)[1]
block = f"<!-- {name}:begin -->\n{body.strip()}\n<!-- {name}:end -->"
old = open(path).read() if os.path.exists(path) else ""
pat = re.compile(rf"<!-- {re.escape(name)}:begin -->.*?<!-- {re.escape(name)}:end -->", re.S)
if pat.search(old):
    new = pat.sub(lambda m: block, old)
else:
    new = (old.rstrip() + "\n\n" if old.strip() else "") + block + "\n"
os.makedirs(os.path.dirname(path), exist_ok=True)
open(path, "w").write(new)
print(f"installed: {name} block in {path}")
CODEX
fi
echo "claude.ai: download the GitHub zip (Code > Download ZIP) and upload it under Settings > Customize > Skills"
