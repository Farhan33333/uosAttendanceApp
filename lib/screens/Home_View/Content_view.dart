import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import 'package:uosapp/main.dart';
import 'package:uosapp/screens/Home_View/Home_view.dart';
import 'package:uosapp/screens/Home_View/pdfscreen.dart';
import 'package:uosapp/screens/Home_View/pdfviewer.dart';

import '../../api_Handler/Models/contentmodel.dart';
import '../../api_Handler/Models/detailmodel.dart';

class Content_view extends StatefulWidget {
  final int subject_id;
  Content_view({super.key, required this.subject_id});

  @override
  State<Content_view> createState() => _Content_viewState(this.subject_id);
}

class _Content_viewState extends State<Content_view> {
  _Content_viewState(this.subject_id);

  getdescription(file) async {
    Navigator.push(context,
        PageRouteBuilder(pageBuilder: (c, a1, a2) => pdfViewer(file: file)));
  }

  final int subject_id;
  List<Content> display = [];
  @override
  void initState() {
    super.initState();

    getcontent(subject_id);
  }

  getcontent(s_id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var api_token = storage.getString('TOKEN');

    var cat = await Content_details.postApi(api_token, s_id);
    setState(() {
      display = cat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomeView()));
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: ListView.builder(
          itemCount: display.length,
          itemBuilder: (context, index) => Column(
            children: [
              Container(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 140),
                child: Text(
                  'Éducourse',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              Container(
                height: 200,
                width: 400,
                // padding: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    maximumSize: const Size(150, 50),
                    // minimumSize: Size.fromWidth(20),
                    shape: new RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        side: BorderSide(color: Color.fromARGB(255, 3, 3, 3))),
                    primary: Color.fromARGB(255, 6, 6, 6),
                  ),
                  child: Image.asset(
                    "assets/images/teacher.jpg",
                  ),
                  onPressed: () async {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 190),
                child: Text(
                  'CourseDetails:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  '${display[index].title}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff71A5D7),
                          gradient: LinearGradient(
                              colors: [Colors.white, Color(0xff71A5D7)]),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                                color: Colors.grey)
                          ]),
                      height: 100,
                      width: 130,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.punch_clock,
                            color: Colors.black,
                          ),
                          Text("Duration:6 Months",
                              style: TextStyle(color: Colors.black))
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        getdescription('${display[index].file}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffc657fb),
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Color.fromARGB(255, 109, 7, 140)
                            ]),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                  color: Colors.grey)
                            ]),
                        height: 100,
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.content_copy, color: Colors.black),
                            Text("View Pdf",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //  Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => youtube_player(youtube:youtube)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xff962D17),
                            gradient: LinearGradient(colors: [
                              Colors.white,
                              Color.fromARGB(255, 231, 158, 13)
                            ]),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                  color: Colors.grey)
                            ]),
                        height: 100,
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.video_file,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            Text("Youtube Content",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)))
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //    color: Color.fromARGB(255, 32, 30, 30),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Icon(Icons.list_alt, color: Colors.white,),
                    //       Text("Orders", style:TextStyle(color: Colors.white))
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 290),
                child: Text(
                  'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: Color.fromARGB(255, 230, 227, 227),
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 20),
                    child: Text(
                      "Programming refers to the process of designing, writing, testing, debugging, and maintaining the source code of computer software. It involves using a programming language to create instructions that a computer can understand and execute. These instructions allow the computer to perform tasks, store and manipulate data, and interact with users. Some popular programming languages include Python, Java, C++, JavaScript, and many more.",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 133, 133, 133)),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 10,
                    child: Row(
                      children: [
                        Text("Sub_name",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 179, 177, 177))),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
