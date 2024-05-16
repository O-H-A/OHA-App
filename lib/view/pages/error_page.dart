import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/statics/Colors.dart';

import '../../app.dart';
import '../../statics/strings.dart';

class ErrorPage extends StatefulWidget {
  final bool isNetworkError;
  final VoidCallback? onRetry;

  const ErrorPage({Key? key, required this.isNetworkError, this.onRetry})
      : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  Widget _buildMainGuideText() {
    return Text(
      (widget.isNetworkError == true) ? Strings.internetErrorMainText : Strings.apiErrorMainText,
      style: const TextStyle(
        fontFamily: "Pretendard",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSubGuideText() {
    return  Text(
      (widget.isNetworkError == true) ? Strings.internetErrorSubText : Strings.apiErrorSubText,
      style: const TextStyle(
        fontFamily: "Pretendard",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(UserColors.ui06),
      ),
    );
  }

  Widget _buildButtonWidget() {
    return GestureDetector(
      onTap: () {
        if (widget.isNetworkError == true) {
          if (widget.onRetry != null) {
            widget.onRetry!();
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const App()),
          );
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: ScreenUtil().setWidth(150.0),
            height: ScreenUtil().setHeight(41.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
                color: const Color(UserColors.primaryColor)),
          ),
          Text(
            (widget.isNetworkError == true) ? Strings.retry : Strings.goHome,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
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
            _buildButtonWidget(),
          ],
        ),
      ),
    );
  }
}
