import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/vidw_model/my_page_view_model.dart';
import 'package:oha/view/pages/login_page.dart';
import 'package:oha/view/pages/mypage/profile_edit_page.dart';
import 'package:oha/view/pages/mypage/terms_and_Policies.dart';
import 'package:provider/provider.dart';

import '../../../vidw_model/login_view_model.dart';
import '../../widgets/notification_app_bar.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  LoginViewModel _loginViewModel = LoginViewModel();
  MyPageViewModel _myPageViewModel = MyPageViewModel();

  @override
  void initState() {
    super.initState();

    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _myPageViewModel = Provider.of<MyPageViewModel>(context, listen: false);
  }

  void onLogout() async {
    await _loginViewModel.logout().then((value) {
      if (value == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      }
    }).onError((error, stackTrace) {});
  }

  void showAgreementPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermsAndPolicies()),
    );
  }

  Widget _buildProfileWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileEditPage()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(Images.defaultProfile),
          SizedBox(width: ScreenUtil().setWidth(12.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User A",
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(UserColors.ui01),
                ),
              ),
              GestureDetector(
                onTap: () {
                  return;
                },
                child: const Text(
                  Strings.loginedWithKakao,
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(UserColors.ui06),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentsWidget(String title, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.black),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationAppBar(
        title: Strings.myPage,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(17.0)),
                  _buildProfileWidget(),
                  SizedBox(height: ScreenUtil().setHeight(40.0)),
                  const Text(
                    Strings.updateHistory,
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    Strings.noUpdateHistory,
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(UserColors.ui06),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(28.0)),
                  _buildContentsWidget(
                      Strings.termsAndPolicies, showAgreementPage),
                  SizedBox(height: ScreenUtil().setHeight(26.0)),
                  // _buildContentsWidget(Strings.sendCommentsInquiries),
                  // SizedBox(height: ScreenUtil().setHeight(26.0)),
                  // _buildContentsWidget(Strings.accountCancel),
                  // SizedBox(height: ScreenUtil().setHeight(26.0)),
                  _buildContentsWidget(Strings.logout, onLogout),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
