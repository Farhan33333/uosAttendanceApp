import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scaled_list/scaled_list.dart';
import 'package:uosapp/api_Handler/Api_Content.dart';
import 'package:uosapp/screens/Home_Screens/Content_view.dart';
import '../../api_Handler/Models/contentmodel.dart';

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
