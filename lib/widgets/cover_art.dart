import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';

/// 앨범 커버. url 있으면 Discogs 이미지, 없으면 Frost 플레이스홀더(그라디언트 + music-notes).
class CoverArt extends StatelessWidget {
  const CoverArt({
    super.key,
    this.url,
    this.size = 46,
    this.radius = FrostRadius.sm,
    this.iconSize,
    this.shadow = false,
  });

  final String? url;
  final double size;
  final double radius;
  final double? iconSize;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final placeholder = DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2846), Color(0xFF15172A)],
        ),
      ),
      child: Center(
        child: Icon(AppIcons.musicNotes,
            size: iconSize ?? size * 0.32, color: FrostColors.textFaint),
      ),
    );

    Widget inner = placeholder;
    if (url != null && url!.isNotEmpty) {
      inner = CachedNetworkImage(
        imageUrl: url!,
        fit: BoxFit.cover,
        placeholder: (_, __) => placeholder,
        errorWidget: (_, __, ___) => placeholder,
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: FrostColors.borderFaint),
        boxShadow: shadow ? FrostFx.shadowLg : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: inner,
    );
  }
}
