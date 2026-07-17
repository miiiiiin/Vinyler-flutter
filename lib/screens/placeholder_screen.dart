import 'package:flutter/material.dart';
import '../theme/frost_theme.dart';
import '../widgets/frost_button.dart';

/// core flow 외 탭(검색·마이) 자리표시자. Frost 글래스 톤 유지.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.title, required this.icon, required this.note});
  final String title;
  final IconData icon;
  final String note;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: FrostSpace.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: FrostColors.glassBg,
                        borderRadius: BorderRadius.circular(FrostRadius.lg),
                        border: Border.all(color: FrostColors.borderFaint),
                      ),
                      child: Icon(icon, size: 32, color: FrostColors.accent),
                    ),
                    const SizedBox(height: 18),
                    Text(note,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: FrostColors.textMuted, height: 1.6)),
                    const SizedBox(height: 20),
                    const FrostButton(label: '준비 중', kind: FrostButtonKind.secondary, height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
