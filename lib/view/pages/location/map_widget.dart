// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:oha/view/pages/location/location_app_bar_widget.dart';

// import '../../../statics/images.dart';
// import '../../../statics/strings.dart';

// class MapWidget extends StatefulWidget {
//   const MapWidget({super.key});

//   @override
//   State<MapWidget> createState() => _MapWidgetState();
// }

// class _MapWidgetState extends State<MapWidget> {
//   late NaverMapController _mapController;
//   final Completer<NaverMapController> _mapControllerCompleter = Completer();
//   late Position _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     getCurrentLocation().then((position) {
//       setState(() {
//         _currentPosition = position;
//       });
//     });
//   }

//   Widget _loadNaverMap() {
//     return FutureBuilder(
//       future: getCurrentLocation(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           _currentPosition = snapshot.data;
//           return NaverMap(
//             options: NaverMapViewOptions(
//               indoorEnable: true,
//               locationButtonEnable: false,
//               consumeSymbolTapEvents: false,
//               locale: const Locale('ko'),
//               logoClickEnable: false,
//               // initialCameraPosition: NCameraPosition(
//               //   target: NLatLng(
//               //   _currentPosition.latitude,
//               //   _currentPosition.longitude),
//               //   zoom: 10,
//               //   bearing: 0,
//               //   tilt: 0,
//               // ),
//             ),
//             onMapReady: (controller) async {
//               _mapController = controller;
//               _mapControllerCompleter.complete(controller);

//               final markerImage =
//                   await NOverlayImage.fromAssetImage(Images.marker);

//               final marker = NMarker(
//                   id: '1',
//                   position: NLatLng(37.5666, 126.979),
//                   icon: markerImage);

//               _mapController.addOverlay(marker);
//             },
//           );
//         }
//       },
//     );
//   }

//   Future<Position> getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     return position;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: const LocationAppBarWidget(
//           title: Strings.findCurrentLocationMap,
//           backIcon: Icons.arrow_back_ios,
//         ),
//         body: _loadNaverMap());
//   }
// }
