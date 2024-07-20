import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
      bool isCameraGranted =
          (await _storage.read(key: Strings.isCameraGranted)) == 'true';
      bool isMicGranted =
          (await _storage.read(key: Strings.isMicGranted)) == 'true';

      if (!mounted) return;

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

  // 아이콘에 위쪽 및 아래쪽 패딩을 추가하는 위젯
  Widget _bottomIcon({
    required String assetName,
    double topPadding = 0.0,
    double bottomPadding = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: SvgPicture.asset(assetName),
    );
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
                icon: _bottomIcon(
                  assetName: Images.homeDisable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                activeIcon: _bottomIcon(
                  assetName: Images.homeEnable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                label: Strings.home,
              ),
              BottomNavigationBarItem(
                icon: _bottomIcon(
                  assetName: Images.uploadDisable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                activeIcon: _bottomIcon(
                  assetName: Images.uploadEnable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                label: Strings.upload,
              ),
              BottomNavigationBarItem(
                icon: _bottomIcon(
                  assetName: Images.diaryDisable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                activeIcon: _bottomIcon(
                  assetName: Images.diaryEnable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                label: Strings.diary,
              ),
              BottomNavigationBarItem(
                icon: _bottomIcon(
                  assetName: Images.myPageDisable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                activeIcon: _bottomIcon(
                  assetName: Images.myPageEnable,
                  topPadding: 10.0,
                  bottomPadding: 6.0,
                ),
                label: Strings.myPage,
              ),
            ],
            showUnselectedLabels: true,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: TextStyle(
              color: Colors.blue,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(12.0),
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.white,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtil().setSp(12.0),
            ),
          ),
        ),
      ),
    );
  }
}
