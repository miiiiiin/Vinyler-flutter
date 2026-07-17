import 'package:flutter/material.dart';

import '../models/album.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/floating_tab_bar.dart';
import 'album_detail_screen.dart';
import 'home_screen.dart';
import 'placeholder_screen.dart';
import 'scan_screen.dart';

/// 앱 셸: 오로라 배경 위에 탭 페이지(홈/검색/마이) + 플로팅 글래스 탭바.
/// 스캔(index 2)은 페이지가 아니라 전체화면 카메라 라우트.
class RootShell extends StatefulWidget {
  const RootShell({super.key});
  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _selectedTab = 0;
  static const Map<int, int> _tabToPage = {0: 0, 1: 1, 3: 2};

  void _openAlbum(Album album) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AlbumDetailScreen(album: album)),
    );
  }

  Future<void> _openScan() async {
    await Navigator.of(context).push(
      MaterialPageRoute(fullscreenDialog: true, builder: (_) => const ScanScreen()),
    );
  }

  void _onTabTap(int index) {
    if (index == 2) {
      _openScan();
      return;
    }
    setState(() => _selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = _tabToPage[_selectedTab] ?? 0;
    return AuroraScaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: pageIndex,
            children: [
              HomeScreen(onOpenAlbum: _openAlbum),
              PlaceholderScreen(
                title: '검색',
                icon: AppIcons.search,
                note: '한글 형태소 · 오타 보정 · 자동완성 검색\n(다음 빌드에서 연결)',
              ),
              PlaceholderScreen(
                title: '마이',
                icon: AppIcons.user,
                note: '프로필 · 보관함 · 팔로우\n(다음 빌드에서 연결)',
              ),
            ],
          ),
          FloatingTabBar(currentIndex: _selectedTab, onTap: _onTabTap),
        ],
      ),
    );
  }
}
