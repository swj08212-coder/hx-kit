#!/usr/bin/env bash
# hx-kit 설치: 스킬 6개를 ~/.agents/skills/<이름>/SKILL.md 로 복사한다.
# 이미 같은 이름이 있으면 덮어쓰지 않는다. 과제 폴더는 건드리지 않는다.
set -euo pipefail
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.agents/skills"
mkdir -p "$DEST"
for f in "$KIT"/hx-*.md; do
  name="$(basename "$f" .md)"
  if [ -e "$DEST/$name" ]; then
    echo "유지: $name (이미 있음)"
  else
    mkdir -p "$DEST/$name"
    cp "$f" "$DEST/$name/SKILL.md"
    echo "설치: $name"
  fi
done
echo ""
echo '다음: 과제 폴더로 cd 한 뒤 codex 실행 → /status → $hx-start'
echo "스킬이 안 보이면 Codex에게: $KIT/hx-start.md 읽고 그대로 실행해"
