/// A single review. One review per album per user (editable/deletable), per the
/// handoff review endpoints.
class Review {
  const Review({
    required this.id,
    required this.author,
    required this.rating,
    required this.body,
    required this.relativeTime,
    this.avatarInitial,
  });

  final String id;
  final String author;
  final int rating; // 1..5
  final String body;
  final String relativeTime; // "3일 전"
  final String? avatarInitial;

  Review copyWith({int? rating, String? body}) => Review(
        id: id,
        author: author,
        rating: rating ?? this.rating,
        body: body ?? this.body,
        relativeTime: relativeTime,
        avatarInitial: avatarInitial,
      );
}

/// Aggregate rating summary for the review list header (average + histogram).
class RatingSummary {
  const RatingSummary({required this.average, required this.total, required this.buckets});

  final double average;
  final int total;

  /// Count per star, index 0 = 1-star … index 4 = 5-star.
  final List<int> buckets;

  double fraction(int starIndex) {
    if (total == 0) return 0;
    return buckets[starIndex] / total;
  }
}
