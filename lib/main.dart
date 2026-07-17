import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/root_shell.dart';
import 'theme/frost_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const VinylerApp());
}

class VinylerApp extends StatelessWidget {
  const VinylerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vinyler',
      debugShowCheckedModeBanner: false,
      theme: frostTheme(),
      home: const RootShell(),
    );
  }
}
