/// A vinyl release, mirroring the fields the Discogs-backed detail endpoint
/// returns (see handoff `GET /api/v1/vinyls/{discogs_id}`).
class Album {
  const Album({
    required this.discogsId,
    required this.title,
    required this.artist,
    required this.year,
    this.formats = const [],
    this.label,
    this.country,
    this.releasedFormatted,
    this.notes,
    this.rating = 0,
    this.reviewCount = 0,
    this.likesCount = 0,
    this.trackCount = 0,
    this.coverUrl,
    this.rankDelta,
  });

  final String discogsId;
  final String title;
  final String artist;
  final int year;

  /// formats.descriptions — e.g. ["LP", "Album", "Reissue"].
  final List<String> formats;
  final String? label;
  final String? country;
  final String? releasedFormatted; // e.g. "1997. 06. 16"
  final String? notes; // intro / description
  final double rating; // 0..5
  final int reviewCount;
  final int likesCount;
  final int trackCount;

  /// Discogs image URL. Null → render the placeholder cover.
  final String? coverUrl;

  /// Chart movement marker for the home ranking ("▲ 2", "▬", "NEW").
  final String? rankDelta;

  String get artistUpper => artist.toUpperCase();
}
