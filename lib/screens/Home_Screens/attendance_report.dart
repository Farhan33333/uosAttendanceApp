import 'package:flutter/material.dart';
import 'package:uosapp/screens/Home_Screens/Home_view.dart';

class attendant_report_screen extends StatefulWidget {
  const attendant_report_screen({super.key});

  @override
  State<attendant_report_screen> createState() =>
      _attendant_report_screenState();
}

class _attendant_report_screenState extends State<attendant_report_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 8),
          child: Text('Attendance Report',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisCount: 3,
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.punch_clock,
                      color: Colors.black,
                    ),
                    Text("Absents : 06", style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // // Navigator.push(
                  // //   context,
                  // //   MaterialPageRoute(builder: (context) => PdfViewer()),
                  // );
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.content_copy, color: Colors.black),
                      Text("Presents : 16",
                          style: TextStyle(color: Colors.black))
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.video_file,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Text("Leave : 02",
                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))
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
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
        ),
      ]),
    );
  }
}
