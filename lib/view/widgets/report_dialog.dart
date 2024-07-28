import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/report_complete_dialog.dart';
import 'package:oha/view_model/upload_view_model.dart';
import 'package:provider/provider.dart';

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

  static List<String> reportReasonList = [
    "REP_RSN_001", // 마음에 들지 않음
    "REP_RSN_002", // 스팸
    "REP_RSN_003", // 나체 이미지 또는 성적 행위
    "REP_RSN_004", // 혐오 발언 또는 상징
    "REP_RSN_005", // 거짓 정보
    "REP_RSN_006", // 저작권 침해 및 도용
  ];

  static Widget _buildSMIndicator() {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(67.0),
        height: ScreenUtil().setHeight(5.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }

  static Widget _contentsWidget(BuildContext context, int index, int postId) {
    String title = titleList[index];
    String reasonCode = reportReasonList[index];

    return GestureDetector(
      onTap: () {
        final uploadViewModel =
            Provider.of<UploadViewModel>(context, listen: false);

        Map<String, dynamic> sendData = {
          Strings.postIdKey: postId,
          Strings.reasonCodeKey: reasonCode,
        };

        uploadViewModel.report(sendData);
        Navigator.pop(context);
        ReportCompleteDialog.showCompleteDialog(context);
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

  static Future<void> show(BuildContext context, int postId) async {
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
            height: ScreenUtil().setHeight(425.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(12.0),
                  vertical: ScreenUtil().setHeight(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSMIndicator(),
                  Column(
                    children: [
                      for (int i = 0; i < titleList.length; i++)
                        Column(children: [
                          _contentsWidget(context, i, postId),
                          SizedBox(height: ScreenUtil().setHeight(12.0)),
                        ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
