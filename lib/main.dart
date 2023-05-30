import 'package:flutter/material.dart';
import 'package:uosapp/screens/Intro_Screens/login/login.dart';
import 'package:uosapp/screens/Home_Screens/Home_view.dart';
import 'package:uosapp/screens/splash/splash_screen.dart';

import 'api_Handler/Api_LoginService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: LoginService().getUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 201, 32, 32)),
                  strokeWidth: 3.0,
                ),
              );
            case ConnectionState.none:
              return Splash_Screen();
            default:
              if (snapshot.data != null) {
                return Home_screen(user: snapshot.data);
              } else {
                return Splash_Screen();
              }
          }
        },
      ),
      routes: {
        '/login': (_) => LoginScreen(),
      },
    );
  }
}
