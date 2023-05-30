import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import 'package:uosapp/screens/Home_Screens/about_screen.dart';
import 'package:uosapp/screens/Home_Screens/notifications_screen.dart';
import 'package:uosapp/screens/Home_Screens/subjects_screen.dart';
import 'package:uosapp/screens/Intro_Screens/login/login.dart';
import 'package:uosapp/screens/Home_Screens/Content_view.dart';
import 'package:uosapp/api_Handler/Api_LoginService.dart';
import '../../api_Handler/Models/contentmodel.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key, Object? user}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller?.dispose(); // Dispose the PersistentTabController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarItem(),
          navBarStyle: NavBarStyle.style16,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(1.0),
            colorBehindNavBar: Colors.white,
          ),
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorSecondary: Colors.amber,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.chat),
        title: 'Subjects',
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
        title: 'Notifications',
        activeColorSecondary: Colors.amber,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: 'About',
        activeColorSecondary: Colors.amber,
        inactiveColorPrimary: Colors.black,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      HomeView(),
      Subjects(),
      HomeView(),
      Notifications_screen(),
      About(),
    ];
  }
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
                  MaterialPageRoute(
                      builder: (context) => Notifications_screen()),
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
