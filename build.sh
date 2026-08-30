#!/usr/bin/env bash
# The kernel is section I of first-principled-claude.md. This regenerates the skill
# from it and zips it for claude.ai. Edit the .md; never edit skills/*/SKILL.md.
set -eu; cd "$(dirname "$0")"
{ cat skills/first-principled/FRONTMATTER.md
  sed -n '/^# I\. Invariant core/,/^# II\. Model dispatch/{/^# II\./!p}' first-principled-claude.md | sed '$d'
} > skills/first-principled/SKILL.md
mkdir -p dist; ( cd skills && rm -f ../dist/first-principled.zip && zip -qr ../dist/first-principled.zip first-principled -x '*.DS_Store' )
echo "built: skills/first-principled/SKILL.md, dist/first-principled.zip"
