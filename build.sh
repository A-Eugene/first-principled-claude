#!/usr/bin/env bash
# The kernel is section I of first-principled-claude.md. This regenerates SKILL.md
# from it. Edit the .md, never SKILL.md.
set -eu; cd "$(dirname "$0")"
{ cat FRONTMATTER.md
  sed -n '/^# I\. Invariant core/,/^# II\. Model dispatch/{/^# II\./!p}' first-principled-claude.md | sed '$d'
} > SKILL.md
echo "built: SKILL.md"
