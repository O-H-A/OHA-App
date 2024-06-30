import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/pages/error_page.dart';
import 'package:oha/view/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../../network/api_response.dart';
import '../../../../view_model/location_view_model.dart';
import '../../../../view_model/weather_view_model.dart';
import '../weather/my_weather_register_page.dart';
import '../weather/weather_register_page.dart';

class NowWeatherTab extends StatefulWidget {
  const NowWeatherTab({super.key});

  @override
  State<NowWeatherTab> createState() => _NowWeatherTabState();
}

class _NowWeatherTabState extends State<NowWeatherTab> {
  String regionCode = "";
  VoidCallback? _retryCallback;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locationViewModel =
          Provider.of<LocationViewModel>(context, listen: false);
      final weatherViewModel =
          Provider.of<WeatherViewModel>(context, listen: false);

      getRegionCode(locationViewModel);
      Map<String, dynamic> sendData = {
        "regionCode": locationViewModel.getDefaultLocationCode
      };

      try {
        weatherViewModel.fetchWeatherCount(sendData).then((_) {
          _retryCallback = null;
        }).catchError((error) {
          _retryCallback = () => weatherViewModel.fetchWeatherCount(sendData);
        });
        weatherViewModel.setWeatherCount(ApiResponse.loading());
      } catch (error) {
        _retryCallback = () => weatherViewModel.fetchWeatherCount(sendData);
      }
    });
  }

  Widget _buildNowWeatherNewsText() {
    return const Text(
      Strings.nowWeatherNews,
      style: TextStyle(
        fontFamily: "Pretendard",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(UserColors.ui01),
      ),
    );
  }

  void getRegionCode(LocationViewModel locationViewModel) {
    regionCode =
        locationViewModel.getFrequentLocationData.data?.data[0].code ?? '0';
  }

  Widget _buildWeatherInfoWidget(String imagePath, String title, int count) {
    return Column(
      children: [
        SvgPicture.asset(imagePath),
        SizedBox(height: ScreenUtil().setHeight(36.0)),
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

  Widget _buildWeatherEmptyWidget() {
    return Column(
      children: [
        SvgPicture.asset(Images.nowWeatherEmpty),
        const Text(
          Strings.nowWeatherEmptyGuide1,
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(UserColors.ui06),
          ),
        ),
        const Text(
          Strings.nowWeatherEmptyGuide2,
          style: TextStyle(
            fontFamily: "Pretendard",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(UserColors.ui06),
          ),
        ),
      ],
    );
  }

  Widget _buildNowWeatherWidget() {
    return Consumer<WeatherViewModel>(
      builder: (context, weatherViewModel, child) {
        switch (weatherViewModel.weatherCountData.status) {
          case Status.loading:
            return const LoadingWidget();
          case Status.complete:
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().radius(8.0)),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(UserColors.ui08),
                      width: ScreenUtil().setWidth(1.0),
                    ),
                  ),
                  child: SizedBox(
                    height: ScreenUtil().setHeight(182.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(46.0)),
                  child: weatherViewModel.topThreeWeatherData.isEmpty
                      ? _buildWeatherEmptyWidget()
                      : Row(
                          mainAxisAlignment:
                              weatherViewModel.topThreeWeatherData.length == 1
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: weatherViewModel.topThreeWeatherData
                              .map((weatherData) {
                            return _buildWeatherInfoWidget(
                                Images.weatherImageMap[weatherData.weatherName] ??
                                    '',
                                weatherData.weatherName,
                                weatherData.count);
                          }).toList(),
                        ),
                ),
              ],
            );
          default:
            return ErrorPage(isNetworkError: false, onRetry: _retryCallback);
        }
      },
    );
  }

  Widget _buildMyRegisterWeatherWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MyWeatherRegisterPage()),
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
                  color: const Color(UserColors.primaryColor),
                  width: ScreenUtil().setWidth(1.0),
                ),
              ),
              child: SizedBox(
                height: ScreenUtil().setHeight(50.0),
              ),
            ),
            const Text(
              Strings.myWeatherInformation,
              style: TextStyle(
                fontFamily: "Pretendard",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(UserColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherRegisterWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const WeatherRegisterPage(editState: false)),
        );
      },
      child: Stack(
        children: [
          SvgPicture.asset(Images.weatherRegistedBg),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(155.0),
                left: ScreenUtil().setWidth(32.0)),
            child: Container(
              width: ScreenUtil().setWidth(139.0),
              height: ScreenUtil().setHeight(41.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
                border: Border.all(
                    color: const Color(UserColors.ui08),
                    width: ScreenUtil().setWidth(1.0)),
                color: Colors.white,
              ),
              child: const Center(
                child: Text(
                  Strings.register,
                  style: TextStyle(
                    fontFamily: "Pretendard",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(UserColors.ui01),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtil().setHeight(12.0)),
        _buildNowWeatherNewsText(),
        SizedBox(height: ScreenUtil().setHeight(12.0)),
        _buildNowWeatherWidget(),
        _buildMyRegisterWeatherWidget(),
        _buildWeatherRegisterWidget(),
        SizedBox(height: ScreenUtil().setHeight(100.0)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCompleteWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
