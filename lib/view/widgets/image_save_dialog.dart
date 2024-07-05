import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../statics/Colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';

class ImageSaveDialog extends StatefulWidget {
  const ImageSaveDialog({super.key});
  @override
  State<ImageSaveDialog> createState() => _ImageSaveDialogState();

  static void showCompleteDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
        return const ImageSaveDialog();
      },
    );
  }
}

class _ImageSaveDialogState extends State<ImageSaveDialog> {
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
      alignment: Alignment.center,
      child: Container(
        width: ScreenUtil().setWidth(273.0),
        height: ScreenUtil().setHeight(90.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(20.0)),
          color: const Color(0xFFF2F2F2).withOpacity(0.80),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(12.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.imageSaveComplete,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(16.0),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: ()=> Navigator.of(context).pop(),
                child: Text(
                  Strings.check,
                  style: TextStyle(
                    color: const Color(0xFF007AFF),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
