import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/view/pages/home/weather/weather_register_page.dart';
import 'package:provider/provider.dart';

import '../../../../network/api_response.dart';
import '../../../../statics/colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../../view_model/location_view_model.dart';
import '../../../../view_model/weather_view_model.dart';
import '../../../widgets/back_app_bar.dart';
import '../../../widgets/button_icon.dart';
import '../../../widgets/complete_dialog.dart';
import '../../../widgets/loading_widget.dart';
import '../../mypage/delete_dialog.dart';

class MyWeatherRegisterPage extends StatefulWidget {
  const MyWeatherRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyWeatherRegisterPage> createState() => _MyWeatherRegisterPageState();
}

class _MyWeatherRegisterPageState extends State<MyWeatherRegisterPage> {
  WeatherViewModel _weatherViewModel = WeatherViewModel();
  LocationViewModel _locationViewModel = LocationViewModel();

  @override
  void initState() {
    super.initState();
    _weatherViewModel = Provider.of<WeatherViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    _weatherViewModel.fetchWeatherPostingMy();
  }

  void showDeleteDialog(String address, int weatherId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          titleText: Strings.deleteWeatherTitleText,
          guideText: Strings.deleteWeatherGuideText(address),
          yesCallback: () => onChangeHistoryDeleteYes(context, address, weatherId),
          noCallback: () => onChangeHistoryDeleteNo(context),
        );
      },
    );
  }

  void onChangeHistoryDeleteYes(BuildContext context, String address, weatherId) {
    Map<String, dynamic> sendData = {
      "weatherId": weatherId,
    };
    _weatherViewModel.deleteMyWeather(sendData).then((response) {
      if (response == 200) {
        Navigator.pop(context);
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return CompleteDialog(
                title: Strings.deleteWeatherCompleteText(address));
          },
        );
      } else {}
    }).catchError((error) {});
  }

  void onChangeHistoryDeleteNo(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildMyWeatherWidget() {
    return Consumer<WeatherViewModel>(
      builder: (context, weatherViewModel, child) {
        switch (weatherViewModel.weatherCountData.status) {
          case Status.loading:
            return const LoadingWidget();
          case Status.complete:
            var weatherList = weatherViewModel.getWeatherPostingMy.data?.data ?? [];
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                var weather = weatherList[index];
                return GestureDetector(
                  onTap: () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeatherRegisterPage(
                                editState: true,
                                address: _locationViewModel.getThirdAddressByRegionCode(
                                    weather.regionCode.toString()),
                                weatherCode: weather.weatherCode,
                              )),
                    );
                    if (result == true) {
                      _weatherViewModel.fetchWeatherPostingMy();
                    }
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
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(12.0)),
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
                                    _locationViewModel.getThirdAddressByRegionCode(
                                        weather.regionCode.toString()),
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
                                  showDeleteDialog(
                                      _locationViewModel.getThirdAddressByRegionCode(
                                          weather.regionCode.toString()),
                                      weather.weatherId);
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
          default:
            return const Center(
              child: Text("Error occurred, please try again."),
            );
        }
      },
    );
  }

  Widget _buildAddWeatherWidget() {
    return GestureDetector(
      onTap: () async {
        bool? result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const WeatherRegisterPage(editState: false)),
        );
        if (result == true) {
          _weatherViewModel.fetchWeatherPostingMy();
        }
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
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.0)),
              child: Row(
                children: [
                  ButtonIcon(
                    icon: Icons.add,
                    iconColor: Colors.black,
                    callback: () {},
                  ),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildMyWeatherWidget(),
              _buildAddWeatherWidget(),
              SizedBox(height: ScreenUtil().setHeight(50.0)),
            ],
          ),
        ),
      ),
    );
  }
}
