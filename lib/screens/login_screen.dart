import 'package:flutter/material.dart';
import '../theme/app_icons.dart';
import '../theme/frost_theme.dart';
import '../widgets/frost_button.dart';
import '../widgets/frost_input.dart';

/// 01 · 로그인. POST /api/v1/auth/login
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return AuroraScaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: const Color(0x1F9D90E8),
                        borderRadius: BorderRadius.circular(FrostRadius.lg),
                        border: Border.all(color: const Color(0x599D90E8)),
                        boxShadow: const [FrostFx.glowAccent],
                      ),
                      child: Icon(AppIcons.vinylFill, size: 42, color: FrostColors.accent200),
                    ),
                    const SizedBox(height: 18),
                    Text('Vinyler', style: t.displaySmall?.copyWith(fontSize: 32)),
                    const SizedBox(height: 6),
                    const Text('LP를 스캔하고, 나만의 컬렉션을 기록하세요',
                        style: TextStyle(fontSize: 14, color: FrostColors.textFaint)),
                  ],
                ),
                const SizedBox(height: 40),
                const FrostInput(label: '이메일', hintText: 'you@vinyler.com'),
                const SizedBox(height: 14),
                const FrostInput(label: '비밀번호', obscureText: true, hintText: '••••••••'),
                const SizedBox(height: 24),
                FrostButton(label: '로그인', expand: true, onPressed: () {}),
                const SizedBox(height: 10),
                KakaoButton(label: '카카오로 계속하기', icon: AppIcons.chatCircleFill, onPressed: () {}),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('계정이 없으신가요? ',
                        style: TextStyle(fontSize: 14, color: FrostColors.textMuted)),
                    Text('회원가입',
                        style: t.bodyMedium?.copyWith(
                            color: FrostColors.accent, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
