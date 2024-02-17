import 'dart:convert';

import '../models/login/login_model.dart';

import '../network/api_url.dart';
import '../network/network_manager.dart';

class LocationRepository {
  Future<LoginModel> getAllDistricts() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.allDistricts);
      return LoginModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
