import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uosapp/screens/Intro_Screens/intro.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Intro_screen(),
        ));
  }
}

initScreen(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset("assets/images/uos.jpg"),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Text(
            "Welcome",
            style: TextStyle(
                fontSize: 20.0, color: Color.fromARGB(255, 185, 44, 44)),
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 102, 7, 7),
            strokeWidth: 1,
          )
        ],
      ),
    ),
  );
}
