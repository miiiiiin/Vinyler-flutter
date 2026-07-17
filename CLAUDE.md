ㅕ# CLAUDE.md — Vinyler Flutter 구현 가이드

Claude Code로 이 폴더를 열었다면, 여기가 진입점입니다.

## 무엇을 만드는가
Vinyler — LP 바코드 스캐너 앱 (Flutter, iOS/Android 공용). 기존 iOS(Swift/RxSwift) 앱의 재설계.
스캔 → 음반 상세 → 기록(찜·감상·리뷰)이 핵심 루프. 데이터는 Discogs API.

## 문서 읽는 순서
1. `CLAUDE.md` (이 파일) — 작업 순서와 규칙
2. `README.md` — 화면별 스펙 · 디자인 토큰 · API 계약 · 인터랙션 (구현의 단일 소스)
3. `frost/readme.md` + `frost/tokens/*.css` — Frost 디자인 시스템 원본 (CSS지만 값의 원천)
4. `Vinyler App.dc.html` — 시각 레퍼런스. 브라우저로 열어 확인. **프로덕션 코드가 아님 — 변환하지 말고 참조만 할 것.** 주의: 이 캔버스는 Nocturne(구 테마) 톤으로 그려져 있음. 색·질감이 README의 Frost 토큰과 다르면 **Frost가 우선**.
5. `lib_snippets/frost_theme.dart` — 토큰을 미리 Dart로 이관한 초안. 그대로 lib/theme/에 복사해 시작.

## 구현 순서 (권장)
- [ ] 0. 프로젝트 셋업: Flutter 3.x, 패키지 — mobile_scanner, dio(+retrofit), flutter_secure_storage, phosphor_flutter, cached_network_image, google_fonts(Inter) + Pretendard 번들
- [ ] 1. 테마: `frost_theme.dart` 이관 → ThemeData/ColorScheme + FrostColors/FrostText/FrostFx 상수. 오로라 배경 위젯(AuroraScaffold)
- [ ] 2. 공용 위젯: GlassCard · FrostButton(primary/secondary/ghost/icon) · FrostTag · FrostInput · FrostSegmented · FrostSwitch · FloatingTabBar(4탭)
- [ ] 3. 인증: 로그인 · 회원가입 (JWT: access 헤더 + refresh secure storage, reissue 인터셉터)
- [ ] 4. 홈: AI 추천 가로 스크롤 · 인기 랭킹 · 장르 트렌드
- [ ] 5. 검색: 자동완성(debounce) · 인기 검색어
- [ ] 6. 스캔: mobile_scanner 전체화면 · 인식 → 결과 시트 → 상세 push
- [ ] 7. 음반 상세: 팀이 선택한 시안(5A 또는 5B) 구현
- [ ] 8. 리뷰: 작성(별점) · 목록(평점 분포, 커서 페이징)
- [ ] 9. 보관함: 리스트 보기 → **크레이트 보기**(README §7B 제스처 스펙) → 토글
- [ ] 10. 마이·소셜: 프로필 · 팔로워/팔로잉
- [ ] 11. 마감: 트랜지션 · 로딩/에러 상태 · Discogs 고지 문구

## 디자인 규칙 (위반 금지)
- 액센트(#9d90e8)를 불투명한 면으로 채우지 말 것 — 보더 · 글로우 · 반투명 틴트만
- 순수 흑(#000)/백(#fff) 금지 — 토큰 값만 사용
- 보더는 항상 반투명 화이트 (불투명 회색 금지)
- 헤딩 weight 600 초과 금지 — 위계는 크기와 여백으로
- 이모지 · 느낌표 금지. 카피는 한국어 우선, 짧고 기능적
- 아이콘은 phosphor_flutter만 (직접 그리지 말 것)
- 애니메이션 150~180ms ease (화면 전환/크레이트 제외), 바운스 금지
- BackdropFilter 중첩 최소화 — 스크롤 리스트 아이템에는 blur 대신 미리 계산된 반투명 색 사용 가능 (rgba(30,32,52,0.85) 근사)

## API
베이스: README의 엔드포인트 표 참조 (POST /api/v1/auth/login, GET /vinyls/popular, POST /vinyls/likes …).
커서 페이징 공통 응답: { content, hasNext, nextCursorId, size }.
Discogs 고지 필수: "이 앱은 Discogs와 제휴·후원·보증 관계가 없습니다."
