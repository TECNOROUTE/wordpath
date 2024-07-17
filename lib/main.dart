import 'package:flutter/material.dart';
import 'package:wordpath/database/database-helper.dart';
import 'models/question.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Word Path')),
      body: FutureBuilder<List<Question>>(
        future: DatabaseHelper().getQuestionsByLevel(1),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].word),
                subtitle: Text(snapshot.data![index].correctOption),
              );
            },
          );
        },
      ),
    );
  }
}
