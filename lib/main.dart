import 'package:flutter/material.dart';
import 'quesBank1.dart';
import 'homescreen.dart';
import 'ending.dart';
import 'dart:async';

void main() => runApp(Trivia());

class Trivia extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CustomScreen(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper =
      []; //rem i have to add Icon this list later somewhwre
  double progressValue = 0.0;
  void incrementProgress() {
    // created this to increase the progress bar value by 1/12(since there are 13 q)
    setState(() {
      if (progressValue < 1.0) {
        progressValue += 0.08333;
      } else if (progressValue >= 0.99996) {
        progressValue = 1.0;
      }
    });
  }

  void decrementProgress() {
    // decrement as same logic as above
    setState(() {
      if (progressValue > 0.0) {
        progressValue -= 0.08333;
      } else if (progressValue <= 0.0) {
        progressValue = 0.0;
      }
    });
  }

  quizbrain maafi =
      quizbrain(); // first one is class and the second one is class name which calls quizbrain function.
// we did this to segregrate our work basically abstraction(these are all for me)
  int a = 1;
  void increaseq() {
    //qno increment
    if (a < 13) {
      a++;
    }
  }

  void decreaseq() {
    if (a > 1) {
      a--;
    }
  }

  late Timer timer; //steps to add timer in quiz
  int rematime = 5;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (rematime > 0) {
          rematime--;
        } else {
          if (!maafi.isLastQuestion()) {
            scorekeeper.add(Icon(Icons.close, color: Colors.red));
          }
          timer.cancel();
          if (!maafi.isLastQuestion()) {
            maafi.nextQuestion();
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
      rematime = 5;
    });
    startTimer();
  }

  void pressButton(bool a) {
    bool correctans = maafi.getcorrectans();
    if (correctans == a) {
      scorekeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scorekeeper.add(Icon(Icons.close, color: Colors.red));
    }
    if (maafi.isLastQuestion()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => end()),
      );
    } else {
      increaseq();
      incrementProgress();
      setState(() {
        maafi.nextQuestion();
        resetTimer();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
                          maafi.previousQuestion();
                          resetTimer();
                        });
                      },
                      icon: Icon(Icons.arrow_back_ios_outlined),
                      color: Colors.white,
                    ),
                    SizedBox(width: 80),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Q$a/13',
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
                        maafi.getquestiontext(),
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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.white),
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        'True',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      onPressed: () {
                        pressButton(true);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.white),
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        'False',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        pressButton(false);
                      },
                    ),
                  ),
                ),
                Row(
                  children: scorekeeper, //for later
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
