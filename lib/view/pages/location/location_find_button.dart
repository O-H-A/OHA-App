import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:oha/view_model/location_view_model.dart';
import '../../../statics/colors.dart';
import '../../../statics/strings.dart';

class LocationFindButton extends StatelessWidget {
  const LocationFindButton({super.key});

  Future<void> _findCurrentLocation(BuildContext context) async {
    // 위치 권한 확인
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print('Location permissions are denied');
        return;
      }
    }

    // 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // 위도와 경도를 주소로 변환
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0]; // 첫 번째 결과 사용

    // 현재 위치 출력
    print('Current location: ${placemark.administrativeArea}, ${placemark.subAdministrativeArea}, ${placemark.locality}');

    // 위치 비교 및 알림
    final locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    final allLocationList = locationViewModel.getLocationData.data?.data.locations;
    
    if (allLocationList != null) {
      List<Map<String, String>> matchedLocations = [];
      final currentAddress = '${placemark.administrativeArea} ${placemark.subAdministrativeArea} ${placemark.locality}';

      // 리스트에서 현재 위치와 일치하는 항목 찾기
      for (final province in allLocationList.keys) {
        final cityMap = allLocationList[province];
        if (cityMap != null) {
          for (final city in cityMap.keys) {
            final districts = cityMap[city];
            if (districts != null) {
              for (final district in districts) {
                final fullAddress = "$province $city ${district.address}";
                if (fullAddress == currentAddress) {
                  matchedLocations.add({
                    'fullAddress': fullAddress,
                    'address': district.address,
                    'code': district.code,
                  });
                }
              }
            }
          }
        }
      }

      if (matchedLocations.isNotEmpty) {
        // 일치하는 항목이 있을 경우
        Navigator.pop(context, matchedLocations.first);
      } else {
        // 일치하는 항목이 없을 경우 팝업 표시
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('위치 확인'),
            content: Text('현재 위치와 일치하는 항목이 없습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _findCurrentLocation(context), // 클릭 시 현재 위치 찾기
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: ScreenUtil().setHeight(50.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
              color: Color(UserColors.primaryColor),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(10.0),
            bottom: ScreenUtil().setHeight(14.0),
            left: ScreenUtil().setWidth(10.0),
            child: const Icon(
              Icons.location_searching,
              color: Colors.white,
            ),
          ),
          const Text(
            Strings.findCurrentLocation,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
