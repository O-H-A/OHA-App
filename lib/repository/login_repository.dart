import 'dart:convert';

import '../models/login/login_model.dart';
import '../models/login/logout_model.dart';
import '../models/login/refresh_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class LoginRepository {
  Future<LoginModel> getKakaoLoginData() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.kakaoLogin);
      return LoginModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<LogoutModel> logout() async {
    try {
      final response = await NetworkManager.instance.post(ApiUrl.logout, {});
      final responseBody = jsonDecode(response.body);
      return LogoutModel.fromJson(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  Future<LogoutModel> termsAgree() async {
    try {
      dynamic response =
          await NetworkManager.instance.put(ApiUrl.termsAgree, {});
      return LogoutModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

    Future<RefreshModel> refresh() async {
    try {
      dynamic response =
          await NetworkManager.instance.refresh(ApiUrl.refresh);
      return RefreshModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
