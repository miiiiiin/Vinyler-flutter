import '../models/album.dart';
import '../models/review.dart';

/// Static sample content for the scaffold. Replace with API responses.
class MockData {
  MockData._();

  static const Album okComputer = Album(
    discogsId: '1',
    title: 'OK Computer',
    artist: 'Radiohead',
    year: 1997,
    formats: ['LP', 'Album', 'Reissue'],
    label: 'Parlophone',
    country: 'UK',
    releasedFormatted: '1997. 06. 16',
    notes:
        '1997년 발매된 세 번째 정규 앨범. 얼터너티브 록의 방향을 바꾼 기념비적 작품으로 평가받으며, '
        '‘Paranoid Android’ 등을 수록.',
    rating: 4.6,
    reviewCount: 86,
    likesCount: 128,
    trackCount: 12,
  );

  /// This-week AI pick shown in the home feature block.
  static const Album kindOfBlue = Album(
    discogsId: '2',
    title: 'Kind of Blue',
    artist: 'Miles Davis',
    year: 1959,
    formats: ['LP', 'Album'],
    rating: 4.8,
    reviewCount: 210,
    likesCount: 540,
    trackCount: 5,
    notes: '재즈 입문자가 가장 자주 스캔한 판. 당신의 감상 이력과 결이 맞아요.',
  );

  /// 이번 주 인기 LP 랭킹.
  static const List<Album> chart = [
    Album(
      discogsId: '3',
      title: 'The Dark Side of the Moon',
      artist: 'Pink Floyd',
      year: 1973,
      rankDelta: '▲ 2',
    ),
    Album(
      discogsId: '4',
      title: 'Abbey Road',
      artist: 'The Beatles',
      year: 1969,
      rankDelta: '▬',
    ),
    Album(
      discogsId: '5',
      title: 'Blonde',
      artist: 'Frank Ocean',
      year: 2016,
      rankDelta: 'NEW',
    ),
  ];

  /// 장르 트렌드 (Scenes).
  static const List<GenreTrend> scenes = [
    GenreTrend('Jazz', '＋18%', true),
    GenreTrend('City Pop', '＋11%', true),
    GenreTrend('Ambient', '＋4%', false),
  ];

  static const List<Review> okComputerReviews = [
    Review(
      id: 'r1',
      author: '현우',
      rating: 5,
      body: '몇 번을 들어도 질리지 않는 명반. 판 상태도 좋네요.',
      relativeTime: '2일 전',
      avatarInitial: '현',
    ),
    Review(
      id: 'r2',
      author: '지민',
      rating: 4,
      body: 'Paranoid Android 하나만으로도 소장 가치 충분. 리이슈 프레싱 품질 만족.',
      relativeTime: '5일 전',
      avatarInitial: '지',
    ),
    Review(
      id: 'r3',
      author: 'soojin',
      rating: 5,
      body: '얼터너티브 록의 교과서. 자켓 색감도 예쁘게 나왔어요.',
      relativeTime: '1주 전',
      avatarInitial: 'S',
    ),
  ];

  static const RatingSummary okComputerSummary = RatingSummary(
    average: 4.6,
    total: 86,
    // 1★ … 5★
    buckets: [1, 2, 6, 22, 55],
  );

  /// Tracklist for the collapse row (title only for the scaffold).
  static const List<String> okComputerTracks = [
    'Airbag',
    'Paranoid Android',
    'Subterranean Homesick Alien',
    'Exit Music (For a Film)',
    'Let Down',
    'Karma Police',
    'Fitter Happier',
    'Electioneering',
    'Climbing Up the Walls',
    'No Surprises',
    'Lucky',
    'The Tourist',
  ];
}

class GenreTrend {
  const GenreTrend(this.name, this.delta, this.trending);
  final String name;
  final String delta;
  final bool trending;
}
