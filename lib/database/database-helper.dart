import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/question.dart';
import '../models/user_progress.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Users (
        user_id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT,
        password TEXT,
        current_level INTEGER,
        score INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE Questions (
        question_id INTEGER PRIMARY KEY AUTOINCREMENT,
        word TEXT,
        correct_option TEXT,
        option1 TEXT,
        option2 TEXT,
        option3 TEXT,
        level INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE UserProgress (
        progress_id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        question_id INTEGER,
        is_correct INTEGER,
        timestamp TEXT,
        FOREIGN KEY (user_id) REFERENCES Users(user_id),
        FOREIGN KEY (question_id) REFERENCES Questions(question_id)
      )
    ''');
  }

  // Kullanıcı işlemleri
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('Users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('Users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Soru işlemleri
  Future<int> insertQuestion(Question question) async {
    Database db = await database;
    return await db.insert('Questions', question.toMap());
  }

  Future<List<Question>> getQuestionsByLevel(int level) async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('Questions', where: 'level = ?', whereArgs: [level]);
    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  // Kullanıcı ilerleme işlemleri
  Future<int> insertUserProgress(UserProgress progress) async {
    Database db = await database;
    return await db.insert('UserProgress', progress.toMap());
  }

  Future<List<UserProgress>> getUserProgress(int userId) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db
        .query('UserProgress', where: 'user_id = ?', whereArgs: [userId]);
    return List.generate(maps.length, (i) {
      return UserProgress.fromMap(maps[i]);
    });
  }
}
