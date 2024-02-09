import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/report_dialog.dart';

import '../../statics/Colors.dart';
import '../../statics/strings.dart';

class MoreDialog {
  static Widget _contentsWidget(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if(title == Strings.saveImage) {

        }
        else {
         Navigator.of(context).pop();
         ReportDialog.show(context); 
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

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.only(bottom: ScreenUtil().setHeight(35.0), left: ScreenUtil().setWidth(12.0), right: ScreenUtil().setWidth(12.0)),
          child: Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(167.0),
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
                  _contentsWidget(context, Strings.saveImage),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _contentsWidget(context, Strings.report),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
