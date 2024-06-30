import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oha/models/login/with_draw_model.dart';

import 'package:oha/network/api_response.dart';
import 'package:oha/repository/login_repository.dart';

import '../models/login/login_model.dart';
import '../models/login/logout_model.dart';
import '../models/login/refresh_model.dart';

class LoginViewModel with ChangeNotifier {
  final _loginRepository = LoginRepository();

  ApiResponse<LoginModel> _loginData = ApiResponse.loading();

  ApiResponse<LoginModel> get loginData => _loginData;

  ApiResponse<LogoutModel> _logoutData = ApiResponse.loading();

  ApiResponse<RefreshModel> _refreshData = ApiResponse.loading();

  ApiResponse<RefreshModel> get refreshData => _refreshData;

  ApiResponse<WithDrawModel> withDrawData = ApiResponse.loading();

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

  void setRefresh(ApiResponse<RefreshModel> response) {
    _refreshData = response;
  }

  void setWithDraw(ApiResponse<WithDrawModel> response) {
    withDrawData = response;
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

  Future<int> refresh() async {
    final result = await _loginRepository.refresh();

    if (result.statusCode == 200) {
      setRefresh(ApiResponse.complete(result));
    } else {
      setRefresh(ApiResponse.error());
    }

    return result.statusCode;
  }

  Future<void> withDraw() async {
    await _loginRepository.withDraw().then((value) {
      setWithDraw(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setWithDraw(ApiResponse.error(error.toString()));
    });
  }
}
