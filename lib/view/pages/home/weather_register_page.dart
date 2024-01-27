import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/widgets/infinity_button.dart';

class WeatherRegisterPage extends StatefulWidget {
  const WeatherRegisterPage({super.key});

  @override
  State<WeatherRegisterPage> createState() => _WeatherRegisterPageState();
}

class _WeatherRegisterPageState extends State<WeatherRegisterPage> {
  Widget _buildWeatherInfoWIdget(String imagePath, String title, int count) {
    return Column(
      children: [
        SvgPicture.asset(imagePath),
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(UserColors.ui01),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(17.0)),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: count.toString(),
                style: const TextStyle(
                    color: Color(UserColors.primaryColor),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
              const TextSpan(
                text: Strings.weatherRegistered,
                style: TextStyle(
                    color: Color(UserColors.ui06),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          Strings.weatherRegister,
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  const Text(
                    Strings.neighborhoodWeather,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(9.0)),
                  const Text(
                    Strings.weatherRegisterGuide,
                    style: TextStyle(
                        color: Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(46.0)),
                  Container(
                    width: ScreenUtil().setWidth(139.0),
                    height: ScreenUtil().setHeight(41.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().radius(8.0)),
                      border: Border.all(
                          color: const Color(UserColors.ui08),
                          width: ScreenUtil().setWidth(1.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: ScreenUtil().setWidth(15.0)),
                      child: Row(
                        children: [
                          const Icon(Icons.expand_more,
                              color: Color(UserColors.ui06)),
                          SizedBox(width: ScreenUtil().setWidth(10.0)),
                          const Text(
                            "논현동",
                            style: TextStyle(
                              fontFamily: "Pretendard",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(UserColors.ui01),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(50.0)),
                  const Text(
                    Strings.questionWeather,
                    style: TextStyle(
                        color: Color(UserColors.ui01),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(9.0)),
                  const Text(
                    Strings.chooseIcon,
                    style: TextStyle(
                        color: Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(10.0)),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          height: ScreenUtil().setHeight(82.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Images.litteCloudIcon),
                            SvgPicture.asset(Images.cloudyIcon),
                            SvgPicture.asset(Images.cloudyIcon),
                            SvgPicture.asset(Images.cloudyIcon),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(23.0)),
                  const Text(
                    Strings.peopleWeatherInfo,
                    style: TextStyle(
                        color: Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w400,
                        fontSize: 13),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(8.0)),
                          color: Colors.white,
                        ),
                        child: SizedBox(
                          height: ScreenUtil().setHeight(182.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildWeatherInfoWIdget(
                                Images.litteCloudIcon, "약간 흐려요", 1132),
                            _buildWeatherInfoWIdget(
                                Images.cloudyIcon, "흐려요", 121),
                            _buildWeatherInfoWIdget(
                                Images.veryColdIcon, "매우 추워요", 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(23.0)),
              child: InfinityButton(
                height: ScreenUtil().setHeight(50.0),
                radius: ScreenUtil().radius(8.0),
                backgroundColor: const Color(UserColors.ui10),
                text: Strings.register,
                textSize: 16,
                textWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
