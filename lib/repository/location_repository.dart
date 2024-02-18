import 'dart:convert';

import 'package:oha/models/location/location_model.dart';
import '../models/location/frequent_location_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class LocationRepository {
  Future<LocationModel> getAllDistricts() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.allDistricts);
      return LocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<FrequentLocationModel> addFrequentlyDistricts(Map<String, dynamic> data) async {
    try {
      dynamic response = await NetworkManager.instance.post(ApiUrl.freqDisrict, data);
      return FrequentLocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

    Future<FrequentLocationModel> getFrequentlyDistricts() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.freqDisrict);
      return FrequentLocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
