class Question {
  String difficulty;
  String type;
  String questiontext;
  List<String> options;
  int correctanswerindex;

  Question(
      {required this.difficulty,
      required this.type,
      required this.questiontext,
      required this.options,
      required this.correctanswerindex});
}

class sportsQuizBrain {
  int _questionNo = 0;
  List<Question> _questionBox = [
    Question(
        difficulty: 'medium',
        type: 'multiple',
        questiontext: 'Which country is hosting the 2022 FIFA World Cup?',
        options: ['Uganda', 'Vietnam', 'Bolivia', 'Qatar'],
        correctanswerindex: 3),
    Question(
        difficulty: 'medium',
        type: 'multiple',
        questiontext: 'Who won the &quot;Champions League&quot; in 1999?',
        options: [
          'Barcelona',
          'Manchester United',
          'Bayern Munich',
          'Liverpool'
        ],
        correctanswerindex: 1),
    Question(
        difficulty: 'medium',
        type: 'multiple',
        questiontext: 'What is the oldest team in the NFL?',
        options: [
          'Chicago Bears',
          'Green Bay Packers',
          'Arizona Cardinals',
          'New York Giants'
        ],
        correctanswerindex: 2),
    Question(
        difficulty: 'easy',
        type: 'multiple',
        questiontext:
            'Who won the premier league title in the 2015-2016 season following a fairy tale run?',
        options: [
          'Tottenham Hotspur',
          'Watford',
          'Stoke City',
          'Leicester City'
        ],
        correctanswerindex: 3),
    Question(
        difficulty: 'hard',
        type: 'multiple',
        questiontext:
            'What is the full name of the footballer &quot;Cristiano Ronaldo&quot;',
        options: [
          'Cristiano Ronaldo dos Santos Aveiro',
          'Cristiano Ronaldo los Santos Diego',
          'Cristiano Armando Diego Ronaldo',
          'Cristiano Luis Armando Ronaldo',
        ],
        correctanswerindex: 0),
    Question(
        difficulty: 'easy',
        type: 'multiple',
        questiontext:
            'Which driver has been the Formula 1 world champion for a record 7 times?',
        options: [
          "Ayrton Senna",
          "Fernando Alonso",
          "Michael Schumacher",
          "Jim Clark",
        ],
        correctanswerindex: 2),
    Question(
        difficulty: 'easy',
        type: 'multiple',
        questiontext:
            'Who won the 2016 Formula 1 World Driver&#039;s Championship?',
        options: [
          "Lewis Hamilton",
          "Max Verstappen",
          "Kimi Raikkonen",
          "Nico Rosberg",
        ],
        correctanswerindex: 3),
    Question(
        difficulty: 'easy',
        type: 'multiple',
        questiontext: 'When was the FC Schalke 04 founded?',
        options: [
          "1909",
          "2008",
          "1904",
          "1999",
        ],
        correctanswerindex: 2),
    Question(
        difficulty: 'medium',
        type: 'multiple',
        questiontext:
            'Who was the British professional wrestler Shirley Crabtree better known as?',
        options: [
          "Giant Haystacks",
          "Big Daddy",
          "Kendo Nagasaki",
          "Masambula",
        ],
        correctanswerindex: 1),
  ];

  void nextQuestion() {
    if (_questionNo < _questionBox.length - 1) {
      _questionNo++;
    }
  }

  void previousQuestion() {
    if (_questionNo > 0) {
      _questionNo--;
    }
  }

  int getQuestionNo() {
    return _questionNo;
  }

  String getCurrentOption(int s) {
    return _questionBox[_questionNo].options[s];
  }

  String getCurrentQuestion() {
    return _questionBox[_questionNo].questiontext;
  }

  int getcorrectans() {
    return _questionBox[_questionNo].correctanswerindex;
  }

  int totalq() {
    return _questionBox.length;
  }

  String getdifficulty() {
    return _questionBox[_questionNo].difficulty;
  }

  bool isLastQuestion() {
    return _questionNo == _questionBox.length - 1;
  }
}
