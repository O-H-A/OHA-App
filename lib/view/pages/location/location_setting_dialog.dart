import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';
import 'package:provider/provider.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../../vidw_model/location_view_model.dart';
import '../../widgets/button_icon.dart';

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

  LocationViewModel _locationViewModel = LocationViewModel();

  @override
  void initState() {
    super.initState();

    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    getFrequentLocation();
  }

  void _removeLocation(int index) {
    Map<String, dynamic> sendData = {"address": _fullLocations[index]};
    _locationViewModel.deleteFrequentDistricts(sendData);

    print("SendData : ${sendData}");

    setState(() {
      _selectedLocations[index] = "";
      _fullLocations[index] = "";
    });
  }

  void _showLocationPage(int index) async {
    Map<String, String?>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSettingPage()),
    );

    if (result != null) {
      String fullAddress = result['fullAddress'] ?? "";
      String lastAddress = result['lastAddress'] ?? "";
      setState(() {
        _selectedLocations[index] = lastAddress;
        _fullLocations[index] = fullAddress;
      });

      Map<String, dynamic> sendData = {"address": fullAddress};

      _locationViewModel.addFrequentDistricts(sendData);
    }
  }

  void getFrequentLocation() {
    int length =
        _locationViewModel.getFrequentLocationData.data?.data.length ?? 0;

    print("Jehee : ${_locationViewModel.getFrequentLocationData.data?.data}");

    String firstAddress = "";
    String secondAddress = "";
    String thirdAddress = "";

    for (int i = 0; i < length; i++) {
      if (i > 3) {
        return;
      }

      firstAddress = _locationViewModel
              .getFrequentLocationData.data?.data[i].firstAddress ??
          "";

      secondAddress = _locationViewModel
              .getFrequentLocationData.data?.data[i].secondAddress ??
          "";

      thirdAddress = _locationViewModel
              .getFrequentLocationData.data?.data[i].thirdAddress ??
          "";

      _selectedLocations[i] = thirdAddress;

      _fullLocations[i] = "$firstAddress $secondAddress $thirdAddress";
    }
  }

  Widget _buildLocationWidget(BuildContext context, int index) {
    return GestureDetector(
      onTap: () async {
        _showLocationPage(index);
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
                        ? _showLocationPage(index)
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
