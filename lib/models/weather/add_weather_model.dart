class AppWeatherModel {
  int statusCode;
  String message;
  AddWeatherDataModel data;

  AppWeatherModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AppWeatherModel.fromJson(Map<String, dynamic> json) {
    return AppWeatherModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: AddWeatherDataModel.fromJson(json['data']),
    );
  }
}


class AddWeatherDataModel {
  int weatherId;

  AddWeatherDataModel({
    required this.weatherId,
  });

  factory AddWeatherDataModel.fromJson(Map<String, dynamic> json) {
    return AddWeatherDataModel(
      weatherId: json['weatherId'] ?? 0,
    );
  }
}
