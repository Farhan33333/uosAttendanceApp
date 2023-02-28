// import 'package:flutter/material.dart';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:uosapp/screens/Home/login/login.dart';
// import 'package:uosapp/static/input_field.dart';
// import 'package:uosapp/static/input_field_pass.dart';
// import 'package:uosapp/static/large_button.dart';
// import 'package:uosapp/static/small_icon_button.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   bool _obscureText = true;
//   bool checkboxval = false;

//   void _toggle() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   _togglecheckbox() {
//     // print(checkboxval);
//     setState(() {
//       checkboxval = !checkboxval;
//     });
//     // authController.termsCheckBoxValue.value = checkboxval;
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // context.theme;
//     return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
//       bool largeScreen = constraints.maxWidth > 900;
//       var screenWidth = MediaQuery.of(context).size.width;
//       return Row(
//         children: [
//           if (largeScreen)
//             Expanded(
//               child: Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 // color: primaryColor,
//                 child: Center(
//                   child: Image.asset('assets/images/logo.jpg'),
//                 ),
//               ),
//             ),
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Container(
//                 width: largeScreen ? screenWidth * 0.6 : screenWidth,
//                 padding: const EdgeInsets.only(left: 18, right: 18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 45,
//                     ),
//                     !largeScreen
//                         ? SmallIconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             color: Colors.amber,
//                           )
//                         : const SizedBox(
//                             height: 5,
//                           ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text(
//                       'Sign Up',
//                       style:
//                           TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text(
//                       'Please sign up to your Students.ID Account',
//                       style: TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text(
//                       'Name',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                     ),
//                     InputField(
//                       hint: 'cKhan',
//                       // validate: authController.validateForm,
//                       // controller: authController.email,
//                       // validator: (email) => Validators.emailValidator(email),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),

//                     const Text(
//                       'RollNo',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                     ),
//                     InputField(
//                       hint: 'BSIT****',
//                       // validate: authController.validateForm,
//                       // controller: authController.email,
//                       // validator: (email) => Validators.emailValidator(email),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text(
//                       'Class',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                     ),
//                     InputField(
//                       hint: 'BSCS,BSIT,BSSE**',
//                       // validate: authController.validateForm,
//                       // controller: authController.email,
//                       // validator: (email) => Validators.emailValidator(email),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     const Text(
//                       'Email',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                     ),
//                     InputField(
//                       hint: 'caring@mail.com',
//                       // validate: authController.validateForm,
//                       // controller: authController.email,
//                       // validator: (email) => Validators.emailValidator(email),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     const Text(
//                       'Phone Number',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
//                     ),
//                     InputField(
//                       hint: '+92......',
//                       type: TextInputType.phone,
//                       // controller: authController.phone,
//                       // validate: authController.validateForm,
//                       // validator: (phone) => Validators.emptyStringValidator(phone, 'Phone'),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),

//                     const Text(
//                       'Your password must be 8 or more characters with numbers and atleast one special characters',
//                       softWrap: true,
//                       style: TextStyle(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       'Password',
//                       style:
//                           TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     InputFieldPassword(
//                       toggle: _toggle,
//                       obscure: _obscureText,
//                       hint: 'secret1234567',
//                       // controller: authController.password,
//                       // validate: authController.validateForm,
//                       // validator: (password) => Validators.passwordValidator(password),
//                     ),

//                     const SizedBox(
//                       height: 22,
//                     ),
//                     Center(
//                         child: LargeButton(
//                       title: 'Sign Up',
//                       sreenRatio: largeScreen ? 0.3 : 0.9,
//                       onPressed: () {
//                         setState(() {});
//                         // authController.signUp();
//                       },
//                       // color: secondaryColor,
//                       // textcolor: primaryColor,
//                       buttonWidth: 0.95,
//                     )),
//                     const SizedBox(
//                       height: 25,
//                     ),

//                     const SizedBox(
//                       height: 35,
//                     ),
//                     // Platform.isAndroid
//                     //     ? Center(
//                     //         child: GoogleButton(
//                     //         title: 'Google',
//                     //         icon: 'assets/images/google.png',
//                     //         onPressed: () {},
//                     //         textcolor: secondaryTextColor,
//                     //       ))
//                     //     : Center(
//                     //         child: GoogleButton(
//                     //         title: 'Apple',
//                     //         icon: 'assets/images/apple.png',
//                     //         onPressed: () {},
//                     //         textcolor: secondaryTextColor,
//                     //       )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Have Account?   ',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const LoginScreen()));
//                             },
//                             child: const Text(
//                               'Login Now',
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 16),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     largeScreen
//                         ? const SizedBox(
//                             height: 20,
//                           )
//                         : const SizedBox(
//                             height: 10,
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     }));
//   }
// }
