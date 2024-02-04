import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oha/view/pages/location/location_app_bar_widget.dart';

import '../../../statics/Colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';
import '../../widgets/infinity_button.dart';

class MapSettingPage extends StatefulWidget {
  const MapSettingPage({super.key});

  @override
  State<MapSettingPage> createState() => _MapSettingPageState();
}

class _MapSettingPageState extends State<MapSettingPage> {
  late NaverMapController _mapController;
  final Completer<NaverMapController> _mapControllerCompleter = Completer();
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((position) {
      setState(() {
        _currentPosition = position;
      });
    });
  }

  Widget _loadNaverMap() {
    return FutureBuilder(
      future: getCurrentLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          _currentPosition = snapshot.data;
          return NaverMap(
            options: NaverMapViewOptions(
              indoorEnable: true,
              locationButtonEnable: false,
              consumeSymbolTapEvents: false,
              locale: const Locale('ko'),
              logoClickEnable: false,
              // initialCameraPosition: NCameraPosition(
              //   target: NLatLng(
              //   _currentPosition.latitude,
              //   _currentPosition.longitude),
              //   zoom: 10,
              //   bearing: 0,
              //   tilt: 0,
              // ),
            ),
            onMapReady: (controller) async {
              _mapController = controller;
              _mapControllerCompleter.complete(controller);

              final markerImage =
                  await NOverlayImage.fromAssetImage(Images.marker);

              final marker = NMarker(
                  id: '1',
                  position: NLatLng(37.5666, 126.979),
                  icon: markerImage);

              _mapController.addOverlay(marker);
            },
          );
        }
      },
    );
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBarWidget(
        title: Strings.findCurrentLocationMap,
        backIcon: Icons.arrow_back_ios,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _loadNaverMap()),
          Container(
            width: ScreenUtil().setWidth(119.0),
            height: ScreenUtil().setHeight(35.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
              color: Colors.white,
              border: Border.all(color: const Color(UserColors.ui08)),
            ),
            child: const Center(
              child: Text(
                Strings.viewAddress,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40.0),
                bottom: ScreenUtil().setHeight(20.0),
                left: ScreenUtil().setWidth(22.0),
                right: ScreenUtil().setWidth(22.0)),
            child: InfinityButton(
              height: ScreenUtil().setHeight(50.0),
              radius: 8.0,
              backgroundColor: const Color(UserColors.primaryColor),
              text: Strings.next,
              textSize: 16,
              textWeight: FontWeight.w600,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
