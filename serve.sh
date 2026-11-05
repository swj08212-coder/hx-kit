#!/usr/bin/env bash
# 정적 결과 화면(HTML·JS·JSON·PNG)을 Cofa Browser 미리보기로 열기 위한 서버.
# 사용법: bash serve.sh [포트=8000] [보여 줄 폴더=.]
#   예) bash serve.sh 8000 web
# 0.0.0.0에 바인딩해야 미리보기(작업 환경 바깥에서 오는 연결)가 들어올 수 있다.
# 이 터미널은 닫지 말 것. 서버 종료는 이 터미널에서 Ctrl+C.

PORT="${1:-8000}"
DIR="${2:-.}"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[오류] python3가 없습니다. 'python3 --version'으로 확인하세요."; exit 1
fi
if [ ! -d "$DIR" ]; then
  echo "[오류] 폴더가 없습니다: $DIR"; exit 1
fi

# 포트가 이미 쓰이고 있으면 다음 빈 포트를 찾는다 (최대 20개)
free_port() {
  python3 - "$1" <<'PY'
import socket, sys
p = int(sys.argv[1])
for q in range(p, p + 20):
    s = socket.socket()
    try:
        s.bind(("0.0.0.0", q)); s.close(); print(q); break
    except OSError:
        s.close()
else:
    print("")
PY
}
NEW_PORT="$(free_port "$PORT")"
if [ -z "$NEW_PORT" ]; then
  echo "[오류] $PORT~$((PORT+19)) 포트가 모두 사용 중입니다. 다른 번호로 다시 실행하세요."; exit 1
fi
if [ "$NEW_PORT" != "$PORT" ]; then
  echo "[안내] $PORT 포트는 사용 중이라 $NEW_PORT 포트로 엽니다."
  PORT="$NEW_PORT"
fi

if [ -f "$DIR/index.html" ]; then
  PAGE="/  (index.html)"
else
  PAGE="/  (index.html이 없어 파일 목록이 보입니다)"
fi

echo "------------------------------------------------------------"
echo " 서버 시작: 폴더 '$DIR' 를 포트 $PORT 로 제공 (0.0.0.0)"
echo " Browser 도구에서: PORT = $PORT,  URL 경로 = $PAGE"
echo " 입력 후 원형 화살표(새로고침)를 누르세요."
echo " 파일을 고친 뒤에는 원형 화살표만 다시 누르면 됩니다."
echo " 종료: 이 터미널에서 Ctrl+C"
echo "------------------------------------------------------------"
exec python3 -m http.server "$PORT" --bind 0.0.0.0 --directory "$DIR"
