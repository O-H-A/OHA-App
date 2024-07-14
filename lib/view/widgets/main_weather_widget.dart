import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:provider/provider.dart';
import '../../../../statics/images.dart';
import '../../statics/strings.dart';
import '../../view_model/weather_view_model.dart';
import 'loading_widget.dart';

class MainWeatherWidget extends StatefulWidget {
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
  _MainWeatherWidgetState createState() => _MainWeatherWidgetState();
}

class _MainWeatherWidgetState extends State<MainWeatherWidget> {
  WeatherViewModel _weatherViewModel = WeatherViewModel();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _weatherViewModel = Provider.of<WeatherViewModel>(context, listen: false);

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0 && !_isLoading) {
          _refreshWeather();
        }
      }
    });
  }

  Future<void> _refreshWeather() async {
    setState(() {
      _isLoading = true;
    });

    await _weatherViewModel.getDefaultWeather();

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
    final String widgetImage = Images.mainWeatherImageMap[widget.widgetType] ??
        Images.littleCloudyEnable;
    String weatherName;

    if (widget.widgetType == "KMA_MOSTLY_CLOUDY" &&
        widget.probPrecip.isNotEmpty) {
      weatherName = Strings.getProbPrecip(widget.probPrecip);
    } else {
      weatherName = Strings.mainWeatherStringMap[widget.widgetType] ??
          Strings.mainWeatherCloudy;
    }

    return Stack(
      children: [
        NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            if (_scrollController.position.atEdge) {
              if (_scrollController.position.pixels == 0 && !_isLoading) {
                _refreshWeather();
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "현재 ${widget.neighborhood}은",
                            style: const TextStyle(
                                color: Color(UserColors.ui01),
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.w600,
                                fontSize: 24),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(12.0)),
                          Text(
                            "${widget.temperature}°C",
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
                          width: ScreenUtil().setWidth(75),
                          height: ScreenUtil().setHeight(115)),
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
  }
}
