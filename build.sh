#!/usr/bin/env bash
# The kernel is section I of first-principled-claude.md. This regenerates SKILL.md
# from it. Edit the .md, never SKILL.md.
set -eu; cd "$(dirname "$0")"
{ cat FRONTMATTER.md
  sed -n '/^# I\. Invariant core/,/^# II\. Model dispatch/{/^# II\./!p}' first-principled-claude.md | sed '$d'
} > SKILL.md
# claude.ai rejects a skill whose description is over 1024 characters.
n=$(python3 -c 'import sys,yaml; print(len(yaml.safe_load(open("FRONTMATTER.md").read().strip().strip("-"))["description"]))')
[ "$n" -le 1024 ] || { echo "FRONTMATTER.md: description is $n characters, the limit is 1024" >&2; exit 1; }
echo "built: SKILL.md (description $n characters)"
