#!/usr/bin/env bash
# SessionStart hook: print this skill's body into the session, so its rules are
# in context in every session without the skill being called. A skill's body
# otherwise loads only when the model calls the Skill tool, which it does when a
# task matches the description, and rules for every reply never match a task.
#
# $1 is the part to print. Claude Code keeps about 10,000 characters of one
# hook's output, so the body is packed into parts of at most 9,000 characters at
# "## " headings, and hooks.json runs one command per part.
set -eu
root="$(cd "$(dirname "$0")/.." && pwd)"
PY=python3; [ -x /usr/bin/python3 ] && PY=/usr/bin/python3
exec "$PY" - "$root/SKILL.md" "${1:-1}" "$root/hooks/header.txt" <<'EOF'
import re, sys
skill, part, header = sys.argv[1], int(sys.argv[2]), open(sys.argv[3]).read().strip()
text = open(skill).read()
if text.startswith("---\n"):
    text = text.split("\n---\n", 1)[1]
sections = re.split(r"(?m)^(?=## )", text.strip())
parts, cur = [], ""
for s in sections:
    if cur and len(cur) + len(s) > 9000:
        parts.append(cur); cur = ""
    cur += s
if cur:
    parts.append(cur)
if part > len(parts):
    sys.exit(0)
label = "" if len(parts) == 1 else f" (part {part} of {len(parts)})"
print(f"=== {header}{label} ===\n")
print(parts[part - 1].strip())
EOF
