import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';

class _Tab {
  const _Tab(this.icon, this.activeIcon, this.label, {this.large = false});
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool large;
}

/// 플로팅 글래스 탭바 (4탭: 홈 / 검색 / 스캔 / 마이).
class FloatingTabBar extends StatelessWidget {
  const FloatingTabBar({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  List<_Tab> get _tabs => [
        _Tab(AppIcons.house, AppIcons.houseFill, '홈'),
        _Tab(AppIcons.search, AppIcons.search, '검색'),
        _Tab(AppIcons.scan, AppIcons.scan, '스캔', large: true),
        _Tab(AppIcons.user, AppIcons.user, '마이'),
      ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 26,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FrostRadius.lg),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: FrostColors.glassBgStrong,
              borderRadius: BorderRadius.circular(FrostRadius.lg),
              border: Border.all(color: FrostColors.border),
              boxShadow: FrostFx.shadowMd,
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final t = _tabs[i];
                final active = i == currentIndex;
                final color = active ? FrostColors.accent : FrostColors.textFaint;
                return Expanded(
                  child: InkWell(
                    onTap: () => onTap(i),
                    borderRadius: BorderRadius.circular(FrostRadius.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(active ? t.activeIcon : t.icon, size: t.large ? 26 : 23, color: color),
                        const SizedBox(height: 3),
                        Text(t.label, style: TextStyle(fontSize: 10, color: color)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
