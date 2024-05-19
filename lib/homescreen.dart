import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'sports.dart';
import 'maths.dart';

class CustomScreen extends StatelessWidget {
  static LinearGradient myGradient = LinearGradient(
    //static is necessary if u want to use myGradient in main.dart or any other dart file
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(11, 10, 76, 1.0),
      Color.fromRGBO(75, 2, 157, 1.0),
    ],
  );
  static LinearGradient myG = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(0, 230, 255, 1.0),
      Color.fromRGBO(0, 83, 188, 1.0),
    ],
  );

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
            gradient: myGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Image.asset('assets/Logo.png'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'TRIVIA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'QUIZ',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => QuizPage()));
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      gradient: CustomScreen.myG,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'GENERAL QUIZ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => sports()));
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      gradient: CustomScreen.myG,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'SPORTS QUIZ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => maths()));
                },
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      gradient: CustomScreen.myG,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      'MATHS QUIZ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
