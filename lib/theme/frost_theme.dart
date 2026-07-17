// frost_theme.dart — Frost 디자인 시스템 토큰 (frost/tokens/*.css 에서 이관)
// 핸드오프 lib_snippets/frost_theme.dart 를 그대로 이관 + 폰트/런타임 배선.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class FrostColors {
  // ground
  static const bg = Color(0xFF0F1120);
  static const bgDeep = Color(0xFF0A0C16);
  // text
  static const text = Color(0xFFEDECF7);
  static const textMuted = Color(0xFFA1A4BD);
  static const textFaint = Color(0xFF6B6F89);
  // accent ramp (blurple)
  static const accent100 = Color(0xFFE7E3FA);
  static const accent200 = Color(0xFFCDC6F3);
  static const accent300 = Color(0xFFB4ABEE); // 액센트 본문 텍스트
  static const accent400 = Color(0xFFA89CEB);
  static const accent = Color(0xFF9D90E8);
  static const accent600 = Color(0xFF7F71CF);
  static const accent700 = Color(0xFF6155A5);
  static const accent800 = Color(0xFF453C78);
  static const accent900 = Color(0xFF2B2550);
  // semantic
  static const danger = Color(0xFFE8788A);
  static const success = Color(0xFF7FD6B2);
  // lines — 항상 반투명 화이트
  static const border = Color(0x1FFFFFFF); // rgba(255,255,255,0.12)
  static const borderFaint = Color(0x12FFFFFF); // rgba(255,255,255,0.07)
  // glass
  static const glassBg = Color(0x0EFFFFFF); // rgba(255,255,255,0.055)
  static const glassBgStrong = Color(0x1AFFFFFF); // rgba(255,255,255,0.10)
  static const glassBgPressed = Color(0x24FFFFFF); // rgba(255,255,255,0.14)
  // 스크롤 리스트 등 blur 비용이 아까운 곳의 미리 계산된 근사 배경
  static const glassOpaque = Color(0xD91E2034);
  static const kakao = Color(0xFFFEE500); // 브랜드 예외
  static const kakaoText = Color(0xFF181600);
  static const youtube = Color(0xFFFF5B52);
}

abstract final class FrostSpace {
  static const s1 = 4.0, s2 = 8.0, s3 = 12.0, s4 = 16.0;
  static const s5 = 24.0, s6 = 32.0, s7 = 48.0, s8 = 64.0;
  static const screenPadding = 22.0;
}

abstract final class FrostRadius {
  static const sm = 10.0, md = 16.0, lg = 22.0;
  static const pill = 999.0;
}

abstract final class FrostFx {
  static const glassBlur = 24.0;
  static const shadowSm = [
    BoxShadow(color: Color(0x59040E0E), blurRadius: 10, offset: Offset(0, 2))
  ];
  static const shadowMd = [
    BoxShadow(color: Color(0x73040E0E), blurRadius: 32, offset: Offset(0, 8))
  ];
  static const shadowLg = [
    BoxShadow(color: Color(0x99040E0E), blurRadius: 60, offset: Offset(0, 20))
  ];
  static const glowAccent = BoxShadow(color: Color(0x479D90E8), blurRadius: 24);
  static const durFast = Duration(milliseconds: 160); // hover/state
  static const curve = Curves.easeOut;
}

/// 오로라 그라운드 — Scaffold 뒤에 고정 배치 (Stack의 최하단)
class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key});
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const BoxDecoration(color: FrostColors.bg),
        child: Stack(children: [
          Positioned(left: -180, top: -160, child: _glow(const Color(0x299D90E8), 900, 500)),
          Positioned(right: -140, top: -80, child: _glow(const Color(0x1F6358B4), 700, 420)),
          Positioned(left: -120, bottom: -220, child: _glow(const Color(0x14453C78), 760, 520)),
        ]),
      );
  static Widget _glow(Color c, double w, double h) => IgnorePointer(
        child: Container(
            width: w,
            height: h,
            decoration: BoxDecoration(gradient: RadialGradient(colors: [c, c.withAlpha(0)]))),
      );
}

/// AuroraBackground를 Scaffold 뒤에 깔아주는 헬퍼 Scaffold.
class AuroraScaffold extends StatelessWidget {
  const AuroraScaffold({super.key, required this.body, this.extendBody = true});
  final Widget body;
  final bool extendBody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: extendBody,
      body: Stack(children: [const Positioned.fill(child: AuroraBackground()), body]),
    );
  }
}

/// 글래스 표면. BackdropFilter와 함께 쓰는 헬퍼.
/// blur 비용이 아까운 곳(스크롤 아이템): blur:false → glassOpaque 근사 배경.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.radius = FrostRadius.lg,
    this.padding = const EdgeInsets.all(FrostSpace.s5),
    this.strong = false,
    this.blur = true,
  });
  final Widget child;
  final double radius;
  final EdgeInsets padding;
  final bool strong;
  final bool blur;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: blur
            ? (strong ? FrostColors.glassBgStrong : FrostColors.glassBg)
            : FrostColors.glassOpaque,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: FrostColors.borderFaint),
        boxShadow: FrostFx.shadowMd,
      ),
      child: child,
    );
    if (!blur) return ClipRRect(borderRadius: BorderRadius.circular(radius), child: box);
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: box,
      ),
    );
  }
}

ThemeData frostTheme() {
  final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
  // 헤딩 Inter(런타임 fetch), 본문은 Pretendard 번들 시 fallback으로 사용.
  TextStyle h(double size, FontWeight w, {double ls = 0}) => GoogleFonts.inter(
        fontSize: size,
        fontWeight: w,
        letterSpacing: ls,
        color: FrostColors.text,
      );
  TextStyle b(double size, {double height = 1.6, Color color = FrostColors.text}) => TextStyle(
        fontFamilyFallback: const ['Pretendard'],
        fontSize: size,
        height: height,
        color: color,
      );

  return base.copyWith(
    scaffoldBackgroundColor: FrostColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: FrostColors.accent,
      onPrimary: FrostColors.accent100,
      surface: FrostColors.bg,
      onSurface: FrostColors.text,
      error: FrostColors.danger,
    ),
    dividerColor: FrostColors.borderFaint,
    textTheme: TextTheme(
      // scale: 11/13/14/17/22/28/38 — 헤딩 w600 초과 금지
      displaySmall: h(38, FontWeight.w600, ls: -0.4),
      headlineMedium: h(28, FontWeight.w600, ls: -0.3),
      titleLarge: h(22, FontWeight.w600),
      titleMedium: h(17, FontWeight.w600),
      bodyLarge: b(17),
      bodyMedium: b(14),
      bodySmall: b(13, height: 1.55, color: FrostColors.textMuted),
      labelSmall: b(11, height: 1.2, color: FrostColors.textFaint),
    ),
    splashFactory: NoSplash.splashFactory,
  );
}
