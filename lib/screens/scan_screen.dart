import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/frost_button.dart';
import 'album_detail_screen.dart';

/// 06 · 스캔 — 몰입형 뷰파인더 (4A). 카메라는 시뮬레이션.
/// 실제로는 mobile_scanner를 _cameraSurface 자리에 넣고 detect → _onRecognized.
class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _line;
  bool _flash = false;

  @override
  void initState() {
    super.initState();
    _line = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _line.dispose();
    super.dispose();
  }

  void _onRecognized() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => AlbumDetailScreen(album: MockData.okComputer)),
    );
  }

  Widget _glassBtn(IconData icon, VoidCallback onTap, {Color? color}) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        color: const Color(0x99141522),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Icon(icon, size: 20, color: color ?? FrostColors.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: FrostColors.bgDeep,
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _onRecognized,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.24),
                    radius: 0.9,
                    colors: [Color(0xFF1B1E33), Color(0xFF0B0C16), Color(0xFF06070C)],
                    stops: [0, 0.6, 1],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: FrostSpace.screenPadding,
            right: FrostSpace.screenPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _glassBtn(AppIcons.x, () => Navigator.of(context).maybePop()),
                const Text('스캔',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: FrostColors.text)),
                _glassBtn(AppIcons.lightning, () => setState(() => _flash = !_flash),
                    color: _flash ? FrostColors.accent : FrostColors.text),
              ],
            ),
          ),
          Center(
            child: FractionalTranslation(
              translation: const Offset(0, -0.14),
              child: SizedBox(
                width: 250,
                height: 150,
                child: Stack(children: [
                  ..._brackets(),
                  AnimatedBuilder(
                    animation: _line,
                    builder: (context, _) => Positioned(
                      left: 14,
                      right: 14,
                      top: 8 + _line.value * 134,
                      child: Container(
                        height: 2,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, FrostColors.accent, Colors.transparent]),
                          boxShadow: [FrostFx.glowAccent],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Positioned(
            top: h * 0.5 + 118,
            left: 40,
            right: 40,
            child: const Text('LP 뒷면의 바코드를 사각형 안에 맞춰주세요',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: FrostColors.text)),
          ),
          Positioned(
            bottom: 44,
            left: 0,
            right: 0,
            child: Center(
              child: FrostButton(
                label: '직접 검색하기',
                icon: AppIcons.keyboard,
                kind: FrostButtonKind.secondary,
                height: 46,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _brackets() {
    const c = FrostColors.accent;
    const w = 3.0;
    const len = 34.0;
    BorderSide s() => const BorderSide(color: c, width: w);
    return [
      Positioned(top: 0, left: 0, child: Container(width: len, height: len, decoration: BoxDecoration(border: Border(top: s(), left: s()), borderRadius: const BorderRadius.only(topLeft: Radius.circular(8))))),
      Positioned(top: 0, right: 0, child: Container(width: len, height: len, decoration: BoxDecoration(border: Border(top: s(), right: s()), borderRadius: const BorderRadius.only(topRight: Radius.circular(8))))),
      Positioned(bottom: 0, left: 0, child: Container(width: len, height: len, decoration: BoxDecoration(border: Border(bottom: s(), left: s()), borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8))))),
      Positioned(bottom: 0, right: 0, child: Container(width: len, height: len, decoration: BoxDecoration(border: Border(bottom: s(), right: s()), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8))))),
    ];
  }
}
