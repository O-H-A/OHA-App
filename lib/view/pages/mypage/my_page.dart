import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

import '../../../statics/colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';
import '../../../view_model/my_page_view_model.dart';
import '../../../view/pages/login_page.dart';
import '../../../view/pages/mypage/profile_edit_page.dart';
import '../../../view/pages/mypage/terms_and_Policies.dart';
import '../../../view/widgets/complete_dialog.dart';
import '../../../view/widgets/notification_app_bar.dart';
import '../../widgets/delete_dialog.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  LoginViewModel _loginViewModel = LoginViewModel();
  MyPageViewModel _myPageViewModel = MyPageViewModel();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _myPageViewModel = Provider.of<MyPageViewModel>(context, listen: false);

    _myPageViewModel.myInfo();
  }

  void _onLogout() async {
    await _loginViewModel.logout().then((value) {
      if (value == 200) {
        _storage.deleteAll();

        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );

        CompleteDialog.showCompleteDialog(context, Strings.logoutComplete);
      }
    }).onError((error, stackTrace) {});
  }

  void _onWithDraw() async {
    try {
      await _loginViewModel.withDraw().then((value) => {
            Navigator.pop(context),
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (Route<dynamic> route) => false,
            ),
          });

      if (!mounted) return;

      CompleteDialog.showCompleteDialog(context, Strings.withDrawComplete);
    } catch (e) {}
  }

  void _showYesNoDialog(
      String title, String guide, VoidCallback yesCallback, double height) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return YesNoDialog(
          height: height,
          titleText: title,
          guideText: guide,
          yesCallback: () {
            Navigator.pop(context);
            yesCallback();
          },
          noCallback: () => Navigator.pop(context),
        );
      },
    );
  }

  void _showAgreementPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TermsAndPolicies()),
    );
  }

  Widget _buildProfileWidget() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileEditPage()),
        );
        if (result == true) {
          setState(() {});
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          (_myPageViewModel.myInfoData.data?.data.profileUrl?.isEmpty ?? true)
              ? SvgPicture.asset(Images.defaultProfile)
              : ClipOval(
                  child: Image.network(
                    _myPageViewModel.myInfoData.data?.data.profileUrl ?? "",
                    width: ScreenUtil().setWidth(70.0),
                    height: ScreenUtil().setWidth(70.0),
                    fit: BoxFit.cover,
                  ),
                ),
          SizedBox(width: ScreenUtil().setWidth(12.0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _myPageViewModel.myInfoData.data?.data.name ?? '',
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: ScreenUtil().setSp(24.0),
                  fontWeight: FontWeight.w700,
                  color: const Color(UserColors.ui01),
                ),
              ),
              GestureDetector(
                onTap: () {
                  return;
                },
                child: Text(
                  Strings.loginProviderMap["NAVER"] ?? Strings.loginedWithKakao,
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: ScreenUtil().setSp(14.0),
                    fontWeight: FontWeight.w500,
                    color: const Color(UserColors.ui06),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentsWidget(String title, VoidCallback callback, bool arrow) {
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
          (arrow)
              ? const Icon(Icons.arrow_forward_ios, color: Colors.black)
              : Container(),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    _showYesNoDialog(
      Strings.logout,
      Strings.logoutGuide,
      _onLogout,
      ScreenUtil().setHeight(178.0),
    );
  }

  void _showWithDrawDialog() {
    _showYesNoDialog(
      Strings.withDraw,
      Strings.withDrawGiude,
      _onWithDraw,
      ScreenUtil().setHeight(218.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      Strings.termsAndPolicies, _showAgreementPage, true),
                  SizedBox(height: ScreenUtil().setHeight(26.0)),
                  _buildContentsWidget(
                      Strings.accountCancel, _showWithDrawDialog, false),
                  SizedBox(height: ScreenUtil().setHeight(26.0)),
                  _buildContentsWidget(
                      Strings.logout, _showLogoutDialog, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
