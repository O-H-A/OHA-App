import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget _buildContentsWidget(String title) {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          SizedBox(
            width: double.infinity,
            height: ScreenUtil().setHeight(380.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzXZT2D5aAY4xFSPf-VkK02mgELw4JG7OYp6Y6Alq5DbZmUE2DVOAwIBmR-uoByD9sie4&usqp=CAU",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: ScreenUtil().setHeight(380.0)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Images.myPageDefaultProfile),
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
                    const Text(
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
                SizedBox(height: ScreenUtil().setHeight(28.0)),
                _buildContentsWidget(Strings.termsAndPolicies),
                SizedBox(height: ScreenUtil().setHeight(26.0)),
                _buildContentsWidget(Strings.sendCommentsInquiries),
                SizedBox(height: ScreenUtil().setHeight(26.0)),
                _buildContentsWidget(Strings.accountCancel),
                SizedBox(height: ScreenUtil().setHeight(26.0)),
                _buildContentsWidget(Strings.logout),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
