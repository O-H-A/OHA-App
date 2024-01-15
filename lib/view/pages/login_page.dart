import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/colors.dart';

import '../../statics/images.dart';
import '../../statics/strings.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: ScreenUtil().setHeight(86.0)),
          Expanded(
              child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  Strings.loginMainText,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                SizedBox(height: ScreenUtil().setHeight(6.0)),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: Strings.loginSubText1,
                        style: TextStyle(
                            color: Color(UserColors.primaryColor),
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      TextSpan(
                        text: Strings.loginSubText2,
                        style: TextStyle(
                            color: Color(UserColors.ui06),
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          SvgPicture.asset(Images.loginBg),
          SizedBox(height: ScreenUtil().setHeight(28.0)),
          SvgPicture.asset(Images.loginKakao),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          SvgPicture.asset(Images.loginApple),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          SvgPicture.asset(Images.loginGoogle),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          SvgPicture.asset(Images.loginNaver),
          SizedBox(height: ScreenUtil().setHeight(166.0)),
        ],
      ),
    );
  }
}
