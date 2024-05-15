import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/statics/Colors.dart';

import '../../statics/strings.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  Widget _buildMainGuideText() {
    return const Text(
      Strings.internetErrorMainText,
      style: TextStyle(
        fontFamily: "Pretendard",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSubGuideText() {
    return const Text(
      Strings.internetErrorSubText,
      style: TextStyle(
        fontFamily: "Pretendard",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(UserColors.ui06),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMainGuideText(),
            SizedBox(height: ScreenUtil().setHeight(4.0)),
            _buildSubGuideText(),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
          ],
        ),
      ),
    );
  }
}
