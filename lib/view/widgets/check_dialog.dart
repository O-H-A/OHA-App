import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';

class CheckDialog extends StatelessWidget {
  final double height;
  final String titleText;
  final String guideText;
  final VoidCallback checkCallback;

  const CheckDialog({
    Key? key,
    required this.height,
    required this.titleText,
    required this.guideText,
    this.checkCallback = _checkCallback,
  }) : super(key: key);

  static void _checkCallback() {}

  Widget _buildButtonWidget(String title) {
    return GestureDetector(
      onTap: () {
        checkCallback();
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(41.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
          color: const Color(UserColors.primaryColor),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(50.0),
        left: ScreenUtil().setWidth(25.0),
        right: ScreenUtil().setWidth(25.0),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(14.0),
                  vertical: ScreenUtil().setHeight(22.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(24.0)),
                  Text(
                    guideText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(UserColors.ui01),
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(24.0)),
                  _buildButtonWidget(Strings.check),
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(20.0),
            right: ScreenUtil().setWidth(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                size: 24.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
