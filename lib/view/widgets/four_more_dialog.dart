import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/report_dialog.dart';

import '../../statics/Colors.dart';
import '../../statics/strings.dart';

class FourMoreDialog {
  static Widget _contentsWidget(BuildContext context, String title, Function(String) onTap) {
    return GestureDetector(
      onTap: () {
        if (title == Strings.report) {
          Navigator.of(context).pop();
          ReportDialog.show(context);
        } else {
          onTap(title);
        }
      },
      child: Container(
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
      ),
    );
  }

  static Future<void> show(BuildContext context, Function(String) onTap) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.only(
              bottom: ScreenUtil().setHeight(35.0),
              left: ScreenUtil().setWidth(12.0),
              right: ScreenUtil().setWidth(12.0)),
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(301.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(12.0),
                  bottom: ScreenUtil().setHeight(12.0),
                  left: ScreenUtil().setWidth(12.0),
                  right: ScreenUtil().setWidth(12.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _contentsWidget(context, Strings.saveImage, onTap),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _contentsWidget(context, Strings.edit, onTap),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _contentsWidget(context, Strings.report, onTap),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _contentsWidget(context, Strings.delete, onTap),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
  