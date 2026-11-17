# WeGo 설명서 표기 규칙 (house style)

모든 설명서가 한 묶음으로 보이고 읽히게 하는 규칙입니다. 2026-11-16, 8권(G1 · H2 · R1 운용/개발, Humanoid Studio
사용 가이드 KO/EN)이 실제로 쓰는 표기에서 다수를 따라 정했습니다. 기술 내용은 바꾸지 않고 형식과 공용 용어만 맞춥니다.
English terms are given where the English edition needs them.

## 1. 표지 (cover)

순서와 칸은 모든 책이 같습니다 (`.cover` 안, 위에서 아래로):

| 칸 | class | 내용 |
|---|---|---|
| 로고 | `.top .logo` | `<img src="../shared/img/wego_logo.png" alt="WeGo Robotics">` |
| 책 종류 (영문) | `.tag` | `OPERATOR MANUAL` · `DEVELOPER MANUAL` · `USER GUIDE` |
| 책 종류 | `.kicker` | `운용 설명서` · `개발 설명서` · `사용 가이드` (en: Operator manual · Developer manual · User guide) |
| 제품명 | `h1` | 제조사 + 모델 + 종류, 예: `Unitree <span>R1</span><br>휴머노이드`, `WeGo Humanoid Studio` |
| 부제 | `.title2` | 모델 구성이나 대상 (선택) |
| 소개 | `.lead` | 두세 문장 |
| 아래띠 | `.foot` | 왼쪽 `한국어판 · <span data-version></span>` (en: `English edition · …`), 오른쪽 `<b>WeGo Robotics</b> · go.support@wego-robotics.com` |

개인 이름은 쓰지 않습니다. 지은이는 WeGo Robotics입니다. 버전은 `manual.json`의 날짜만 씁니다 (`1.1판` 같은 판 번호는 쓰지 않고, 이력은 CHANGELOG.md).

## 2. 책의 순서

표지 → 이 설명서에 대하여 (`.colophon`) → 목차 → 장 → 부록.

- **안전**: 운용 설명서와 사용 가이드는 2장을 `중요 안전 수칙` (en: Safety)으로 둡니다. 운용 설명서 3권이 이미 그렇습니다.
  개발 설명서는 `이 설명서에 대하여`의 안전 문단과 각 장의 경고 상자로 대신합니다.
- **이 설명서에 대하여** 표의 행 순서: `로봇` (개발 설명서는 `대상`) → `근거 문서` → 있으면 `SDK 대조` · `실측 자료` · `소프트웨어` →
  `함께 보는 책` → `판` (`한국어판 · <span data-version></span>`) → `문의` (`go.support@wego-robotics.com`).
  English edition: `Audience` → `Sources` → `Read with` → `Edition` (`English edition · …`) → `Contact`.
- **목차** 제목: `목차` / `Contents`, 부제 `CONTENTS`.
- **부록**: `APPENDIX` + `부록`, 제목 `빠른 참조`. 문제 해결은 부록이 아니라 본문 마지막 장 `문제 해결`입니다.

## 3. 장 · 절 제목

- 장 첫머리: `<div class="num">CHAPTER<big>01</big></div><h1 data-mark="c1">제목</h1>`, 이어서 `<p class="lede">` 한두 문장.
- 절 `h2`, 소절 `h3`. 절 제목 끝의 출처 표시는 세 가지만 씁니다:
  `<span class="src">문서</span>` (제조사 공식 자료), `<span class="src r">SDK</span>` (SDK 소스에서 확인), `<span class="src r">실측</span>` (WeGo가 직접 확인).
  다른 낱말(`첨부 파일`, `H2 신규`, 프로그램 이름)은 본문으로 옮깁니다.

## 4. 상자 (callout)

세 가지, 뜻은 하나씩. 머리글은 `종류 · 주제` 꼴입니다.

| class | 머리글 | 뜻 | en |
|---|---|---|---|
| `box warn` | `경고 · …` | 사람이 다치거나 로봇이 넘어지거나 부서질 수 있음 | Warning |
| `box caution` | `주의 · …` | 장비 · 데이터 손상, 잘못된 결과가 날 수 있음 | Caution |
| `box note` | `참고 · …`, `문서와 SDK의 차이`, `문서 오류` | 알아 둘 정보. 공식 문서와 SDK · 실측이 다른 곳 | Note |

