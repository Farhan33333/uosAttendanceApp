import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:get/get.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import 'package:uosapp/api_Handler/Models/loginmodel.dart';
import 'package:uosapp/screens/Home/login/login.dart';
import 'package:uosapp/screens/Home_View/Content_view.dart';
import 'package:uosapp/screens/Home_View/attendance_details.dart';

import 'package:uosapp/api_Handler/Api_LoginService.dart';
import 'package:uosapp/screens/Home_View/attendance_report.dart';
import '../../api_Handler/Api_LoginService.dart';
import '../../api_Handler/Models/contentmodel.dart';
import '../../api_Handler/Models/detailmodel.dart';
import '../../static/input_field.dart';
import '../../static/large_button.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key, Object? user});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: PersistentTabView(
        context,
        // controller: _controller,
        screens: _buildScreens(),
        items: _navBarItem(),

        navBarStyle: NavBarStyle.style16,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1.0),
          colorBehindNavBar: Colors.white,
        ),
      )),
    );
  }
}

List<PersistentBottomNavBarItem> _navBarItem() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home),
      title: ('Home'),
      activeColorSecondary: Colors.amber,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.chat),
      title: ('Subjects'),
      activeColorSecondary: Colors.amber,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.diamond),
      activeColorPrimary: Colors.amber,
      activeColorSecondary: Colors.white,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.list_alt),
      title: ('Notifications'),
      activeColorSecondary: Colors.amber,
      inactiveColorPrimary: Colors.black,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.settings),
      title: ('About'),
      activeColorSecondary: Colors.amber,
      inactiveColorPrimary: Colors.black,
    ),
  ];
}

@override
List<Widget> _buildScreens() {
  return [
    HomeView(),
    Subjects(),
    HomeView(),
    Attendance(),
    About(),
  ];
}

class HomeView extends StatefulWidget {
  const HomeView({super.key, Object? user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Album> display = [];

  @override
  void initState() {
    super.initState();

    getcourses();
  }

  getdescription(subject_id) async {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Content_view(
                  subject_id: subject_id,
                )));
  }

  getcourses() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var api_token = storage.getString('TOKEN');

    var cat = await CategoryApi.get_cat(api_token);

    setState(() {
      display = cat;
    });
  }

  final List<Category> categories = [
    Category(image: "assets/images/teacher.jpg", name: "Flutter"),
    Category(image: "assets/images/teacher.jpg", name: "EAD"),
    Category(image: "assets/images/teacher.jpg", name: "DBA"),
    Category(image: "assets/images/teacher.jpg", name: "SNA"),
    Category(image: "assets/images/teacher.jpg", name: "IOT"),
  ];

  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: SidebarX(
          controller: SidebarXController(selectedIndex: 0, extended: true),
          items: [
            SidebarXItem(icon: Icons.home, label: 'Home'),
            SidebarXItem(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Attendance()),
                );
              },
              icon: Icons.roller_shades_closed_rounded,
              label: 'Announcements',
            ),
          ],
          theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            hoverColor: Colors.grey,
            width: 250,
            textStyle: TextStyle(
                color: Color.fromARGB(255, 10, 10, 10).withOpacity(0.7)),
            selectedTextStyle:
                const TextStyle(color: Color.fromARGB(255, 3, 3, 3)),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          actions: [
            GestureDetector(
              onTap: () async {
                final logoutValue = await LoginService().logout();
                if (logoutValue == true) {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginScreen();
                      },
                    ),
                    (_) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text(
                        'error with your token, have to login again',
                      ),
                    ),
                  );

                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const LoginScreen();
                      },
                    ),
                    (_) => false,
                  );
                }
              },
              child: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(6),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 60,
                      child: Text("Welcome"),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "University of",
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 14),
                          ),
                          Text(
                            "Sargodha",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F2F3E)),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      "assets/images/logo.jpg",
                      width: 27,
                      height: 30,
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: [
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/uos.jpg",
                          height: 300,
                          width: 700,
                        ), //This
                        // should be a paged
                        // view
                      ],
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/uos.jpg",
                          height: 300,
                          width: 700,
                        ), //This
                        // should be a paged
                        // view
                      ],
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/uos.jpg",
                          height: 300,
                          width: 700,
                        ), //This
                        // should be a paged
                        // view
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              Container(
                  child: Text(
                    "A major public sector university of Pakistan offering modern teaching"
                    "and research facilities, including well-equipped classrooms, laboratories"
                    "and a vast collection of library material, with online access to books and journals.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(height: 1.5, color: Color(0xFF6F8398)),
                  ),
                  padding: EdgeInsets.all(5)),
              ScaledList(
                selectedCardHeightRatio: 0.3,
                unSelectedCardHeightRatio: 0.2,
                itemCount: display.length,
                itemColor: (index) {
                  return kMixedColors[index % kMixedColors.length];
                },
                itemBuilder: (index, selectedIndex) {
                  final category = categories[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          getdescription(display[index].id);
                        },
                        child: Container(
                          height: selectedIndex == index ? 100 : 80,
                          child: Image.asset(category.image),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${display[index].name}',
                        // "name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: selectedIndex == index ? 20 : 12),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category {
  Category({required this.image, required this.name});

  final String image;
  final String name;
}

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Album> display = [];

  @override
  void initState() {
    super.initState();

    getcourses();
  }

  getdescription(subject_id) async {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (c, a1, a2) => Content_view(
                  subject_id: subject_id,
                )));
  }

  getcourses() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var api_token = storage.getString('TOKEN');

    var cat = await CategoryApi.get_cat(api_token);

    setState(() {
      display = cat;
    });
  }

  final List<Category> categories = [
    Category(image: "assets/images/teacher.jpg", name: "Flutter"),
    Category(image: "assets/images/teacher.jpg", name: "EAD"),
    Category(image: "assets/images/teacher.jpg", name: "DBA"),
    Category(image: "assets/images/teacher.jpg", name: "SNA"),
    Category(image: "assets/images/teacher.jpg", name: "IOT"),
  ];

  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
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
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Subjects',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (display.length <= 0)
                        Text(
                          "There are no subjects entered for this course.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                      else
                        ScaledList(
                          selectedCardHeightRatio: 0.3,
                          unSelectedCardHeightRatio: 0.2,
                          itemCount: display.length,
                          itemColor: (index) {
                            return kMixedColors[index % kMixedColors.length];
                          },
                          itemBuilder: (index, selectedIndex) {
                            final category = categories[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    getdescription(display[index].id);
                                  },
                                  child: Container(
                                    height: selectedIndex == index ? 100 : 80,
                                    child: Image.asset(category.image),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '${display[index].name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: selectedIndex == index ? 20 : 12,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 213,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(25),
                ),
                margin: EdgeInsets.only(top: 0),
              ),
              Column(children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text('Welcome'),
                      SizedBox(
                        width: 270,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                      child: Text(
                        'University Of Sargodha',
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: 280,
                  height: 59,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.0824137),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 65,
                        ),
                        Image.asset("assets/images/logo.jpg"),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "CS & IT",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              'About UOS(CS & IT)',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: const Text(
              " To provide students with a healthy learning experience based on critical thinking, innovation and leadership skills To ensure a collaborative work environment for faculty and staff to achieve professional excellence and institutional growth To contribute to knowledge economy and social transformation through advanced studies and research",
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
