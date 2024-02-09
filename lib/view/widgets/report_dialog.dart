import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../statics/Colors.dart';
import '../../statics/strings.dart';

class ReportDialog {
  static List<String> titleList = [
    Strings.doNotLink,
    Strings.spam,
    Strings.nudityOrSexual,
    Strings.hate,
    Strings.falseInfomation,
    Strings.copyright
  ];

  static Widget _contentsWidget(String title) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(50.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
        color: const Color(UserColors.ui10),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(UserColors.ui01),
          ),
        ),
      ),
    );
  }

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(75.0),
              left: ScreenUtil().setWidth(12.0),
              right: ScreenUtil().setWidth(12.0)),
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(415.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(12.0),
                  left: ScreenUtil().setWidth(12.0),
                  right: ScreenUtil().setWidth(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < 6; i++)
                    Column(children: [
                      _contentsWidget(titleList[i]),
                      SizedBox(height: ScreenUtil().setHeight(12.0)),
                    ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
