import 'package:flutter/material.dart';
import 'package:wordpath/database/database-helper.dart';
import 'package:wordpath/screens/question_screen.dart';
import 'models/question.dart';
import 'screens/home_screen.dart';
import 'screens/continue_game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();

  // Örnek veritabanı işlemi: Kelime çifti eklemek
  await dbHelper.insertQuestion(Question(
    word: 'book',
    correctOption: 'kitap',
    option1: 'defter',
    option2: 'kalem',
    option3: 'silgi',
    level: 1,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/new_game': (context) => QuestionScreen(),
        '/continue_game': (context) => const ContinueGameScreen(),
      },
    );
  }
}
