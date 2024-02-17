import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/network/api_response.dart';

import '../models/location/location_model.dart';
import '../repository/location_repository.dart';

class LocationViewModel with ChangeNotifier {
  final _locationRepository = LocationRepository();

  ApiResponse<LocationModel> _locationData = ApiResponse.loading();

  void setLocationData(ApiResponse<LocationModel> response) {
    _locationData = response;

    notifyListeners();
  }

  ApiResponse<LocationModel> get getLocationData => _locationData;

  Future<int> fetchAllDistricts() async {
    int statusCode = 400;
    await _locationRepository.getAllDistricts().then((value) {
      setLocationData(ApiResponse.complete(value));
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {  
      setLocationData(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }
}
