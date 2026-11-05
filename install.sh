#!/usr/bin/env bash
# hx-kit 설치: 스킬 6개를 ~/.agents/skills/<이름>/SKILL.md 로 복사한다.
# 스킬 안의 키트 경로는 실제 clone 위치로 바꿔 넣는다(~/hx-kit, /tmp/hx-kit 어디든).
# 홈이 git 저장소(=과제 폴더)면 .agents/와 키트 폴더를 그 저장소의 .git/info/exclude에 추가한다.
set -euo pipefail
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.agents/skills"
mkdir -p "$DEST"
for f in "$KIT"/hx-*.md; do
  name="$(basename "$f" .md)"
  mkdir -p "$DEST/$name"
  sed "s#~/hx-kit#$KIT#g" "$f" > "$DEST/$name/SKILL.md"
  echo "설치: $name"
done
echo "키트 위치: $KIT"

# 홈 아래에 git 저장소가 있는지 확인 (경우 2: 홈 = 과제 폴더)
ROOT="$(git -C "$HOME" rev-parse --show-toplevel 2>/dev/null || true)"
if [ -n "$ROOT" ]; then
  EX="$ROOT/.git/info/exclude"
  mkdir -p "$(dirname "$EX")"; touch "$EX"
  add_ex() { grep -qxF "$1" "$EX" || { echo "$1" >> "$EX"; echo "커밋 제외 추가: $1"; }; }
  rel() { local p; p="$(cd "$1" && pwd -P)"; [ "$p" = "$ROOT" ] && echo "" || echo "${p#"$ROOT"/}/"; }
  inside() { case "$(cd "$1" && pwd -P)/" in "$ROOT"/*) return 0 ;; *) return 1 ;; esac; }
  ROOT="$(cd "$ROOT" && pwd -P)"
  inside "$HOME/.agents" && add_ex "/$(rel "$HOME/.agents")"
  if inside "$KIT"; then
    add_ex "/$(rel "$KIT")"
    echo ""
    echo "주의: 키트가 과제 저장소($ROOT) 안에 있다. 커밋에선 빠지지만 파일 탐색기·제출 폴더에는 보인다."
    echo "      권장: rm -rf \"$KIT\" 후 /tmp/hx-kit 에 다시 clone 하고 install.sh 재실행"
  fi
fi
echo ""
echo '다음: 과제 폴더로 cd 한 뒤 codex 실행 → /status → $hx-start'
echo "스킬이 안 보이면 Codex에게: $KIT/hx-start.md 읽고 그대로 실행해"
