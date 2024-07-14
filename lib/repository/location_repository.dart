import 'dart:convert';

import 'package:oha/models/location/all_location_model.dart';
import '../models/location/change_frequent_location_model.dart';
import '../models/location/frequent_location_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class LocationRepository {
  Future<AllLocationModel> getAllDistricts() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.allDistricts);
      return AllLocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<FrequentLocationModel> addFrequentlyDistricts(
      Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.freqDisrict, data);
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

  Future<FrequentLocationModel> deleteFrequentlyDistricts(
      Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.delete(ApiUrl.freqDisrict, data);
      return FrequentLocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

Future<ChangeFrequentLocationModel> changeDefaultFrequentlyDistricts(
    Map<String, dynamic> data) async {
  try {
    final response = await NetworkManager.instance.put(ApiUrl.locationDefault, data);
    return ChangeFrequentLocationModel.fromJson(jsonDecode(response.body));
  } catch (e) {
    rethrow;
  }
}


  Future<FrequentLocationModel> getDefaultFrequentlyDistricts() async {
    try {
      dynamic response =
          await NetworkManager.instance.get(ApiUrl.locationDefault);
      return FrequentLocationModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
