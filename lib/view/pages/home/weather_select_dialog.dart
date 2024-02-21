import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../statics/Colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';

class WeatherSelectDialog extends StatelessWidget {
  static List<String> weatherTitleList = [
    Strings.cloudy,
    Strings.littleCloudy,
    Strings.manyCloud,
    Strings.sunny,
    Strings.rain,
    Strings.thunder,
    Strings.snow,
    Strings.thunderSnow,
    Strings.veryHot,
    Strings.nightAir,
    Strings.wind,
    Strings.veryCold,
    Strings.rainbow
  ];

  static List<String> weatherImageList = [
    Images.cloudyDisable,
    Images.littleCloudyDisable,
    Images.manyCloudDisable,
    Images.sunnyDisable,
    Images.rainDisable,
    Images.thunderDisable,
    Images.snowDisable,
    Images.thunderRainDisable,
    Images.veryHotDisable,
    Images.nightAirDisable,
    Images.windDisable,
    Images.veryColdDisable,
    Images.rainbowDisable,
  ];

  Widget _contentsWidget(BuildContext context, String image, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, {'title': title, 'image': image});
      },
      child: Column(
        children: [
          SvgPicture.asset(image),
          SizedBox(height: ScreenUtil().setHeight(22.0)),
          Text(
            title,
            style: const TextStyle(
                color: Color(UserColors.ui06),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(75.0),
        left: ScreenUtil().setWidth(12.0),
        right: ScreenUtil().setWidth(12.0),
      ),
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(507.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
          ),
          itemCount: 13,
          itemBuilder: (context, index) {
            return _contentsWidget(
              context,
              weatherImageList[index],
              weatherTitleList[index],
            );
          },
        ),
      ),
    );
  }
}
