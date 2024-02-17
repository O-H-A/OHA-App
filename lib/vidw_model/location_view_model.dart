import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/network/api_response.dart';

import '../repository/location_repository.dart';

class LocationViewModel with ChangeNotifier {
  final _locationRepository = LocationRepository();

  ApiResponse<LocationViewModel> _locationData = ApiResponse.loading();

  void setLocationData(ApiResponse<LocationViewModel> response) {
    _locationData = response;
  }

  Future<int> fetchAllDistricts() async {
    int statusCode = 40;
    await _locationRepository.getAllDistricts().then((value) {
      //setLocationData(ApiResponse.complete(value));
      print("Jehee : ${value}");
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      setLocationData(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }
}
