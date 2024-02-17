import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/location/location_setting_page.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';

class LocationSettingBottomSheet {
  static Widget _buildLocationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationSettingPage()),
        );
      },
      child: Stack(
        children: [
          Container(
            width: ScreenUtil().setWidth(139.0),
            height: ScreenUtil().setHeight(41.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
              color: Colors.white,
              border: Border.all(color: const Color(UserColors.ui08)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    Strings.locationSetting,
                    style: TextStyle(
                        color: const Color(UserColors.ui06),
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.add,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> show(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
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
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(27.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLocationWidget(context),
                      _buildLocationWidget(context),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(12.0)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(27.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLocationWidget(context),
                      _buildLocationWidget(context),
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
}
