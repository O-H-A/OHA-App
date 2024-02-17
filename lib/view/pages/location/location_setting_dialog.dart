import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
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

  void _removeLocation(int index) {
    setState(() {
      _selectedLocations[index] = "";
    });
  }

  void _showLocationPage(int index) async {
    _selectedLocations[index] = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LocationSettingPage()),
    );
    
    setState(() {});
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
                    callback: () => (_selectedLocations[index] == "") ? _showLocationPage(index) : _removeLocation(index),
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
          ],
        ),
      ),
    );
  }
}
