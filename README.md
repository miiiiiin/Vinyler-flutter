# Vinyler — Flutter (Frost 디자인 시스템)

LP 바코드 스캐너 앱 **Vinyler**의 Flutter(iOS/Android) 구현. 디자인은 **Frost 디자인 시스템**
(다크 오로라 그라운드 + 글래스모피즘 + 블러플 액센트)을 따릅니다. 구현 순서·규칙은 루트의
`CLAUDE.md`가 기준입니다.

## 지금 담긴 것 (core flow)

- **Frost 테마** — `lib/theme/frost_theme.dart` (핸드오프 토큰 이관: `FrostColors`/`FrostSpace`/
  `FrostRadius`/`FrostFx`, `AuroraBackground`·`AuroraScaffold`·`GlassCard`). Inter(헤딩, google_fonts)
  + Pretendard(본문, 번들 예정).
- **공용 위젯** — `lib/widgets/`: `FrostButton`(primary/secondary/ghost), `FrostTag`, `FrostInput`,
  `CoverArt`, `StarRating`/`StarInput`, `FloatingTabBar`(4탭).
- **화면** — `lib/screens/`: 로그인 · 홈(대시보드) · 스캔(몰입 뷰파인더, 시뮬레이션) ·
  음반 상세(찜/감상 토글 · 트랙 접기 · 리뷰) · 리뷰 작성. 검색/마이는 자리표시자.
- **상태** — `lib/data/app_store.dart` 인메모리 `ChangeNotifier`(찜·감상·리뷰). API 연결 시 교체.

## 실행

```bash
flutter create --org com.vinyler --platforms=ios,android .   # 플랫폼 폴더 생성(기존 lib/·pubspec 보존)
flutter pub get
flutter run
```

> 이 스캐폴드는 네트워크 제한 샌드박스에서 작성되어 `flutter analyze`를 현지에서 한 번 돌려주세요.

## 디자인 규칙 (CLAUDE.md 요약)

액센트(#9D90E8)는 불투명 면 금지 — 보더·글로우·틴트만. 순수 흑/백 금지. 보더는 항상 반투명 화이트.
헤딩 weight ≤600. 이모지·느낌표 금지. 아이콘은 phosphor_flutter만. 애니메이션 150~180ms ease.

## 다음 단계

회원가입 · 검색(자동완성) · 스캔 결과카드(4B) · 상세 몰입헤더(5B) · 리뷰 목록 · 보관함 ·
마이/소셜, 그리고 API 연동(JWT · Discogs · 커서 페이징) · 실제 `mobile_scanner`.

---
이 앱은 Discogs와 제휴·후원·보증 관계가 없습니다.
