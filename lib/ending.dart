import 'package:flutter/material.dart';
import 'package:trivia/main.dart';
import 'results.dart';
import 'sports.dart';
import 'homescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class end extends StatefulWidget {
  const end({super.key});

  @override
  State<end> createState() => _endState();
}

class _endState extends State<end> {
  void initState() {
    super.initState();
    // triggers the animation when the widget is first sshown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCongratsAnimation();
    });
  }

  void showCongratsAnimation() {
    Fluttertoast.showToast(
      msg: "Congratulations!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'CONGRATULATIONS!!! YOU HAVE SUCCESSFULLY COMPLETED THE QUIZ',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => CustomScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      gradient: CustomScreen.myG,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'RETURN TO HOMESCREEN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => result()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      gradient: CustomScreen.myG,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'SEE RESULT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
