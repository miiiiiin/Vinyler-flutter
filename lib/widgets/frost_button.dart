import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/frost_theme.dart';

enum FrostButtonKind { primary, secondary, ghost }

/// Frost 버튼. 규칙: 액센트는 면(플러드)이 아니라 틴트 그라디언트 + 글로우 + 반투명 보더.
/// - primary: accent 0.30→0.10 그라디언트 + accent 0.5 보더 + 글로우
/// - secondary: glass 표면 + 반투명 화이트 보더
/// - ghost: 투명, hover 시 glass
class FrostButton extends StatelessWidget {
  const FrostButton({
    super.key,
    required this.label,
    this.onPressed,
    this.kind = FrostButtonKind.primary,
    this.icon,
    this.iconColor,
    this.height = 48,
    this.expand = false,
    this.fontSize = 15,
  });

  final String label;
  final VoidCallback? onPressed;
  final FrostButtonKind kind;
  final IconData? icon;
  final Color? iconColor;
  final double height;
  final bool expand;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final bool primary = kind == FrostButtonKind.primary;
    final bool ghost = kind == FrostButtonKind.ghost;
    final Color fg = primary ? FrostColors.accent100 : FrostColors.text;

    BoxDecoration deco() {
      if (primary) {
        return BoxDecoration(
          borderRadius: BorderRadius.circular(FrostRadius.pill),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x4C9D90E8), Color(0x1A9D90E8)], // 0.30 → 0.10
          ),
          border: Border.all(color: const Color(0x809D90E8)), // 0.5
          boxShadow: const [FrostFx.glowAccent],
        );
      }
      if (ghost) {
        return BoxDecoration(borderRadius: BorderRadius.circular(FrostRadius.pill));
      }
      return BoxDecoration(
        color: FrostColors.glassBg,
        borderRadius: BorderRadius.circular(FrostRadius.pill),
        border: Border.all(color: FrostColors.border),
      );
    }

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: fontSize + 4, color: iconColor ?? fg),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500, color: fg),
          ),
        ),
      ],
    );

    Widget btn = Container(
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: deco(),
      child: content,
    );

    // 비-ghost는 글래스 blur
    if (!ghost) {
      btn = ClipRRect(
        borderRadius: BorderRadius.circular(FrostRadius.pill),
        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16), child: btn),
      );
    }

    btn = Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(FrostRadius.pill),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(FrostRadius.pill),
        child: btn,
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}

/// 카카오 버튼 (브랜드 예외 색).
class KakaoButton extends StatelessWidget {
  const KakaoButton({super.key, required this.label, this.onPressed, this.icon});
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Material(
        color: FrostColors.kakao,
        borderRadius: BorderRadius.circular(FrostRadius.pill),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(FrostRadius.pill),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: FrostColors.kakaoText),
                const SizedBox(width: 8),
              ],
              Text(label,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: FrostColors.kakaoText)),
            ],
          ),
        ),
      ),
    );
  }
}
