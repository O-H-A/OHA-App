import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oha/network/api_url.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../../network/network_manager.dart';
import '../../vidw_model/login_view_model.dart';
import '../widgets/notification_app_bar.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _getProfileImage;
  XFile? _getBackgroundImage;
  LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();

    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
  }

  void onLogout() async {
    print("Jehee");

    await _loginViewModel.logout().then((value) {
      if (value == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      }
    }).onError((error, stackTrace) {
      // Handle error navigation here
    });
  }

  Future getProfileImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: imageSource, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        _getProfileImage = XFile(pickedFile.path);

        NetworkManager.instance
            .imagePut(ApiUrl.profileImageUpdate, _getProfileImage);
      });
    }
  }

  Future getBackgroundImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: imageSource, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        _getBackgroundImage = XFile(pickedFile.path);

        NetworkManager.instance
            .imagePut(ApiUrl.backgroundImageUpdate, _getBackgroundImage);
      });
    }
  }

  Widget _buildProfileImage() {
    return _getProfileImage == null
        ? SvgPicture.asset(Images.myPageDefaultProfile)
        : Container(
            width: ScreenUtil().setWidth(100.0),
            height: ScreenUtil().setHeight(100.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.file(File(_getProfileImage!.path)),
            ),
          );
  }

  Widget _buildBackgroundImage() {
    return _getBackgroundImage == null
        ? Image.asset(Images.myImageDefault,
            fit: BoxFit.cover,
            width: double.infinity,
            height: ScreenUtil().setHeight(380.0))
        : SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(380.0),
            child: Image.file(File(_getBackgroundImage!.path)),
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
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(295.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _buildBackgroundImage(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            getProfileImage(ImageSource.gallery);
                          },
                          child: _buildProfileImage()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "User A",
                            style: TextStyle(
                              fontFamily: "Pretendard",
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SvgPicture.asset(Images.edit),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(19.0)),
                      GestureDetector(
                        onTap: () {
                          getBackgroundImage(ImageSource.gallery);
                        },
                        child: const Text(
                          Strings.editBackgroundImage,
                          style: TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(26.0),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  // SizedBox(height: ScreenUtil().setHeight(28.0)),
                  // _buildContentsWidget(Strings.termsAndPolicies),
                  // SizedBox(height: ScreenUtil().setHeight(26.0)),
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
