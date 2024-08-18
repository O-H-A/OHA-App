import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../network/api_response.dart';
import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';
import '../../view_model/location_view_model.dart';
import '../../view_model/weather_view_model.dart';
import '../pages/error_page.dart';
import 'loading_widget.dart';

class NowWeatherWidget extends StatefulWidget {
  const NowWeatherWidget({super.key});

  @override
  State<NowWeatherWidget> createState() => _NowWeatherWidgetState();
}

class _NowWeatherWidgetState extends State<NowWeatherWidget> {
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

  void getRegionCode(LocationViewModel locationViewModel) {
    regionCode =
        locationViewModel.getFrequentLocationData.data?.data[0].code ?? '0';
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

  @override
  Widget build(BuildContext context) {
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
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: const Offset(3, 3),
                      ),
                    ],
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
                                Images.weatherImageMap[
                                        weatherData.weatherName] ??
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
}
