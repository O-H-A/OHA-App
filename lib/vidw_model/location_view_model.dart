import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/models/location/frequent_location_model.dart';
import 'package:oha/network/api_response.dart';

import '../models/location/all_location_model.dart';
import '../repository/location_repository.dart';

class LocationViewModel with ChangeNotifier {
  final _locationRepository = LocationRepository();

  ApiResponse<AllLocationModel> _allLocationData = ApiResponse.loading();
  ApiResponse<FrequentLocationModel> _frequentLocationData =
      ApiResponse.loading();

  ApiResponse<AllLocationModel> get getLocationData => _allLocationData;
  ApiResponse<FrequentLocationModel> get getFrequentLocationData =>
      _frequentLocationData;

  String _defaultLocation = "";

  void setLocationData(ApiResponse<AllLocationModel> response) {
    _allLocationData = response;

    notifyListeners();
  }

  void setFrequentLocationData(ApiResponse<FrequentLocationModel> response) {
    _frequentLocationData = response;

    notifyListeners();
  }

  int getFrequentLength() {
    return _frequentLocationData.data?.data.length ?? 0;
  }

  List<String> getFrequentRegionCode() {
    int length = _frequentLocationData.data?.data.length ?? 0;
    List<String> list = List.generate(length, (index) => '');

    for (int i = 0; i < length; i++) {
      list[i] = _frequentLocationData.data?.data[i].code ?? "";
    }

    return list;
  }

  List<String> getFrequentFullAddress() {
    int length = _frequentLocationData.data?.data.length ?? 0;
    List<String> list = List.generate(length, (index) => '');

    String firstAddress = "";
    String secondAddress = "";
    String thirdAddress = "";

    for (int i = 0; i < length; i++) {
      firstAddress = _frequentLocationData.data?.data[i].firstAddress ?? "";
      secondAddress = _frequentLocationData.data?.data[i].secondAddress ?? "";
      thirdAddress = _frequentLocationData.data?.data[i].thirdAddress ?? "";

      list[i] = "$firstAddress $secondAddress $thirdAddress";
    }

    return list;
  }

  List<String> getFrequentThirdAddress() {
    int length = _frequentLocationData.data?.data.length ?? 0;
    List<String> list = List.generate(length, (index) => '');

    for (int i = 0; i < length; i++) {
      list[i] = _frequentLocationData.data?.data[i].thirdAddress ?? "";
    }

    return list;
  }

  String getCodeByAddress(String address) {
    final addressParts = address.split(' ');
    if (addressParts.length != 3) {
      return "";
    }

    final province = addressParts[0];
    final city = addressParts[1];
    final district = addressParts[2]; 

    try {
      final cities = _allLocationData.data?.data.locations[province];
      if (cities != null) {
        final districts = cities[city];
        if (districts != null) {
          for (var location in districts) {
            if (location.address == district) {
              return location.code;
            }
          }
        }
      }
    } catch (e) {
      return "";
    }
    return "";
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

  Future<void> changeDefaultFrequentDistricts(Map<String, dynamic> data) async {
    await _locationRepository
        .changeDefaultFrequentlyDistricts(data)
        .then((value) {})
        .onError((error, stackTrace) {});
  }

  Future<void> getDefaultFrequentDistricts() async {
    await _locationRepository.getDefaultFrequentlyDistricts().then((value) {
      setDefaultLocation(value.data[0].thirdAddress);
    }).onError((error, stackTrace) {});
  }

  void setDefaultLocation(String location) {
    _defaultLocation = location;

    notifyListeners();
  }

  String get getDefaultLocation => _defaultLocation;
}
