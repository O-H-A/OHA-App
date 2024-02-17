class LogoutModel {
  int statusCode;
  String message;

  LogoutModel({required this.statusCode, required this.message});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
    );
  }
}
