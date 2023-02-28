import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:uosapp/screens/Home_View/Home_view.dart';
import 'package:uosapp/static/input_field.dart';
import 'package:uosapp/static/input_field_pass.dart';
import 'package:uosapp/static/large_button.dart';
import 'package:uosapp/static/small_icon_button.dart';
import 'package:uosapp/api_Handler/Api_LoginInterface.dart';
import 'package:uosapp/api_Handler/Api_LoginService.dart';
import 'package:uosapp/api_Handler/Models/loginmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  final ILogin _loginService = LoginService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Start a timer to dismiss the dialog after 1 minute
        Timer timer = Timer(Duration(seconds: 5), () {
          Navigator.of(context, rootNavigator: true).pop();
          Fluttertoast.showToast(
              toastLength: Toast.LENGTH_LONG,
              msg: 'Credentials not correct',
              backgroundColor: Colors.red,
              textColor: Colors.white);
        });

        return WillPopScope(
          // Cancel the timer if the dialog is dismissed
          onWillPop: () async {
            timer.cancel();
            return true;
          },
          child: alert,
        );
      },
    );
  }

  void _toggle() {
    setState(() {
      // _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      bool largeScreen = constraints.maxWidth > 900;
      var screenWidth = MediaQuery.of(context).size.width;
      return Row(
        children: [
          if (largeScreen)
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Image.asset('assets/images/logo.jpg'),
                ),
              ),
            ),
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                width: largeScreen ? screenWidth * 0.6 : screenWidth,
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    !largeScreen
                        ? SmallIconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        : const SizedBox(
                            height: 5,
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Welcome Back',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Please sign in to your Students.ID Account',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 400,
                      padding: EdgeInsets.only(left: 40),
                      child: Form(
                        key: formkey,
                        child: TextFormField(
                          validator: (value) {
                            RegExp regex = RegExp(
                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            } else {
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid email';
                              } else {
                                return null;
                              }
                            }
                          },
                          controller: _emailController,
                          style:
                              TextStyle(color: Color.fromARGB(255, 11, 11, 11)),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              hintText: 'john.smith@mail.com',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 16, 16, 16))),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      padding: EdgeInsets.only(left: 40),
                      child: Form(
                        key: formkey1,
                        child: TextFormField(
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            // else {
                            //   if (!regex.hasMatch(value)) {
                            //     return 'Enter valid password';
                            //   }
                            //   else {
                            //     return null;
                            //   }
                            // }
                          },
                          controller: _passwordController,
                          style:
                              TextStyle(color: Color.fromARGB(255, 11, 11, 11)),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow),
                              ),
                              hintText: 'secret1234567',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 16, 16, 16))),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () async {
                        if (formkey.currentState!.validate() &&
                            formkey1.currentState!.validate()) {
                          showLoaderDialog(context);
                          if (_emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            UserModel user = await _loginService.login(
                                _emailController.text,
                                _passwordController.text);
                            Navigator.of(context, rootNavigator: true).pop();
                            if (user != null) {
                              log('message');

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => HomeView(user: user),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: LargeButton(
                        title: 'Sign In',
                        sreenRatio: largeScreen ? 0.3 : 0.9,
                        color: Colors.amber,
                        textcolor: Colors.black,
                        buttonWidth: 0.95,
                      ),
                    )),
                    const SizedBox(
                      height: 35,
                    ),
                    // if (kIsWeb || Platform.isAndroid)
                    //   Center(
                    //       child: GoogleButton(
                    //     title: 'Google',
                    //     icon: 'assets/images/google.png',
                    //     onPressed: () {
                    //       authController.signInwithGoogle();
                    //       log("Google Clicked");
                    //     },
                    //     textcolor: secondaryTextColor,
                    //     buttonwidth: largeScreen ? 0.2 : 0.37,
                    //   ))
                    // else
                    //   Center(
                    //       child: GoogleButton(
                    //     title: 'Apple',
                    //     icon: 'assets/images/apple.png',
                    //     onPressed: () {},
                    //     textcolor: secondaryTextColor,
                    //     buttonwidth: largeScreen ? 0.2 : 0.37,
                    //   )),
                    const SizedBox(
                      height: 35,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const RegisterScreen()),
                    //     );
                    //   },
                    //   child: Center(
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text('Don’t have  Account? '),
                    //         Text(
                    //           'Create One',
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }));
  }
}
