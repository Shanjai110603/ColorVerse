import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/editor_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: LevelEditorApp(),
    ),
  );
}

/// Root widget for the ColorVerse Level Editor desktop app.
class LevelEditorApp extends StatelessWidget {
  const LevelEditorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorVerse Level Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF89B4FA),
          brightness: Brightness.dark,
          surface: const Color(0xFF1E1E2E),
        ),
        scaffoldBackgroundColor: const Color(0xFF1E1E2E),
        useMaterial3: true,
        fontFamily: 'Segoe UI',
      ),
      home: const EditorScreen(),
    );
  }
}
