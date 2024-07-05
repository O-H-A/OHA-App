import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../statics/Colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';
import 'infinity_button.dart';

class ReportCompleteDialog extends StatefulWidget {
  const ReportCompleteDialog({super.key});
  @override
  State<ReportCompleteDialog> createState() => _ReportCompleteDialogState();

  static void showCompleteDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const ReportCompleteDialog();
      },
    );
  }
}

class _ReportCompleteDialogState extends State<ReportCompleteDialog> {
  Widget _buildSMIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(12.0)),
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

  Widget _buildTitleText() {
    return Text(
      Strings.reportCompleteTitle,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: ScreenUtil().setSp(16.0),
      ),
    );
  }

  Widget _buildGuideText() {
    return Text(
      Strings.reportCompleteGuide,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w400,
          fontSize: ScreenUtil().setSp(14.0),
          height: 1.5),
      textAlign: TextAlign.center,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(75.0),
          left: ScreenUtil().setWidth(12.0),
          right: ScreenUtil().setWidth(12.0)),
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(311.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(20.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSMIndicator(),
              SizedBox(height: ScreenUtil().setHeight(25.0)),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(Images.reportComplete),
                  _buildTitleText(),
                  _buildGuideText(),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                ],
              )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(22.0)),
                child: InfinityButton(
                  height: ScreenUtil().setHeight(50.0),
                  radius: 8.0,
                  backgroundColor: const Color(UserColors.primaryColor),
                  text: Strings.next,
                  textSize: 16,
                  textWeight: FontWeight.w600,
                  textColor: Colors.white,
                  callback: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
