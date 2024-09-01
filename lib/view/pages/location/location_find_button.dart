import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:oha/view_model/location_view_model.dart';
import '../../../statics/colors.dart';
import '../../../statics/strings.dart';

class LocationFindButton extends StatelessWidget {
  final Function(Map<String, String>?) onLocationFound;

  const LocationFindButton({super.key, required this.onLocationFound});

  Future<void> _findCurrentLocation(BuildContext context) async {
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

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Map<String, String>? address = await _getAddressFromCoordinates(position.latitude, position.longitude);

    if (address != null) {
      final locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
      final allLocationList = locationViewModel.getLocationData.data?.data.locations;
    
      if (allLocationList != null) {
        List<Map<String, String>> matchedLocations = [];
        final currentAddress = '${address['si']} ${address['gu']} ${address['dong']}';

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
          onLocationFound(matchedLocations.first);
        } else {
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
    } else {
      print('Failed to get address from coordinates.');
    }
  }

  Future<Map<String, String>?> _getAddressFromCoordinates(double latitude, double longitude) async {
    final String clientId = '2hwkvju5mw';
    final String clientSecret = 'tVBIF6Olj6BOed8j9pmYIomWW8g5bLcWHD7wMUuO';
    
    final String url =
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$longitude,$latitude&output=json&orders=legalcode,admcode';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'] != null && data['results'].isNotEmpty) {
        final area1 = data['results'][0]['region']['area1']['name'];
        final area2 = data['results'][0]['region']['area2']['name'];
        final area3 = data['results'][0]['region']['area3']['name'];

        return {
          'si': area1,
          'gu': area2,
          'dong': area3,
        };
      }
    } else {
      print('Failed to fetch address from Naver API: ${response.statusCode}');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _findCurrentLocation(context),
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
