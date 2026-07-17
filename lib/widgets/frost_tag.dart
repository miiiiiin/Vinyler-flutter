import 'package:flutter/material.dart';
import '../theme/frost_theme.dart';

enum FrostTagKind { neutral, accent, outline }

/// Frost 태그/칩. glass pill. accent는 틴트, outline은 보더만.
class FrostTag extends StatelessWidget {
  const FrostTag(this.label, {super.key, this.kind = FrostTagKind.neutral});
  final String label;
  final FrostTagKind kind;

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late Color border;
    switch (kind) {
      case FrostTagKind.neutral:
        bg = FrostColors.glassBg;
        fg = FrostColors.textMuted;
        border = FrostColors.borderFaint;
        break;
      case FrostTagKind.accent:
        bg = const Color(0x1F9D90E8); // 0.12
        fg = FrostColors.accent200;
        border = const Color(0x599D90E8); // 0.35
        break;
      case FrostTagKind.outline:
        bg = Colors.transparent;
        fg = FrostColors.accent200;
        border = const Color(0x599D90E8);
        break;
    }
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(FrostRadius.pill),
        border: Border.all(color: border),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: fg),
      ),
    );
  }
}
