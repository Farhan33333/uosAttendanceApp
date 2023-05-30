import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import 'package:uosapp/main.dart';
import 'package:uosapp/screens/Home_View/Home_view.dart';
import 'package:uosapp/screens/Home_View/pdfscreen.dart';
import 'package:uosapp/screens/Home_View/pdfviewer.dart';
import 'package:uosapp/screens/Home_View/youtube_link.dart';

import '../../api_Handler/Models/contentmodel.dart';
import '../../api_Handler/Models/detailmodel.dart';

class Content_view extends StatefulWidget {
  final int subject_id;

  Content_view({Key? key, required this.subject_id}) : super(key: key);

  @override
  State<Content_view> createState() => _Content_viewState(subject_id);
}

class _Content_viewState extends State<Content_view> {
  final int subject_id;
  List<Content> display = [];

  _Content_viewState(this.subject_id);

  getdescription(file) async {
    Navigator.push(
      context,
      PageRouteBuilder(pageBuilder: (c, a1, a2) => pdfViewer(file: file)),
    );
  }

  getlinkvideo(youtube) async {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (c, a1, a2) => youtube_player(youtube: youtube)),
    );
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return ListView.builder(
            itemCount: display.length,
            itemBuilder: (context, index) => Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.03),
                Padding(
                  padding: EdgeInsets.only(right: constraints.maxWidth * 0.35),
                  child: Text(
                    'Éducourse',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.25,
                  width: constraints.maxWidth * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(constraints.maxWidth * 0.3,
                          constraints.maxHeight * 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        side: BorderSide(color: Color.fromARGB(255, 3, 3, 3)),
                      ),
                      primary: Color.fromARGB(255, 6, 6, 6),
                    ),
                    child: Image.asset(
                      "assets/images/teacher.jpg",
                    ),
                    onPressed: () async {},
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.04),
                Padding(
                  padding: EdgeInsets.only(right: constraints.maxWidth * 0.47),
                  child: Text(
                    'CourseDetails:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: constraints.maxWidth * 0.02),
                  child: Text(
                    '${display[index].title}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xff71A5D7),
                          gradient: LinearGradient(
                            colors: [Colors.white, Color(0xff71A5D7)],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        height: constraints.maxHeight * 0.15,
                        width: constraints.maxWidth * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.punch_clock,
                              color: Colors.black,
                            ),
                            Text(
                              "Duration: 6 Months",
                              style: TextStyle(color: Colors.black),
                            ),
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
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 109, 7, 140),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          height: constraints.maxHeight * 0.15,
                          width: constraints.maxWidth * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.content_copy, color: Colors.black),
                              Text(
                                "View Pdf",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  getlinkvideo('${display[index].link}'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff962D17),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Color.fromARGB(255, 231, 158, 13),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0),
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          height: constraints.maxHeight * 0.15,
                          width: constraints.maxWidth * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.video_file,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                "Youtube Content",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: constraints.maxWidth * 0.58),
                  child: Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                SizedBox(height: constraints.maxHeight * 0.04),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Color.fromARGB(255, 230, 227, 227),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.03,
                          right: constraints.maxWidth * 0.03,
                          top: constraints.maxHeight * 0.01,
                          bottom: constraints.maxHeight * 0.03,
                        ),
                        child: Text(
                          "'${display[index].description}'",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 133, 133, 133),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: constraints.maxHeight * 0.01,
                        right: constraints.maxWidth * 0.03,
                        child: Row(
                          children: [
                            Text(
                              "'${display[index].title}'",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 179, 177, 177),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
