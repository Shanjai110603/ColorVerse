import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/world_map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: ColorVerseApp(),
    ),
  );
}

/// Root application widget for ColorVerse.
class ColorVerseApp extends StatelessWidget {
  const ColorVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorVerse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF89B4FA),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF181825),
        useMaterial3: true,
      ),
      home: const WorldMapScreen(),
    );
  }
}
