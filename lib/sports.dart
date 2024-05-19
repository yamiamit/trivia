import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'main.dart';
import 'results.dart';
import 'sportsquesbank1.dart';
import 'ending.dart';
import 'dart:async';

class sports extends StatefulWidget {
  const sports({super.key});

  @override
  State<sports> createState() => _sportsState();
}

class _sportsState extends State<sports> {
  double progressValue = 0.0;
  void incrementProgress() {
    setState(() {
      if (progressValue < 1.0) {
        progressValue += 0.125;
      } else if (progressValue >= 1) {
        progressValue = 1.0;
      }
    });
  }

  void decrementProgress() {
    setState(() {
      if (progressValue > 0.0) {
        progressValue -= 0.125;
      } else if (progressValue <= 0.0) {
        progressValue = 0.0;
      }
    });
  }

  sportsQuizBrain maafi = sportsQuizBrain();
  // first one is class and the second one is class name which calls quizbrain function.
// we did this to segregrate our work basically abstraction
  int a = 1;
  void increaseq() {
    if (a < 9) {
      a++;
    }
  }

  void decreaseq() {
    if (a > 1) {
      a--;
    }
  }

  late Timer timer;
  int rematime = 10;
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
      rematime = 10;
    });
    startTimer();
  }

  int pointscored() {
    // rematime we could have used to give points on the basis of time
    if (rematime < 10 || rematime >= 9) {
      return 100;
    } else if (rematime < 9 && rematime >= 8) {
      return 90;
    } else if (rematime < 8 && rematime >= 7) {
      return 80;
    } else if (rematime < 7 && rematime >= 6) {
      return 70;
    } else if (rematime < 6 && rematime >= 5) {
      return 60;
    } else if (rematime < 5 && rematime >= 4) {
      return 50;
    } else if (rematime < 4 && rematime >= 3) {
      return 40;
    } else if (rematime < 3 && rematime >= 2) {
      return 30;
    } else if (rematime < 2 && rematime >= 1) {
      return 20;
    } else if (rematime < 1 && rematime >= 0) {
      return 10;
    }
    return 0;
  }

  int totalpointscored = 0;

  Widget options(int s) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: TextButton(
          onPressed: () {
            if (maafi.isLastQuestion()) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => end()),
              );
            } else {
              increaseq();
              incrementProgress();
              setState(() {
                int correctans = maafi.getcorrectans();
                if (correctans == s) {
                  totalpointscored += pointscored();
                  scorekeeper.add(Icon(Icons.check, color: Colors.green));
                } else {
                  scorekeeper.add(Icon(Icons.close, color: Colors.red));
                }
                maafi.nextQuestion();
                resetTimer();
              });
            }
            ;
          },
          child: Container(
            height: 50,
            width: 400,
            decoration: BoxDecoration(
                gradient: CustomScreen.myG,
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                maafi.getCurrentOption(s),
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
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  List<Icon> scorekeeper = []; //rem to add scorekeeper later in this quiz

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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Difficulty : ${maafi.getdifficulty()}', //this method is called string interpolation
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
                          'Q$a/9',
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
                        maafi.getCurrentQuestion(),
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
                  children: scorekeeper,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
