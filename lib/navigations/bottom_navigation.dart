import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../statics/images.dart';
import '../statics/strings.dart';
import '../view/pages/diary/diary_page.dart';
import '../view/pages/home_page.dart';
import '../view/pages/mypage/my_page.dart';
import '../view/pages/upload/upload_page.dart';
import '../view/pages/upload/upload_agreements_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectIndex = 0;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const UploadPage(),
    const DiaryPage(),
    const MyPage()
  ];

  void _onBottomTapped(int index) async {
    if (index == 1) {
      bool isCameraGranted = (await _storage.read(key: Strings.isCameraGranted)) == 'true';
      bool isMicGranted = (await _storage.read(key: Strings.isMicGranted)) == 'true';

      if(!mounted) return;

      if (!isCameraGranted || !isMicGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UploadAgreementsPage()),
        );
        return;
      }
    }

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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, -3),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: ClipRRect(
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
              color: Colors.blue,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.white,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
