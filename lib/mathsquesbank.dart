import 'dart:convert';
import 'ques.dart';
import 'package:http/http.dart' as http;

class MathQuiz {
  List<Question> _QuestionBox = [];
  int _questionNo = 0;

  Future<void> fetchQuestions() async {
    // Very Very Imp on how to get Whole result array
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=19&type=multiple')); //this no 19 can change everything literally everything what if i just change it for fetching different categories than optimization would be on peak we can create a drop down menu for selecting different categories more engaging user experience (ab time nhi hai pehle sochna tha)
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)[
          'results']; // heres the deal it calls the dynamic array to give the array 'results'
      _QuestionBox = data
          .map((json) => Question.fromJson(json))
          .toList(); // here i store the questions in the questionbox
    } else {
      print('Failed to load questions');
    }
  }

  void nextQuestion() {
    if (_questionNo < _QuestionBox.length - 1) {
      _questionNo++;
    }
  }

  void previousQuestion() {
    if (_questionNo > 0) {
      _questionNo--;
    }
  }

  int questionNo() {
    return _questionNo;
  }

  String getquestiontext() {
    return _QuestionBox[_questionNo].questionText;
  }

  String getcorrectans() {
    return _QuestionBox[_questionNo].correctAnswer;
  }

  String getCurrentOption(int a) {
    return _QuestionBox[_questionNo].options[a];
  }

  String getdifficulty() {
    return _QuestionBox[_questionNo].difficulty;
  }

  bool isLastQuestion() {
    return _questionNo == _QuestionBox.length - 1;
  }
}
