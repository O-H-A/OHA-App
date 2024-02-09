import 'package:oha/models/login_data.dart';

class LoginModel {
  int statusCode;
  String message;
  LoginData data;

  LoginModel(
      {required this.statusCode, required this.message, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: LoginData.fromJson(json['data'] ?? {}),
    );
  }
}
