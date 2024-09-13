import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:provider/provider.dart';
import '../../../../statics/images.dart';
import '../../statics/strings.dart';
import '../../view_model/location_view_model.dart';
import '../../view_model/weather_view_model.dart';
import 'loading_widget.dart';

class MainWeatherWidget extends StatefulWidget {
  const MainWeatherWidget({super.key});

  @override
  _MainWeatherWidgetState createState() => _MainWeatherWidgetState();
}

class _MainWeatherWidgetState extends State<MainWeatherWidget> {
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0 && !_isLoading) {
          _refreshWeather(context);
        }
      }
    });

    _refreshWeather(context);
  }

  Future<void> _refreshWeather(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<WeatherViewModel>(context, listen: false).getDefaultWeather();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocationViewModel, WeatherViewModel>(
      builder: (context, locationViewModel, weatherViewModel, child) {
        final neighborhood = locationViewModel.getDefaultLocation;
        final temperature = weatherViewModel.defaultWeatherData.data?.data.hourlyTemp ?? '';
        final widgetType = weatherViewModel.defaultWeatherData.data?.data.widget ?? '';
        final probPrecip = weatherViewModel.defaultWeatherData.data?.data.probPrecip ?? '';

        final String widgetImage = Images.mainWeatherImageMap[widgetType] ?? Images.littleCloudyEnable;
        String weatherName;

        if (widgetType == "KMA_MOSTLY_CLOUDY" && probPrecip.isNotEmpty) {
          weatherName = Strings.getProbPrecip(probPrecip);
        } else {
          weatherName = Strings.mainWeatherStringMap[widgetType] ?? Strings.mainWeatherCloudy;
        }

        return Stack(
          children: [
            NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                if (_scrollController.position.atEdge) {
                  if (_scrollController.position.pixels == 0 && !_isLoading) {
                    _refreshWeather(context);
                  }
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
                  child: Column(
                    children: [
                      Row(
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
                          SvgPicture.asset(widgetImage,
                              width: ScreenUtil().setWidth(50),
                              height: ScreenUtil().setHeight(105)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: LoadingWidget(),
              ),
          ],
        );
      },
    );
  }
}
