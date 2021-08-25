import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pla0823/data/data.dart';
import 'package:pla0823/profile.dart';
import 'package:pla0823/profile_image.dart';

import 'bottom_info.dart';

import 'g_map.dart';
import 'menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '0823_pla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  List list = ExampleData.contentList;
  List see = [];

  Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 20,
        elevation: 0.5,
        centerTitle: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: Row(
              children: [
                Image.asset('assets/btn_search.png'),
                Image.asset('assets/btn_write.png'),
                Image.asset('assets/btn_cart.png'),
              ],
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 2, left: 13),
          child: Text(
            '베스트',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff2F2F9D)),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff2F2F9D),
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Menu(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Profile(
                      model: list[index],
                    ),
                    ProfileImage(model: list[index]),
                    GMap(
                      model: list[index],
                    ),
                    BottomInfo(model: list[index]),
                    myPageDottedLine(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider myPageDottedLine() {
    //실선
    return const Divider(
      height: 10,
      thickness: 5,
      indent: 0,
      color: Color(0XffEEEEF7),
      endIndent: 0,
    );
  }
}
