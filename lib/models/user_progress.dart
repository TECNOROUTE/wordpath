class UserProgress {
  int? progressId;
  int userId;
  int questionId;
  bool isCorrect;
  DateTime timestamp;

  UserProgress({
    this.progressId,
    required this.userId,
    required this.questionId,
    required this.isCorrect,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'progress_id': progressId,
      'user_id': userId,
      'question_id': questionId,
      'is_correct': isCorrect ? 1 : 0,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      progressId: map['progress_id'],
      userId: map['user_id'],
      questionId: map['question_id'],
      isCorrect: map['is_correct'] == 1,
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
