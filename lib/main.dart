// main.dart

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/new_game_screen.dart';
import 'screens/continue_game_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/new_game': (context) => const NewGameScreen(),
        '/continue_game': (context) => const ContinueGameScreen(),
      },
    );
  }
}
