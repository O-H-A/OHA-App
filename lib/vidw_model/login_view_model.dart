import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:oha/network/api_response.dart';
import 'package:oha/repository/login_repository.dart';

import '../models/login/login_model.dart';
import '../models/login/logout_model.dart';

class LoginViewModel with ChangeNotifier {
  final _loginRepository = LoginRepository();

  ApiResponse<LoginModel> _loginData = ApiResponse.loading();

  ApiResponse<LoginModel> get loginData => _loginData;

  ApiResponse<LogoutModel> _logoutData = ApiResponse.loading();

  void setLoginData(String responseJson) {
    try {
      Map<String, dynamic> jsonResult = json.decode(responseJson);
      LoginModel loginModel = LoginModel.fromJson(jsonResult);

      _loginData = ApiResponse.complete(loginModel);

      notifyListeners();
    } catch (e) {
      print("JSON 디코딩 또는 accessToken에 접근 중 오류 발생: $e");
    }
  }

  void setLogout(ApiResponse<LogoutModel> response) {
    _logoutData = response;

    notifyListeners();
  }

  Future<int> logout() async {
    int statusCode = 40;
    await _loginRepository.logout().then((value) {
      setLogout(ApiResponse.complete(value));
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      setLogout(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }

  Future<int> termsAgree() async {
    int statusCode = 400;
    await _loginRepository.termsAgree().then((value) {
      setLogout(ApiResponse.complete(value));
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      setLogout(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }
}
