import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/models/location/frequent_location_model.dart';
import 'package:oha/network/api_response.dart';

import '../models/location/location_model.dart';
import '../repository/location_repository.dart';

class LocationViewModel with ChangeNotifier {
  final _locationRepository = LocationRepository();

  ApiResponse<LocationModel> _locationData = ApiResponse.loading();
  ApiResponse<FrequentLocationModel> _frequentLocationData =
      ApiResponse.loading();

  ApiResponse<LocationModel> get getLocationData => _locationData;
  ApiResponse<FrequentLocationModel> get getFrequentLocationData =>
      _frequentLocationData;

  void setLocationData(ApiResponse<LocationModel> response) {
    _locationData = response;

    notifyListeners();
  }

  void setFrequentLocationData(ApiResponse<FrequentLocationModel> response) {
    _frequentLocationData = response;

    notifyListeners();
  }

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

  Future<void> addFrequentDistricts(Map<String, dynamic> data) async {
    await _locationRepository.addFrequentlyDistricts(data).then((value) {
      setFrequentLocationData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setFrequentLocationData(ApiResponse.error(error.toString()));
    });
  }

  Future<int> fetchFrequentDistricts() async {
    int statusCode = 400;
    await _locationRepository.getFrequentlyDistricts().then((value) {
      setFrequentLocationData(ApiResponse.complete(value));
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      setFrequentLocationData(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }

  Future<void> deleteFrequentDistricts(Map<String, dynamic> data) async {
    await _locationRepository.deleteFrequentlyDistricts(data).then((value) {
      setFrequentLocationData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setFrequentLocationData(ApiResponse.error(error.toString()));
    });
  }
}
