import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nexflix_clone/screen/home_sceen.dart';
import 'package:nexflix_clone/screen/like_screen.dart';
import 'package:nexflix_clone/screen/more_sceeen.dart';
import 'package:nexflix_clone/screen/search_screen.dart';
import 'package:nexflix_clone/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    // Initialize FlutterFire
    Firebase.initializeApp();
    return MaterialApp(
        title: 'Netflix Clone',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.white),
      home: DefaultTabController(
        length: 4, // 4개의 탭
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), // 사용자가 직접 스크롤 모션을 통해서 스크롤하는 기능을 막는다.
            children: [
              HomeScreen(),
              SearchScreen(),
              LikeScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
