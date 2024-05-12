import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/view/pages/home/weather/weather_register_page.dart';
import 'package:provider/provider.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../../vidw_model/weather_view_model.dart';
import '../../../widgets/back_app_bar.dart';
import '../../../widgets/button_icon.dart';

class MyWeatherRegisterPage extends StatefulWidget {
  const MyWeatherRegisterPage({super.key});

  @override
  State<MyWeatherRegisterPage> createState() => _MyWeatherRegisterPageState();
}

class _MyWeatherRegisterPageState extends State<MyWeatherRegisterPage> {
  WeatherViewModel _weatherViewModel = WeatherViewModel();

  @override
  void initState() {
    super.initState();
    _weatherViewModel = Provider.of<WeatherViewModel>(context, listen: false);

    _weatherViewModel.fetchWeatherPostingMy();
  }

Widget _buildMyWeatherWidget() {
  var weatherList = _weatherViewModel.getWeatherPostingMy.data?.data ?? [];

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: weatherList.length,
    itemBuilder: (context, index) {
      var weather = weatherList[index];
      return GestureDetector(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(22.0)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(UserColors.ui10),
                    width: ScreenUtil().setWidth(1.0),
                  ),
                ),
                child: SizedBox(
                  height: ScreenUtil().setHeight(50.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          Images.weatherImageMap[weather.weatherName] ?? '',
                          width: ScreenUtil().setWidth(22.0),
                          height: ScreenUtil().setHeight(22.0),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(11.0)),
                        Text(
                          weather.weatherName,
                          style: const TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    ButtonIcon(
                      icon: Icons.close,
                      iconColor: Colors.black,
                      callback: () {
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildAddWeatherWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WeatherRegisterPage()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(22.0)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
                color: Colors.white,
                border: Border.all(
                  color: const Color(UserColors.ui10),
                  width: ScreenUtil().setWidth(1.0),
                ),
              ),
              child: SizedBox(
                height: ScreenUtil().setHeight(50.0),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.0)),
              child: Row(
                children: [
                  ButtonIcon(
                      icon: Icons.add,
                      iconColor: Colors.black,
                      callback: () {}),
                  SizedBox(width: ScreenUtil().setWidth(17.0)),
                  const Text(
                    Strings.add,
                    style: TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackAppBar(title: Strings.myWeatherInformation),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            _buildMyWeatherWidget(),
            _buildAddWeatherWidget(),
          ],
        ),
      ),
    );
  }
}
