import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/album.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/cover_art.dart';
import '../widgets/frost_tag.dart';

/// 02 · 홈 · 대시보드 — AI 추천 · 인기 LP 랭킹 · 장르 트렌드.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenAlbum});
  final ValueChanged<Album> onOpenAlbum;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(FrostSpace.screenPadding, 10, FrostSpace.screenPadding, 110),
        children: [
          // masthead
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('VOL.28 · 2026 W28',
                        style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.w600,
                            color: FrostColors.accent700)),
                    const SizedBox(height: 6),
                    Text('지금\n도는 판', style: t.displaySmall?.copyWith(height: 1.02)),
                  ],
                ),
              ),
              _bell(),
            ],
          ),
          const SizedBox(height: 22),
          // AI feature — glass card
          _AiFeature(album: MockData.kindOfBlue, onTap: () => onOpenAlbum(MockData.kindOfBlue)),
          const SizedBox(height: 24),
          _sectionRule(context, 'CHART', '전체'),
          const SizedBox(height: 6),
          ...List.generate(MockData.chart.length, (i) {
            final a = MockData.chart[i];
            return _ChartRow(rank: i + 1, album: a, onTap: () => onOpenAlbum(a));
          }),
          const SizedBox(height: 22),
          _sectionRule(context, 'SCENES', null),
          const SizedBox(height: 4),
          ...MockData.scenes.map(_sceneRow),
        ],
      ),
    );
  }

  Widget _bell() {
    return SizedBox(
      width: 26,
      height: 26,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(AppIcons.bell, size: 23, color: FrostColors.textMuted),
          Positioned(
            top: -1,
            right: -1,
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: FrostColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: FrostColors.bg, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionRule(BuildContext context, String label, String? trailing) {
    return Row(
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w600,
                color: FrostColors.text)),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [FrostColors.border, Colors.transparent]),
            ),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 12),
          Text(trailing, style: const TextStyle(fontSize: 11, color: FrostColors.accent)),
        ],
      ],
    );
  }

  Widget _sceneRow(GenreTrend g) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: FrostColors.borderFaint)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(g.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: g.trending ? FrostColors.text : FrostColors.textMuted)),
          Text(g.delta,
              style: TextStyle(
                  fontSize: 12, color: g.trending ? FrostColors.accent : FrostColors.textFaint)),
        ],
      ),
    );
  }
}

class _AiFeature extends StatelessWidget {
  const _AiFeature({required this.album, required this.onTap});
  final Album album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        radius: FrostRadius.lg,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(AppIcons.sparkleFill, size: 14, color: FrostColors.accent),
                const SizedBox(width: 6),
                const Text('이번 주의 발견',
                    style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w600,
                        color: FrostColors.accent300)),
                const SizedBox(width: 8),
                const FrostTag('AI', kind: FrostTagKind.accent),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kind of\nBlue',
                          style: t.headlineMedium?.copyWith(fontSize: 25, height: 1.08)),
                      const SizedBox(height: 10),
                      const Text('MILES DAVIS · 1959',
                          style: TextStyle(
                              fontSize: 11,
                              letterSpacing: 1.1,
                              fontWeight: FontWeight.w600,
                              color: FrostColors.textMuted)),
                      const SizedBox(height: 12),
                      Text(album.notes ?? '',
                          style: const TextStyle(
                              fontSize: 13, height: 1.55, color: FrostColors.textMuted)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                CoverArt(url: album.coverUrl, size: 96, radius: FrostRadius.md, shadow: true),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartRow extends StatelessWidget {
  const _ChartRow({required this.rank, required this.album, required this.onTap});
  final int rank;
  final Album album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final top = rank == 1;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          border: rank == 1
              ? null
              : const Border(top: BorderSide(color: FrostColors.borderFaint)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Text(
                rank.toString().padLeft(2, '0'),
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: top ? FrostColors.accent : FrostColors.textFaint),
              ),
            ),
            const SizedBox(width: 14),
            CoverArt(url: album.coverUrl, size: 44, radius: FrostRadius.sm),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(album.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: FrostColors.text)),
                  const SizedBox(height: 2),
                  Text(album.artist.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10.5, letterSpacing: 1, color: FrostColors.textFaint)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(album.rankDelta ?? '',
                style: TextStyle(
                    fontSize: album.rankDelta == 'NEW' ? 10 : 11,
                    letterSpacing: 0.6,
                    color: album.rankDelta == '▬' ? FrostColors.textFaint : FrostColors.accent)),
          ],
        ),
      ),
    );
  }
}
