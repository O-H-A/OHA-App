import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';
import 'package:oha/view/widgets/complete_dialog.dart';
import 'package:provider/provider.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../../vidw_model/location_view_model.dart';
import '../../widgets/button_icon.dart';
import 'location_change_dialog.dart';

class LocationSettingBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _LocationSettingBottomSheetContent();
  }
}

class _LocationSettingBottomSheetContent extends StatefulWidget {
  @override
  _LocationSettingBottomSheetContentState createState() =>
      _LocationSettingBottomSheetContentState();
}

class _LocationSettingBottomSheetContentState
    extends State<_LocationSettingBottomSheetContent> {
  final List<String> _selectedLocations = ["", "", "", ""];
  final List<String> _fullLocations = ["", "", "", ""];
  final List<String> _frequentRegionCode = ["", "", "", ""];

  LocationViewModel _locationViewModel = LocationViewModel();

  @override
  void initState() {
    super.initState();

    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    getFrequentLocation();
    getFrequentRegionCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _removeLocation(int index) {
    if (_locationViewModel.getFrequentLength() <= 1) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return LocationChangeDialog(
            yesCallback: () => onLocationChangeYes(context),
            noCallback: () => onLocationChangeNo(context),
          );
        },
      );
    } else {
      Map<String, dynamic> sendData = {"address": _fullLocations[index]};
      _locationViewModel.deleteFrequentDistricts(sendData);

      setState(() {
        _selectedLocations[index] = "";
        _fullLocations[index] = "";
      });
    }
  }

  void onLocationChangeYes(BuildContext context) {
    Navigator.pop(context);
    _addFrequentLocation(context, 0);
  }

  void onLocationChangeNo(BuildContext context) {
    Navigator.pop(context);
  }

  void _addFrequentLocation(BuildContext context, int index) async {
    Map<String, String?>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSettingPage()),
    );

    if (result != null) {
      String fullAddress = result['fullAddress'] ?? "";
      String lastAddress = result['lastAddress'] ?? "";

      Map<String, dynamic> sendData = {"address": fullAddress};

      await _locationViewModel.addFrequentDistricts(sendData);

      setState(() {
        _selectedLocations[index] = lastAddress;
        _fullLocations[index] = fullAddress;
      });
    }

    _locationViewModel.fetchAllDistricts();
  }

  void getFrequentRegionCode() {
    List<String> list = _locationViewModel.getFrequentRegionCode();

    for (int i = 0; i < list.length; i++) {
      _frequentRegionCode[i] = list[i];
    }
  }

  void getFrequentLocation() {
    List<String> fullList = _locationViewModel.getFrequentFullAddress();
    List<String> thirdList = _locationViewModel.getFrequentThirdAddress();

    for (int i = 0; i < fullList.length; i++) {
      _fullLocations[i] = fullList[i];
    }

    for (int i = 0; i < thirdList.length; i++) {
      _selectedLocations[i] = thirdList[i];
    }
  }

  Widget _buildLocationWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        if (_selectedLocations[index] == "") {
          _addFrequentLocation(context, index);
        } else {
          Navigator.pop(context, {
            'lastAddress': _selectedLocations[index],
            'regionCode': _frequentRegionCode[index]
          });

          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (BuildContext context) {
              return CompleteDialog(title: _selectedLocations[index]);
            },
          );
        }
      },
      child: Stack(
        children: [
          Container(
            width: ScreenUtil().setWidth(139.0),
            height: ScreenUtil().setHeight(41.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
              color: (_selectedLocations[index] == "")
                  ? Colors.white
                  : const Color(UserColors.primaryColor),
              border: Border.all(
                  color: (_selectedLocations[index] == "")
                      ? const Color(UserColors.ui08)
                      : Colors.white),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      (_selectedLocations[index] == "")
                          ? Strings.locationSetting
                          : _selectedLocations[index],
                      style: TextStyle(
                        color: (_selectedLocations[index] == "")
                            ? const Color(UserColors.ui06)
                            : Colors.white,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  ButtonIcon(
                    icon: (_selectedLocations[index] == "")
                        ? Icons.add
                        : Icons.close,
                    iconColor: (_selectedLocations[index] == "")
                        ? const Color(UserColors.ui01)
                        : Colors.white,
                    callback: () => (_selectedLocations[index] == "")
                        ? _addFrequentLocation(context, index)
                        : _removeLocation(index),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().setHeight(293.0),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(22.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(44.0)),
            const Text(
              Strings.locationSetting,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            SizedBox(height: ScreenUtil().setHeight(4.0)),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: Strings.loginSubText1,
                    style: TextStyle(
                      color: Color(UserColors.primaryColor),
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: Strings.locationSettingDioagGuide,
                    style: TextStyle(
                      color: Color(UserColors.ui06),
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(16.0)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLocationWidget(context, 0),
                  _buildLocationWidget(context, 1),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLocationWidget(context, 2),
                  _buildLocationWidget(context, 3),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(16.0)),
            const Center(
              child: Text(
                Strings.frequentlyVistedAreaGuide,
                style: TextStyle(
                    color: Color(UserColors.ui06),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      // 커스텀 다이얼로그의 디자인을 구성합니다.
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('내용을 입력하세요'),
            // 다이얼로그 내용 추가
            // 필요한 경우 버튼이나 다른 위젯을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}

// 사용 예시
void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog();
    },
  );
}
