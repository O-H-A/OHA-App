import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/models/login_model.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/repository/login_repository.dart';

class LoginViewModel with ChangeNotifier {
  final _loginRepository = LoginRepository();

  ApiResponse<LoginModel> _loginData = ApiResponse.loading();

  ApiResponse<LoginModel> get loginData => _loginData;

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
}
