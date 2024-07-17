class Question {
  int? questionId;
  String word;
  String correctOption;
  String option1;
  String option2;
  String option3;
  int level;

  Question({
    this.questionId,
    required this.word,
    required this.correctOption,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'question_id': questionId,
      'word': word,
      'correct_option': correctOption,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'level': level,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['question_id'],
      word: map['word'],
      correctOption: map['correct_option'],
      option1: map['option1'],
      option2: map['option2'],
      option3: map['option3'],
      level: map['level'],
    );
  }
}
