import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view/widgets/now_weather_widget.dart';
import 'package:oha/view_model/location_view_model.dart';
import 'package:oha/view/pages/home/weather/weather_select_dialog.dart';
import 'package:oha/view/widgets/infinity_button.dart';
import 'package:provider/provider.dart';

import '../../../../view_model/weather_view_model.dart';
import '../../../widgets/back_close_app_bar.dart';
import '../../../widgets/complete_dialog.dart';
import '../../location/location_setting_dialog.dart';

class WeatherRegisterPage extends StatefulWidget {
  final bool editState;
  final String address;
  final int weatherId;

  const WeatherRegisterPage({
    Key? key,
    required this.editState,
    this.address = "",
    this.weatherId = 0,
  }) : super(key: key);

  @override
  State<WeatherRegisterPage> createState() => _WeatherRegisterPageState();
}

class _WeatherRegisterPageState extends State<WeatherRegisterPage> {
  String _selectTitle = "";
  String _selectImage = "";
  String _selectRegionCode = "";
  String _selectThirdAddress = "";
  String _selectWeatherCode = "";
  LocationViewModel _locationViewModel = LocationViewModel();
  WeatherViewModel _weatherViewModel = WeatherViewModel();
  List<String> _frequentRegionCode = ["", "", "", ""];
  List<String> _frequentThirdAddress = ["", "", "", ""];

  @override
  void initState() {
    super.initState();

    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    getFrequentRegionCode();
    getFrequentThirdAddress();
  }

  void getFrequentRegionCode() {
    List<String> list = _locationViewModel.getFrequentRegionCode();

    if (list.isNotEmpty) {
      _selectRegionCode = list[0];
    }

    for (int i = 0; i < list.length; i++) {
      _frequentRegionCode[i] = list[i];
    }
  }

  void getFrequentThirdAddress() {
    List<String> list = _locationViewModel.getFrequentThirdAddress();

    if (list.isNotEmpty) {
      _selectThirdAddress = list[0];
    }

    for (int i = 0; i < list.length; i++) {
      _frequentThirdAddress[i] = list[i];
    }
  }

  Widget _buildTitleGuide() {
    return Column(
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
      ],
    );
  }

  Widget _buildWeatherInfoGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(height: ScreenUtil().setHeight(22.0)),
      ],
    );
  }

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

  Widget _buildCurrentLocationGuide() {
    return const Text(
      Strings.curretLocationNeighborhood,
      style: TextStyle(
        fontFamily: "Pretendard",
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(UserColors.ui01),
      ),
    );
  }

  Widget _buildCurrentLocation() {
    return GestureDetector(
      onTap: () async {
        if (widget.editState == true) {
          return;
        }

        Map<String, String?>? result = await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          builder: (BuildContext context) {
            return LocationSettingBottomSheet();
          },
        );

        if (result != null) {
          String lastAddress = result['lastAddress'] ?? "";
          String regionCode = result['regionCode'] ?? "";
          setState(() {
            _selectThirdAddress = lastAddress;
            _selectRegionCode = regionCode;
          });
        }
      },
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
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15.0)),
          child: Row(
            children: [
              const Icon(Icons.expand_more, color: Color(UserColors.ui06)),
              SizedBox(width: ScreenUtil().setWidth(10.0)),
              Text(
                (widget.editState == true)
                    ? widget.address
                    : _selectThirdAddress,
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: (widget.editState == true)
                      ? Colors.grey
                      : const Color(UserColors.ui01),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getWeatherSelect() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WeatherSelectDialog();
      },
    );

    if (result != null) {
      setState(() {
        _selectTitle = result['title'];
        _selectImage = result['image'];
        _selectWeatherCode = Strings.weatherCodeMap[_selectTitle] ?? "";
      });
    }
  }

  Widget _buildEmptyWeatherSelect() {
    return GestureDetector(
      onTap: () async {
        _getWeatherSelect();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
              color: Colors.white,
              border: Border.all(
                color: const Color(UserColors.ui08),
              ),
            ),
            child: SizedBox(
              height: ScreenUtil().setHeight(82.0),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.cloudyDisable),
                SvgPicture.asset(Images.littleCloudyDisable),
                SvgPicture.asset(Images.manyCloudDisable),
                SvgPicture.asset(Images.sunnyDisable),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectWidgetWidget() {
    return GestureDetector(
      onTap: () {
        _getWeatherSelect();
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
              color: Colors.white,
              border: Border.all(
                color: const Color(UserColors.ui08),
              ),
            ),
            child: SizedBox(
              height: ScreenUtil().setHeight(82.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(25.0)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(_selectImage),
                SizedBox(
                  width: ScreenUtil().setWidth(32.0),
                ),
                Text(
                  _selectTitle,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool completeState() {
    return _selectImage != "" &&
        _selectTitle != "" &&
        _selectThirdAddress != "" &&
        _selectRegionCode != "";
  }

  void sendWeatherPosting() {
    if (!completeState()) {
      return;
    }

    Map<String, dynamic> sendData = {
      "regionCode": _selectRegionCode,
      "weatherCode": _selectWeatherCode,
    };

    Future<int> responseFuture;
    if (widget.editState) {
      sendData['weatherId'] = widget.weatherId;
      responseFuture = _weatherViewModel.editWeatherPosting(sendData);
    } else {
      responseFuture = _weatherViewModel.addWeatherPosting(sendData);
    }

    responseFuture.then((response) {
      if (response == 200 || response == 201) {
        setState(() {
          _weatherViewModel.fetchWeatherPostingMy();
        });
        

        Navigator.pop(context, true);
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return CompleteDialog(
                title: widget.editState
                    ? Strings.editWeatherCompleteText
                    : Strings.addWeatherCompleteText);
          },
        );
      } 
      else if(response == 409){
        
        CompleteDialog.showCompleteDialog(context, Strings.weatherOnce);
      }
    }).catchError((error) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BackCloseAppBar(title: Strings.weatherRegister),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleGuide(),
                    SizedBox(height: ScreenUtil().setHeight(46.0)),
                    _buildCurrentLocationGuide(),
                    SizedBox(height: ScreenUtil().setHeight(12.0)),
                    _buildCurrentLocation(),
                    SizedBox(height: ScreenUtil().setHeight(50.0)),
                    _buildWeatherInfoGuide(),
                    (_selectTitle == "" || _selectImage == "")
                        ? _buildEmptyWeatherSelect()
                        : _buildSelectWidgetWidget(),
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
                    const NowWeatherWidget(),
                    SizedBox(height: ScreenUtil().setHeight(52.0)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(23.0)),
              child: InfinityButton(
                height: ScreenUtil().setHeight(50.0),
                radius: ScreenUtil().radius(8.0),
                backgroundColor: (completeState())
                    ? const Color(UserColors.primaryColor)
                    : const Color(UserColors.ui10),
                text: (widget.editState == true)
                    ? Strings.editComple
                    : Strings.register,
                textSize: 16,
                textWeight: FontWeight.w600,
                textColor: (completeState())
                    ? Colors.white
                    : const Color(UserColors.ui06),
                callback: sendWeatherPosting,
              ),
            )
          ],
        ),
      ),
    );
  }
}
