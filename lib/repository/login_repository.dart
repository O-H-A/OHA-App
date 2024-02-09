import 'dart:convert';

import 'package:oha/models/login_model.dart';

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
}
