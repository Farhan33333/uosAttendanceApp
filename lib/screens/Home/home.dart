import 'package:flutter/material.dart';
import 'package:uosapp/screens/Home/login/login.dart';
import 'package:uosapp/screens/Home/login/signup.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    'Welcome to\n  Students.ID',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
              ),
              Container(
                height: 250.0,
                width: 400.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/uos1.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  width: 200,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              // GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const RegisterScreen()));
              //     },
              //     child: Text(
              //       'Signup',
              //       textAlign: TextAlign.center,
              //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
