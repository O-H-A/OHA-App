import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:oha/pages/diary_page.dart';
import 'package:oha/pages/home_page.dart';
import 'package:oha/pages/my_page.dart';
import 'package:oha/pages/upload_page.dart';

import '../statics/images.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const UploadPage(),
    const DiaryPage(),
    const MyPage()
  ];

  void _onBottomTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectIndex,
        children: _pages,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectIndex,
          onTap: _onBottomTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(Images.homeDisable),
              activeIcon: Image.asset(Images.homeEnable),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(Images.uploadDisable),
              activeIcon: Image.asset(Images.uploadEnable),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(Images.diaryDisable),
              activeIcon: Image.asset(Images.diaryEnable),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(Images.myPageDisable),
              activeIcon: Image.asset(Images.myPageEnable),
              label: "",
            ),
          ],
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
