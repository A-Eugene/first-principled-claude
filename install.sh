#!/usr/bin/env bash
# Claude Code: copy the skill into its own folder under ~/.claude/skills.
# Copies, never symlinks.
set -eu; cd "$(dirname "$0")"
./build.sh >/dev/null
dest=~/.claude/skills/first-principled
mkdir -p "$dest"
cp SKILL.md "$dest"/
rm -rf "$dest/hooks" "$dest/.claude-plugin"
echo "installed: $dest"

# Auto-update: update.sh runs at every Claude Code session start and reinstalls from
# the source repo's main, with this same command, when main has moved past this install.
cp update.sh "$dest"/
git remote get-url origin > "$dest/.source" 2>/dev/null || echo "https://github.com/A-Eugene/first-principled-claude" > "$dest/.source"
commit=$(git rev-parse HEAD 2>/dev/null) || commit=
[ -z "$(git status --porcelain 2>/dev/null)" ] || commit="$commit-dirty"
echo "$commit" > "$dest/.commit"
echo "./install.sh${*:+$(printf ' %q' "$@")}" > "$dest/.install"
/usr/bin/env python3 - "$HOME/.claude/settings.json" "\"$dest/update.sh\"" <<'HOOK'
import json, os, sys
path, cmd = sys.argv[1:3]
d = json.load(open(path)) if os.path.exists(path) else {}
starts = d.setdefault("hooks", {}).setdefault("SessionStart", [])
if not any(h.get("command") == cmd for e in starts for h in e.get("hooks", [])):
    starts.append({"hooks": [{"type": "command", "command": cmd}]})
    json.dump(d, open(path, "w"), indent=2)
    print(f"registered: {cmd} in {path}")
HOOK

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
echo "To load it reliably, add this line to the \"Skills to load\" block in ~/.claude/CLAUDE.md:"
echo "- first-principled: only for substantial work (a design, an analysis, a choice between options, a costly decision, a verdict question)."
