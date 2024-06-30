import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import '../../../../statics/images.dart';
import '../../statics/strings.dart';

class MainWeatherWidget extends StatelessWidget {
  final String neighborhood;
  final String temperature;
  final String widgetType;
  final String probPrecip;

  const MainWeatherWidget({
    super.key,
    required this.neighborhood,
    required this.temperature,
    required this.widgetType,
    this.probPrecip = "",
  });

  @override
  Widget build(BuildContext context) {
    final String widgetImage =
        Images.mainWeatherImageMap[widgetType] ?? Images.littleCloudyEnable;
    String weatherName;

    if (widgetType == "KMA_MOSTLY_CLOUDY" && probPrecip.isNotEmpty) {
      weatherName = Strings.getProbPrecip(probPrecip);
    } else {
      weatherName = Strings.mainWeatherStringMap[widgetType] ?? Strings.mainWeatherCloudy;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "현재 $neighborhood은",
                style: const TextStyle(
                    color: Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              Text(
                "$temperature°C",
                style: TextStyle(
                    color: const Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(35.0)),
              ),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              Text(
                weatherName,
                style: TextStyle(
                    color: const Color(UserColors.ui04),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(14.0)),
              ),
            ],
          ),
          // here
          SvgPicture.asset(widgetImage,
              width: ScreenUtil().setWidth(75),
              height: ScreenUtil().setHeight(115)
              ),
        ],
      ),
    );
  }
}
