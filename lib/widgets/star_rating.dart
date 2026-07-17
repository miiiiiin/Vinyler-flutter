import 'package:flutter/material.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';

/// 표시용 별점 (half star 지원). 채움 accent / 빈 별 accent800.
class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.size = 14, this.color = FrostColors.accent});
  final double rating;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = rating >= i + 1;
        final half = !filled && rating > i + 0.25 && rating < i + 1;
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            half ? AppIcons.starHalf : (filled ? AppIcons.starFill : AppIcons.star),
            size: size,
            color: filled || half ? color : FrostColors.accent800,
          ),
        );
      }),
    );
  }
}

/// 입력용 별점 (리뷰 작성).
class StarInput extends StatelessWidget {
  const StarInput({super.key, required this.value, required this.onChanged, this.size = 38});
  final int value;
  final ValueChanged<int> onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (i) {
        final filled = value >= i + 1;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(i + 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(filled ? AppIcons.starFill : AppIcons.star,
                size: size, color: filled ? FrostColors.accent : FrostColors.accent800),
          ),
        );
      }),
    );
  }
}
