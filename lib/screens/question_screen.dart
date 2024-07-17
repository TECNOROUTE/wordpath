import 'package:flutter/material.dart';
import 'package:wordpath/database/database-helper.dart';

import 'package:wordpath/models/question.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final dbHelper = DatabaseHelper();
    List<Question> loadedQuestions = await dbHelper.getQuestionsByLevel(1);
    setState(() {
      questions = loadedQuestions;
      isLoading = false;
    });
  }

  void _checkAnswer(String selectedOption) {
    if (questions[currentQuestionIndex].correctOption == selectedOption) {
      setState(() {
        currentQuestionIndex++;
        if (currentQuestionIndex >= questions.length) {
          // Tüm sorular bitti
          currentQuestionIndex = 0;
          _showCompletionDialog();
        }
      });
    } else {
      // Yanlış cevap
      _showIncorrectAnswerDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tebrikler!'),
        content: Text('Tüm soruları doğru cevapladınız!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  void _showIncorrectAnswerDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Yanlış Cevap'),
        content: Text('Tekrar deneyin!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Word Path')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Word Path')),
        body: Center(child: Text('Sorular yüklenemedi')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Word Path')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              questions[currentQuestionIndex].word,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ..._buildOptions(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOptions() {
    List<String> options = [
      questions[currentQuestionIndex].correctOption,
      questions[currentQuestionIndex].option1,
      questions[currentQuestionIndex].option2,
      questions[currentQuestionIndex].option3,
    ];
    options.shuffle();

    return options.map((option) {
      return ElevatedButton(
        onPressed: () => _checkAnswer(option),
        child: Text(option),
      );
    }).toList();
  }
}
