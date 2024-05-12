class DeleteWeatherModel {
  int statusCode;
  String message;
  Map<String, dynamic> data;

  DeleteWeatherModel(
      {required this.statusCode, required this.message, required this.data});

  factory DeleteWeatherModel.fromJson(Map<String, dynamic> json) {
    return DeleteWeatherModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? {},
    );
  }
}
