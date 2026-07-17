import 'package:flutter/foundation.dart';

import '../models/review.dart';

/// Lightweight in-memory record store standing in for the backend during the
/// core-flow scaffold. Holds like/listen flags and reviews keyed by discogsId.
///
/// Uses only [ChangeNotifier] from the SDK — swap for your real state layer
/// (Riverpod/Bloc/etc.) behind the same method surface when wiring the API.
class AppStore extends ChangeNotifier {
  AppStore._();
  static final AppStore instance = AppStore._();

  final Set<String> _liked = {};
  final Set<String> _listened = {};
  final Map<String, List<Review>> _reviews = {};
  final Map<String, int> _likeCountOverride = {};

  bool isLiked(String discogsId) => _liked.contains(discogsId);
  bool isListened(String discogsId) => _listened.contains(discogsId);

  /// Reviews for an album (defensively copied).
  List<Review> reviewsFor(String discogsId) =>
      List.unmodifiable(_reviews[discogsId] ?? const []);

  /// Effective like count = base count ± local toggle delta.
  int likeCount(String discogsId, int baseCount) {
    return _likeCountOverride[discogsId] ?? baseCount;
  }

  /// POST/DELETE /vinyls/likes — toggle, with likesCount kept in sync.
  void toggleLike(String discogsId, int baseCount) {
    final current = _likeCountOverride[discogsId] ?? baseCount;
    if (_liked.remove(discogsId)) {
      _likeCountOverride[discogsId] = current - 1;
    } else {
      _liked.add(discogsId);
      _likeCountOverride[discogsId] = current + 1;
    }
    notifyListeners();
  }

  /// POST /vinyls/listen — set the listened flag (toggle here for demo).
  void toggleListen(String discogsId) {
    if (!_listened.remove(discogsId)) _listened.add(discogsId);
    notifyListeners();
  }

  /// The current user's own review for this album, if any.
  Review? myReview(String discogsId) {
    final list = _reviews[discogsId];
    if (list == null) return null;
    for (final r in list) {
      if (r.id.startsWith('me:')) return r;
    }
    return null;
  }

  /// Create or update the current user's review (one per album).
  void upsertMyReview(String discogsId, {required int rating, required String body}) {
    final list = _reviews.putIfAbsent(discogsId, () => []);
    final idx = list.indexWhere((r) => r.id.startsWith('me:'));
    final review = Review(
      id: 'me:$discogsId',
      author: '나',
      rating: rating,
      body: body,
      relativeTime: '방금',
      avatarInitial: '나',
    );
    if (idx >= 0) {
      list[idx] = review;
    } else {
      list.insert(0, review);
    }
    notifyListeners();
  }

  /// Seed demo reviews (called once at startup).
  void seedReviews(String discogsId, List<Review> reviews) {
    _reviews.putIfAbsent(discogsId, () => List.of(reviews));
  }
}
