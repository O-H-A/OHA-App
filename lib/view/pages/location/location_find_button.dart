import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/statics/colors.dart';

import '../../../statics/strings.dart';

class LocationFindButton extends StatelessWidget {
  const LocationFindButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: ScreenUtil().setHeight(50.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
            color: const Color(UserColors.primaryColor),
          ),
        ),
        Positioned(
            top: ScreenUtil().setHeight(10.0),
            bottom: ScreenUtil().setHeight(14.0),
            left: ScreenUtil().setWidth(10.0),
            child: const Icon(
              Icons.location_searching,
              color: Colors.white,
            )),
        const Text(
          Strings.findCurrentLocation,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ],
    );
  }
}
