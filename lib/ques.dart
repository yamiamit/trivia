class Question {
  //This dart file is the key To Success Xd:)
  String difficulty;
  String type;
  String questionText;
  String correctAnswer;
  List<String> options;

  Question({
    required this.difficulty,
    required this.type,
    required this.questionText,
    required this.correctAnswer,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> incorrectAnswers =
        List<String>.from(json['incorrect_answers']);
    String correctAnswer = json['correct_answer'];

    List<String> allOptions = [
      ...incorrectAnswers,
      correctAnswer
    ]; //...is used to combine strings with string
    allOptions.shuffle(); // used to shuffle all options

    return Question(
      difficulty: json['difficulty'],
      type: json['type'],
      questionText: json['question'],
      correctAnswer: correctAnswer,
      options: allOptions,
    );
  }
}
