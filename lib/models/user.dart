class User {
  int? userId;
  String username;
  String email;
  String password;
  int currentLevel;
  int score;

  User({
    this.userId,
    required this.username,
    required this.email,
    required this.password,
    this.currentLevel = 1,
    this.score = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'password': password,
      'current_level': currentLevel,
      'score': score,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      username: map['username'],
      email: map['email'],
      password: map['password'],
      currentLevel: map['current_level'],
      score: map['score'],
    );
  }
}
