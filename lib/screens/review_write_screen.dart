import 'package:flutter/material.dart';

import '../data/app_store.dart';
import '../models/album.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/cover_art.dart';
import '../widgets/frost_button.dart';
import '../widgets/star_rating.dart';

/// 08 · 리뷰 쓰기 (Frost). 한 음반당 한 리뷰. POST /reviews/create
class ReviewWriteScreen extends StatefulWidget {
  const ReviewWriteScreen({super.key, required this.album});
  final Album album;
  @override
  State<ReviewWriteScreen> createState() => _ReviewWriteScreenState();
}

class _ReviewWriteScreenState extends State<ReviewWriteScreen> {
  static const int _maxLen = 500;
  final _store = AppStore.instance;
  late final TextEditingController _controller;
  int _rating = 0;

  static const _labels = {1: '별로예요', 2: '아쉬워요', 3: '보통이에요', 4: '좋아요', 5: '최고예요'};

  @override
  void initState() {
    super.initState();
    final existing = _store.myReview(widget.album.discogsId);
    _rating = existing?.rating ?? 0;
    _controller = TextEditingController(text: existing?.body ?? '');
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _canSubmit => _rating > 0 && _controller.text.trim().isNotEmpty;

  void _submit() {
    if (!_canSubmit) return;
    _store.upsertMyReview(widget.album.discogsId, rating: _rating, body: _controller.text.trim());
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final len = _controller.text.length;
    return AuroraScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: Icon(AppIcons.x, size: 22, color: FrostColors.text),
                  ),
                  const Spacer(),
                  Text('리뷰 쓰기', style: t.titleMedium),
                  const Spacer(),
                  GestureDetector(
                    onTap: _canSubmit ? _submit : null,
                    child: Text('등록',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _canSubmit ? FrostColors.accent : FrostColors.accent700)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(FrostSpace.screenPadding, 8, FrostSpace.screenPadding, 24),
                children: [
                  Row(
                    children: [
                      CoverArt(url: widget.album.coverUrl, size: 54, radius: FrostRadius.sm),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.album.artistUpper,
                                style: const TextStyle(
                                    fontSize: 11,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: FrostColors.accent300)),
                            const SizedBox(height: 3),
                            Text(widget.album.title,
                                maxLines: 1, overflow: TextOverflow.ellipsis, style: t.titleMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Center(
                      child: Text('이 음반, 어떠셨나요?',
                          style: TextStyle(fontSize: 15, color: FrostColors.textMuted))),
                  const SizedBox(height: 18),
                  StarInput(value: _rating, onChanged: (v) => setState(() => _rating = v)),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      _rating == 0 ? '별점을 선택하세요' : '$_rating점 · ${_labels[_rating]}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: _rating == 0 ? FrostColors.textFaint : FrostColors.accent),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    maxLines: null,
                    minLines: 6,
                    maxLength: _maxLen,
                    buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                    style: const TextStyle(fontSize: 13, height: 1.6, color: FrostColors.text),
                    cursorColor: FrostColors.accent,
                    decoration: InputDecoration(
                      hintText: '이 음반에 대한 감상을 남겨주세요.',
                      hintStyle: const TextStyle(color: FrostColors.textFaint),
                      filled: true,
                      fillColor: const Color(0x0DFFFFFF),
                      contentPadding: const EdgeInsets.all(14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: FrostColors.borderFaint),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Color(0x8C9D90E8), width: 1.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('$len / $_maxLen',
                        style: const TextStyle(fontSize: 11, color: FrostColors.textMuted)),
                  ),
                  const SizedBox(height: 20),
                  FrostButton(
                    label: '리뷰 등록하기',
                    expand: true,
                    onPressed: _canSubmit ? _submit : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
