import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';

class WeatherSelectDialog extends StatelessWidget {
  WeatherSelectDialog({
    Key? key,
  }) : super(key: key);

  final List<String> weatherTitleList = [
    Strings.cloudy,
    Strings.littleCloudy,
    Strings.manyCloud,
    Strings.sunny,
    Strings.rain,
    Strings.thunder,
    Strings.snow,
    Strings.thunderSnow,
    Strings.veryHot,
    Strings.wind,
    Strings.veryCold,
  ];

  final List<String> weatherImageList = [
    Images.cloudyDisable,
    Images.littleCloudyDisable,
    Images.manyCloudDisable,
    Images.sunnyDisable,
    Images.rainDisable,
    Images.thunderDisable,
    Images.snowDisable,
    Images.thunderRainDisable,
    Images.veryHotDisable,
    Images.windDisable,
    Images.veryColdDisable,
  ];

  final List<String> weatherEnableImageList = [
    Images.cloudyEnable,
    Images.littleCloudyEnable,
    Images.manyCloudEnable,
    Images.sunnyEnable,
    Images.rainEnable,
    Images.thunderEnable,
    Images.snowEnable,
    Images.thunderRainEnable,
    Images.veryHotEnable,
    Images.windEnable,
    Images.veryColdEnable,
  ];

  Widget _contentsWidget(
      BuildContext context, String image, String title, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(
            context, {'title': title, 'image': weatherEnableImageList[index]});
      },
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            width: ScreenUtil().setWidth(40.0),
            height: ScreenUtil().setHeight(40.0),
          ),
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
        bottom: ScreenUtil().setHeight(35.0),
        left: ScreenUtil().setWidth(22.0),
        right: ScreenUtil().setWidth(22.0),
      ),
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(507.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
        ),
        child: Center(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
            ),
            itemCount: weatherImageList.length,
            itemBuilder: (context, index) {
              return _contentsWidget(context, weatherImageList[index],
                  weatherTitleList[index], index);
            },
          ),
        ),
      ),
    );
  }
}
