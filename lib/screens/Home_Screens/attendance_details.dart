import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Album> display = [];

  @override
  void initState() {
    super.initState();

    getcourses();
  }

  getcourses() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var api_token = storage.getString('TOKEN');

    var cat = await CategoryApi.get_cat(api_token);

    setState(() {
      display = cat;
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
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 8),
            child: Text('Attendance Details',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 30,
          ),
          const Text(
            'Subjects',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter Subject You Want',
                contentPadding: const EdgeInsets.all(15),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onChanged: (value) {
                // do something
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: display.length,
                itemBuilder: (context, index) => Container(
                      height: 80,
                      width: 350,
                      padding: EdgeInsets.all(5),
                      child: Card(
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: ListTile(
                          onTap: () {},
                          trailing: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        attendant_report_screen()),
                              );
                            },
                            child: Container(
                              width: 80,
                              height: 40.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    // gradient starts from left
                                    begin: Alignment.centerLeft,
                                    // gradient ends at right
                                    end: Alignment.centerRight,
                                    // set all your colors
                                    colors: [
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                      Colors.amber,
                                    ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: Center(
                                  child: Text(
                                'View Attend',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 14, 14, 14),
                                    fontSize: 9.0),
                              )),
                            ),
                          ),
                          title: Text(
                            '${display[index].name}',
                            style: TextStyle(
                                color: Color.fromARGB(255, 8, 8, 8),
                                fontSize: 15),
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/teacher.jpg'),
                            ),
                          ),
                        ),
                        elevation: 7,
                        shadowColor: Color.fromARGB(255, 63, 63, 63),
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
