import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/location/location_app_bar_widget.dart';
import 'package:oha/view/pages/location/location_find_button.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';

class LocationSettingPage extends StatefulWidget {
  const LocationSettingPage({super.key});

  @override
  State<LocationSettingPage> createState() => _LocationSettingPageState();
}

class _LocationSettingPageState extends State<LocationSettingPage> {
  final _controller = TextEditingController();
  final List<String> _locationList = [];

  @override
  void initState() {
    super.initState();

    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
    _locationList.add("서울시 성북구 하월곡동");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBarWidget(title: Strings.locationSetting),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color(UserColors.ui06),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(UserColors.ui11),
                hintText: Strings.locationHint,
                hintStyle: const TextStyle(
                  color: Color(UserColors.ui06),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: null,
            ),
            SizedBox(height: ScreenUtil().setHeight(14.0)),
            const LocationFindButton(),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            const Text(
              Strings.neighborhoodLocation,
              style: TextStyle(
                fontFamily: "Pretendard",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(UserColors.ui06),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            Expanded(
              child: ListView.builder(
                  itemCount: _locationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(24.0)),
                      child: Text(
                        _locationList[index],
                        style: const TextStyle(
                          fontFamily: "Pretendard",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(UserColors.ui01),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
