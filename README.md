# hx-kit

실무형 AI 과제(Codex CLI, 약 180분)용 개인 작업 규칙 모음. 과제 정답이나 풀이 코드는 없다. 과제 README와 공식 안내가 항상 우선한다.

## 설치 (Codex 실행 전에)
```bash
git clone https://github.com/swj08212-coder/hx-kit ~/hx-kit
bash ~/hx-kit/install.sh
cd <과제 폴더>
codex
```

## 단계별 스킬
| 스킬 | 언제 |
|---|---|
| `$hx-start` | 시작: 세팅, README 분석, 담당자 질문 후보 |
| `$hx-inspect` | 데이터 점검 → 정리·표시 → 그림 → 확인 질문 → 처리 규칙 |
| `$hx-design` | 하위 문제 분해, 가정값, 설계안 2개, 테스트 목록 |
| `$hx-base` | 기준안 첫 완주 |
| `$hx-iterate` | 개선 1~2개, 담당자 피드백 반영 |
| `$hx-finish` | 동결, 재실행, 문서, 제출 준비 |

스킬이 목록에 없으면: `~/hx-kit/hx-<이름>.md 읽고 그대로 실행해`

## 파일
- `AGENTS.template.md` 과제 폴더에 AGENTS.md가 없을 때 hx-start가 복사
- `serve.sh` 화면 결과물용 정적 서버(0.0.0.0)
- `install.sh` 스킬 설치(덮어쓰지 않음)

## git 주의
커밋은 과제 폴더에서 `git add .`로 과제 폴더 파일만 올린다. `git add -A` 금지, push 금지.

MIT License.
