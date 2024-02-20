import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/vidw_model/location_view_model.dart';
import 'package:oha/view/pages/home_page.dart';
import 'package:oha/view/pages/location/location_app_bar_widget.dart';
import 'package:oha/view/pages/location/location_find_button.dart';
import 'package:provider/provider.dart';

import '../../../network/api_response.dart';
import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';

class LocationSettingPage extends StatefulWidget {
  const LocationSettingPage({super.key});

  @override
  State<LocationSettingPage> createState() => _LocationSettingPageState();
}

class _LocationSettingPageState extends State<LocationSettingPage> {
  final _controller = TextEditingController();
  List<String> _allLocationList = [];
  List<String> _displayLocationList = [];
  LocationViewModel _locationViewModel = LocationViewModel();
  String _selectedLocation = "";

  @override
  void initState() {
    super.initState();

    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    _allLocationList = _getAllLocations();
  }

  List<String> _getAllLocations() {
    List<String> locations = [];
    final data = _locationViewModel.getLocationData.data?.data.locations;

    if (data != null) {
      for (final province in data.keys) {
        final cityMap = data[province];

        if (cityMap != null) {
          for (final city in cityMap.keys) {
            final districts = cityMap[city];

            if (districts != null) {
              for (final district in districts) {
                String location = "$province $city $district";
                locations.add(location);
              }
            }
          }
        }
      }
    }

    return locations;
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
                      .where((location) => location.contains(value))
                      .toList();
                });
              },
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
                  itemCount: (_displayLocationList.isEmpty)
                      ? _allLocationList.length
                      : _displayLocationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(24.0)),
                      child: GestureDetector(
                        onTap: () {
                          String selectedLocation =
                              (_displayLocationList.isEmpty)
                                  ? _allLocationList[index]
                                  : _displayLocationList[index];

                          List<String> locationParts =
                              selectedLocation.split(' ');
                          String address = locationParts.isNotEmpty
                              ? locationParts.last
                              : '';

                          Navigator.pop(context, {'fullAddress': selectedLocation, 'lastAddress': address});
                        },
                        child: Text(
                          (_displayLocationList.isEmpty)
                              ? _allLocationList[index]
                              : _displayLocationList[index],
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
