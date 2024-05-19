import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'main.dart';
import 'sportsquesbank1.dart';
import 'ending.dart';
import 'dart:async';
import 'mathsquesbank.dart';

class maths extends StatefulWidget {
  const maths({super.key});

  @override
  State<maths> createState() => _sportsState();
}

class _sportsState extends State<maths> {
  double progressValue = 0.0;
  void incrementProgress() {
    setState(() {
      if (progressValue < 1.0) {
        progressValue += 0.1111;
      } else if (progressValue >= 1) {
        progressValue = 1.0;
      }
    });
  }

  void decrementProgress() {
    setState(() {
      if (progressValue > 0.0) {
        progressValue -= 0.1111;
      } else if (progressValue <= 0.0) {
        progressValue = 0.0;
      }
    });
  }

  MathQuiz quiz = MathQuiz();
  // first one is class and the second one is class name which calls quizbrain function.
// we did this to segregrate our work basically abstraction
  int a = 1;
  void increaseq() {
    if (a < 10) {
      a++;
    }
  }

  void decreaseq() {
    if (a > 1) {
      a--;
    }
  }

  late Timer timer; //REM logic Very Useful
  int rematime = 10;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (rematime > 0) {
          rematime--;
        } else {
          if (!quiz.isLastQuestion()) {
            scorekeeper.add(Icon(Icons.close, color: Colors.red));
          }
          timer.cancel();
          if (!quiz.isLastQuestion()) {
            quiz.nextQuestion();
            resetTimer();
            incrementProgress();
            increaseq();
          } else {
            rematime = 0;
            scorekeeper.add(Icon(Icons.close, color: Colors.red));
          }
        }
      });
    });
  }

  void resetTimer() {
    timer.cancel();
    setState(() {
      rematime = 10;
    });
    startTimer();
  }

  Widget options(int s) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () {
            String correctans = quiz.getcorrectans();
            if (correctans == quiz.getCurrentOption(s)) {
              scorekeeper.add(Icon(Icons.check, color: Colors.green));
            } else {
              scorekeeper.add(Icon(Icons.close, color: Colors.red));
            }
            if (quiz.isLastQuestion()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => end()),
              );
            } else {
              increaseq();
              incrementProgress();
              setState(() {
                quiz.nextQuestion();
                resetTimer();
              });
            }
          },
          child: Container(
            height: 50,
            width: 400,
            decoration: BoxDecoration(
                gradient: CustomScreen.myG,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                quiz.getCurrentOption(s),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // initstate is useful for one time initialisation
    super.initState();
    quiz.fetchQuestions();
    startTimer();
  }

  @override
  void dispose() {
    // dispose is contradictory to initstate
    timer.cancel();
    super.dispose();
  }

  List<Icon> scorekeeper = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Pattern.png'),
              fit: BoxFit.cover,
            ),
            gradient: CustomScreen.myGradient,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade700),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        decreaseq();
                        decrementProgress();
                        setState(() {
                          quiz.previousQuestion();
                          resetTimer();
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios_outlined),
                      color: Colors.white,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Difficulty : ${quiz.getdifficulty()}', //this method is called string interpolation
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Q$a/10',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                LinearProgressIndicator(
                  value: progressValue,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  minHeight: 10,
                ),
                Expanded(
                  flex: 5, //flex is basica
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        quiz.getquestiontext(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Time left: $rematime seconds',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
                options(0),
                options(1),
                options(2),
                options(3),
                Row(
                  children: scorekeeper, //for later purpose
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
