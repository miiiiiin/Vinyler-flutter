import 'package:flutter/material.dart';

import '../data/app_store.dart';
import '../data/mock_data.dart';
import '../models/album.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/cover_art.dart';
import '../widgets/frost_button.dart';
import '../widgets/frost_tag.dart';
import '../widgets/star_rating.dart';
import 'review_write_screen.dart';

/// 05 · 음반 상세 (5A 클래식 스크롤, Frost). GET /vinyls/{discogsId}
class AlbumDetailScreen extends StatefulWidget {
  const AlbumDetailScreen({super.key, required this.album});
  final Album album;
  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  bool _tracksOpen = false;
  final _store = AppStore.instance;
  Album get album => widget.album;

  @override
  void initState() {
    super.initState();
    if (album.discogsId == MockData.okComputer.discogsId) {
      _store.seedReviews(album.discogsId, MockData.okComputerReviews);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AuroraScaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _store,
          builder: (context, _) {
            final liked = _store.isLiked(album.discogsId);
            final listened = _store.isListened(album.discogsId);
            final likeCount = _store.likeCount(album.discogsId, album.likesCount);
            return Column(
              children: [
                _topBar(),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(FrostSpace.screenPadding, 0, FrostSpace.screenPadding, 28),
                    children: [
                      _hero(),
                      Text(album.artistUpper,
                          style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 1.4,
                              fontWeight: FontWeight.w600,
                              color: FrostColors.accent300)),
                      const SizedBox(height: 4),
                      Text(album.title, style: t.headlineMedium),
                      const SizedBox(height: 12),
                      _metaRow(),
                      const SizedBox(height: 20),
                      _actions(liked: liked, listened: listened, likeCount: likeCount),
                      const SizedBox(height: 26),
                      Text('소개', style: t.titleMedium),
                      const SizedBox(height: 8),
                      Text(album.notes ?? '',
                          style: const TextStyle(fontSize: 13, height: 1.65, color: FrostColors.textMuted)),
                      const SizedBox(height: 8),
                      const Text('Discogs에서 제공하는 데이터입니다 →',
                          style: TextStyle(fontSize: 11, color: FrostColors.accent700)),
                      const SizedBox(height: 22),
                      _tracklist(),
                      const SizedBox(height: 22),
                      _reviews(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(AppIcons.arrowLeft, size: 24, color: FrostColors.text),
          ),
          Row(children: [
            Icon(AppIcons.shareNetwork, size: 22, color: FrostColors.textMuted),
            const SizedBox(width: 18),
            Icon(AppIcons.dotsThree, size: 22, color: FrostColors.textMuted),
          ]),
        ],
      ),
    );
  }

  Widget _hero() {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 26),
      child: SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(6, -3),
              child: SizedBox(width: 184, height: 184, child: CustomPaint(painter: _VinylPainter())),
            ),
            CoverArt(url: album.coverUrl, size: 196, radius: FrostRadius.md, iconSize: 44, shadow: true),
          ],
        ),
      ),
    );
  }

  Widget _metaRow() {
    return Row(
      children: [
        Text('${album.year}', style: const TextStyle(fontSize: 13, color: FrostColors.textMuted)),
        const SizedBox(width: 8),
        const Text('·', style: TextStyle(color: FrostColors.textFaint)),
        const SizedBox(width: 8),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [for (final f in album.formats) FrostTag(f)],
          ),
        ),
        Icon(AppIcons.starFill, size: 13, color: FrostColors.accent),
        const SizedBox(width: 4),
        Text(album.rating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: FrostColors.text)),
      ],
    );
  }

  Widget _actions({required bool liked, required bool listened, required int likeCount}) {
    return Row(
      children: [
        Expanded(
          child: FrostButton(
            label: '찜 $likeCount',
            icon: AppIcons.heartFill,
            iconColor: liked ? FrostColors.accent : FrostColors.textMuted,
            kind: liked ? FrostButtonKind.primary : FrostButtonKind.secondary,
            height: 46,
            onPressed: () => _store.toggleLike(album.discogsId, album.likesCount),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FrostButton(
            label: listened ? '감상함' : '감상',
            icon: listened ? AppIcons.checkCircleFill : AppIcons.checkCircle,
            iconColor: listened ? FrostColors.accent : FrostColors.text,
            kind: FrostButtonKind.secondary,
            height: 46,
            onPressed: () => _store.toggleListen(album.discogsId),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 52,
          height: 46,
          child: FrostButton(
            label: '',
            icon: AppIcons.playFill,
            iconColor: FrostColors.youtube,
            kind: FrostButtonKind.secondary,
            height: 46,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _tracklist() {
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _tracksOpen = !_tracksOpen),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: FrostColors.borderFaint),
                bottom: BorderSide(color: FrostColors.borderFaint),
              ),
            ),
            child: Row(
              children: [
                Text.rich(TextSpan(
                  text: '트랙리스트 ',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: FrostColors.text),
                  children: [
                    TextSpan(
                        text: '${album.trackCount}곡',
                        style: const TextStyle(fontWeight: FontWeight.w400, color: FrostColors.textFaint)),
                  ],
                )),
                const Spacer(),
                AnimatedRotation(
                  turns: _tracksOpen ? 0.5 : 0,
                  duration: FrostFx.durFast,
                  child: Icon(AppIcons.caretDown, size: 18, color: FrostColors.textFaint),
                ),
              ],
            ),
          ),
        ),
        if (_tracksOpen)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                for (var i = 0; i < MockData.okComputerTracks.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(children: [
                      SizedBox(
                          width: 26,
                          child: Text('${i + 1}',
                              style: const TextStyle(fontSize: 13, color: FrostColors.textFaint))),
                      Expanded(
                          child: Text(MockData.okComputerTracks[i],
                              style: const TextStyle(fontSize: 13, color: FrostColors.text))),
                    ]),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _reviews() {
    final reviews = _store.reviewsFor(album.discogsId);
    final mine = _store.myReview(album.discogsId);
    final count = reviews.isEmpty ? album.reviewCount : reviews.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(TextSpan(
              text: '리뷰 ',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: FrostColors.text),
              children: [
                TextSpan(
                    text: '$count',
                    style: const TextStyle(fontWeight: FontWeight.w400, color: FrostColors.textFaint)),
              ],
            )),
            const Text('모두 보기', style: TextStyle(fontSize: 13, color: FrostColors.accent)),
          ],
        ),
        const SizedBox(height: 14),
        if (reviews.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: const Color(0x1F9D90E8),
                    shape: BoxShape.circle,
                    border: Border.all(color: FrostColors.borderFaint)),
                alignment: Alignment.center,
                child: Text(reviews.first.avatarInitial ?? '·',
                    style: const TextStyle(fontSize: 13, color: FrostColors.accent200)),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(reviews.first.author,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: FrostColors.text)),
                      const SizedBox(width: 8),
                      StarRating(rating: reviews.first.rating.toDouble(), size: 12),
                    ]),
                    const SizedBox(height: 3),
                    Text(reviews.first.body,
                        style: const TextStyle(fontSize: 13, height: 1.55, color: FrostColors.textMuted)),
                  ],
                ),
              ),
            ],
          ),
        const SizedBox(height: 16),
        FrostButton(
          label: mine == null ? '리뷰 쓰기' : '내 리뷰 수정',
          icon: AppIcons.pencil,
          kind: FrostButtonKind.secondary,
          height: 46,
          expand: true,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ReviewWriteScreen(album: album)),
          ),
        ),
      ],
    );
  }
}

class _VinylPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFF0A0C16));
    final groove = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF1A1C2E);
    for (double r = radius - 4; r > radius * 0.32; r -= 4) {
      canvas.drawCircle(center, r, groove);
    }
    canvas.drawCircle(center, radius * 0.28, Paint()..color = FrostColors.accent700);
    canvas.drawCircle(center, radius * 0.05, Paint()..color = const Color(0xFF0A0C16));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
