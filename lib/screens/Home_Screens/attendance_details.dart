import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uosapp/api_Handler/Api_Attendance.dart';
import 'package:uosapp/api_Handler/Models/attendnacemodel.dart';
import 'package:uosapp/screens/Home_Screens/Home_view.dart';
import 'package:uosapp/screens/Home_Screens/attendance_report.dart';

import '../../api_Handler/Api_Content.dart';
import '../../api_Handler/Models/contentmodel.dart';

class attendance_Screen extends StatefulWidget {
  const attendance_Screen({super.key});

  @override
  State<attendance_Screen> createState() => _attendance_ScreenState();
}

class _attendance_ScreenState extends State<attendance_Screen> {
  List<Attendancemodel> display = [];

  @override
  void initState() {
    super.initState();

    getattendance();
  }

  getattendance() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var api_token = storage.getString('TOKEN');

    var attend = await AttendanceApi.get_attend(api_token);

    setState(() {
      display = attend;
    });
  }

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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                'Attendance!',
                style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.blue[700]!,
                ),
              ),
              // Solid text as fill.
              Text(
                'Attendance!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[300],
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: display.length,
              itemBuilder: (context, index) => Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subject Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              display[index].subject_name,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 70),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date-Time:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(display[index].datetime),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
