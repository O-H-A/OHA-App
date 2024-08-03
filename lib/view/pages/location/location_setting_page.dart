import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/widgets/complete_dialog.dart';
import 'package:oha/view_model/location_view_model.dart';
import 'package:oha/view/pages/location/location_app_bar_widget.dart';
import 'package:oha/view/pages/location/location_find_button.dart';
import 'package:provider/provider.dart';
import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';

class LocationSettingPage extends StatefulWidget {
  const LocationSettingPage({super.key});

  @override
  State<LocationSettingPage> createState() => _LocationSettingPageState();
}

class _LocationSettingPageState extends State<LocationSettingPage> {
  final _controller = TextEditingController();
  List<Map<String, String>> _allLocationList = [];
  List<Map<String, String>> _displayLocationList = [];
  late LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();

    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    _allLocationList = _getAllLocations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Map<String, String>> _getAllLocations() {
    List<Map<String, String>> locations = [];
    final data = _locationViewModel.getLocationData.data?.data.locations;

    if (data != null) {
      for (final province in data.keys) {
        final cityMap = data[province];
        if (cityMap != null) {
          for (final city in cityMap.keys) {
            final districts = cityMap[city];
            if (districts != null) {
              for (final district in districts) {
                locations.add({
                  'fullAddress': "$province $city ${district.address}",
                  'address': district.address,
                  'code': district.code,
                });
              }
            }
          }
        }
      }
    }
    return locations;
  }

  void _showAlreadyAddedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("이미 설정된 지역"),
          content: Text("이 지역은 이미 설정되어 있습니다."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("확인"),
            ),
          ],
        );
      },
    );
  }

  void _onLocationFound(Map<String, String>? location) {
    if (location != null) {
      setState(() {
        _controller.text = location['fullAddress']!;
        _displayLocationList = [location];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBarWidget(
          title: Strings.locationSetting, backIcon: Icons.close),
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
              onChanged: (value) {
                setState(() {
                  _displayLocationList = _allLocationList
                      .where((location) => location['fullAddress']!
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            SizedBox(height: ScreenUtil().setHeight(14.0)),
            LocationFindButton(onLocationFound: _onLocationFound),
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
                  itemCount: (_displayLocationList.isEmpty)
                      ? _allLocationList.length
                      : _displayLocationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final locationMap = (_displayLocationList.isEmpty)
                        ? _allLocationList[index]
                        : _displayLocationList[index];
                    final locationDisplay = locationMap['fullAddress'] ?? '';
                    final locationCode = locationMap['code'] ?? '';

                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(24.0)),
                      child: GestureDetector(
                        onTap: () async {
                          if (_locationViewModel
                              .isLocationAlreadyAdded(locationCode)) {
                                CompleteDialog.showCompleteDialog(context, Strings.isLocationAlreadyAdded);
                          } else {
                            await _locationViewModel.fetchFrequentDistricts();
                            Navigator.pop(context, locationMap);
                          }
                        },
                        child: Text(
                          locationDisplay,
                          style: const TextStyle(
                            fontFamily: "Pretendard",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(UserColors.ui01),
                          ),
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