문서와 SDK가 다른 곳은 언제나 `note`입니다 (`caution` 아님). 다른 이름의 상자(`tip` 등)는 만들지 않습니다.

## 5. 그림 · 표

- 번호는 쓰지 않습니다. `<figcaption>`에 빌드가 `그림 N.` / `Figure N.`을 붙입니다. 본문 참조는 `data-fig="fig-키"` + `<span class="ref" data-ref="fig-키"></span>`.
- 캡션: 무엇인지 한 문장, 출처는 끝에 괄호로 `(Unitree 문서)` · `(Unitree 교육 영상)` · `(WeGo 실측)`.
- 표 제목이 필요하면 `<caption>` (번호는 빌드가). 열 머리는 `<thead>`.

## 6. 공용 용어 (glossary)

| 쓰는 말 | 쓰지 않는 말 | 뜻 / 비고 | en |
|---|---|---|---|
| 개발 PC | 사용자 PC, 호스트 PC | 사용자가 SDK를 돌리는 자기 컴퓨터 | development PC |
| PC1 · PC2 · PC3 | — | 로봇 안의 컴퓨터. 장마다 처음 나올 때 풀이: `PC1(운동 제어 컴퓨터)`, `PC2(개발 연산 유닛)` | PC1 (motion control), PC2 (development unit) |
| 로봇 네트워크 | 로봇 내부 네트워크, 로봇 LAN | 192.168.123.0/24 | robot network |
| 192.168.123.x | 192.168.123.xxx, 192.168.123.* | 주소 범위 표기 | |
| WeGo Humanoid Studio → Humanoid Studio | 휴머노이드 스튜디오 | 처음은 전체 이름, 이후 줄임 | |
| 다관절 손 → 손 | 핸드 (UI 글자를 그대로 인용할 때만) | 다섯 손가락 손. 처음은 `다관절 손` | dexterous hand → hand |
| 그리퍼 | — | 두 손가락 집게 (Dex1-1) | gripper |
| BrainCo Revo2 · Revo2 Touch | Revo 2, REVO2 | | |
| Inspire RH56xxx | 인스파이어 | 모델명까지 (RH56DFX, RH56F1 …) | |
| Dex3-1 | Dex3 | 토픽 이름(`rt/dex3/…`)은 그대로 | |
| 리모컨 / 왼쪽 · 오른쪽 조이스틱 | 무선 컨트롤러, 조종기 | 리모컨의 스틱은 조이스틱 | remote / left · right stick |
| 비상 정지 | 비상정지, 긴급 정지 | 띄어 씀 | emergency stop (E-stop) |
| 디버그 모드 | — | Unitree의 사용자 개발 모드(`사용자 개발 모드`)와 다름 | debug mode |
| 운용 설명서 · 개발 설명서 · 사용 가이드 | 매뉴얼, 짝 문서, 함께 보는 문서 | 책 이름: `Unitree R1 운용 설명서` | Operator manual · Developer manual · User guide |
| 숫자 + 띄어쓰기 + 단위 | `24V`, `10mm` | `24 V`, `10 mm`, `50 Hz`, `0.5 m/s`, `30°` (각도는 붙여 씀). 커넥터 인쇄 글자(`+12V`)는 그대로 | |
| 가운뎃점 ` · ` | `/`, `,` (나열에서) | 앞뒤 띄어 씀 | |

## 7. 다른 책 가리키기 (cross-links)

다른 WeGo 설명서를 가리킬 때: `<a data-manual="r1-developer">Unitree R1 개발 설명서</a>`.
웹에서는 빌드가 `href="../r1-developer/"`를 넣고, PDF에서는 링크 없는 글자로 둡니다 (PDF 안에 이 PC의 경로가 남지 않게).
없는 id는 빌드가 멈춥니다.

## 8. 여러 책에 같은 글 (shared parts)

두 권 이상에 글자 그대로 같은 덩어리(지원 창구, 공통 안전 문장, 같은 SDK API 표 등)는 `shared/parts/<이름>_ko.html` 한 곳에 두고
`<div data-include="shared/parts/<이름>_ko.html"></div>`로 넣습니다. 빌드가 그 자리에 파일 내용을 넣은 뒤 그림 번호를 매깁니다.
제품마다 조금이라도 다르면 공유하지 않습니다.
