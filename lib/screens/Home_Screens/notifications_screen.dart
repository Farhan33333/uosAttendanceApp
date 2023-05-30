import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import '../../api_Handler/Models/contentmodel.dart';

class Notifications_screen extends StatefulWidget {
  const Notifications_screen({super.key});

  @override
  State<Notifications_screen> createState() => _Notifications_screenState();
}

class _Notifications_screenState extends State<Notifications_screen> {
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

  final List<String> announcements = [
    'Announcement of the day 1',
    'Announcement of the day 2',
    'Announcement of the day 3',
    'Announcement of the day 4',
    'Announcement of the day 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            "assets/images/uos.jpg", // replace with your image URL
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20.5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo.jpg", // replace with your logo asset path
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 250, 250),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30))),
                      child: Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(top: 5),
                        //   child: Text(
                        //     'Announcements ',
                        //     style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.amber),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          children: <Widget>[
                            // Stroked text as border.
                            Text(
                              'Announcements!',
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
                              'Announcements!',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: announcements.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: ListTile(
                                  title: Text(
                                    announcements[index],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        // Expanded(
                        //   child: ListView.builder(
                        //       itemCount: display.length,
                        //       itemBuilder: (context, index) => Container(
                        //             height: 80,
                        //             width: 350,
                        //             padding: EdgeInsets.all(5),
                        //             child: Card(
                        //               color: Color.fromARGB(255, 255, 255, 255),
                        //               child: ListTile(
                        //                 onTap: () {},
                        //                 trailing: GestureDetector(
                        //                   onTap: () {
                        //                     Navigator.push(
                        //                       context,
                        //                       MaterialPageRoute(
                        //                           builder: (context) =>
                        //                               attendant_report_screen()),
                        //                     );
                        //                   },
                        //                   child: Container(
                        //                     width: 80,
                        //                     height: 40.0,
                        //                     decoration: BoxDecoration(
                        //                       gradient: LinearGradient(
                        //                           // gradient starts from left
                        //                           begin: Alignment.centerLeft,
                        //                           // gradient ends at right
                        //                           end: Alignment.centerRight,
                        //                           // set all your colors
                        //                           colors: [
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                             Colors.amber,
                        //                           ]),
                        //                       borderRadius: BorderRadius.all(
                        //                           Radius.circular(10.0)),
                        //                     ),
                        //                     child: Center(
                        //                         child: Text(
                        //                       'View Attend',
                        //                       style: TextStyle(
                        //                           fontWeight: FontWeight.bold,
                        //                           color: Color.fromARGB(
                        //                               255, 14, 14, 14),
                        //                           fontSize: 9.0),
                        //                     )),
                        //                   ),
                        //                 ),
                        //                 title: Text(
                        //                   '${display[index].name}',
                        //                   style: TextStyle(
                        //                       color:
                        //                           Color.fromARGB(255, 8, 8, 8),
                        //                       fontSize: 15),
                        //                 ),
                        //                 leading: Container(
                        //                   padding: EdgeInsets.only(top: 10),
                        //                   child: CircleAvatar(
                        //                     radius: 30,
                        //                     backgroundImage: AssetImage(
                        //                         'assets/images/teacher.jpg'),
                        //                   ),
                        //                 ),
                        //               ),
                        //               elevation: 7,
                        //               shadowColor:
                        //                   Color.fromARGB(255, 63, 63, 63),
                        //               margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                        //               shape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(8)),
                        //             ),
                        //           )),
                        // ),
                      ])))
            ],
          ),
        ],
      ),
    );
  }
}
