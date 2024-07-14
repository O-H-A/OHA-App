class AddWeatherModel {
  int statusCode;
  String message;
  AddWeatherDataModel? data;

  AddWeatherModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory AddWeatherModel.fromJson(Map<String, dynamic> json) {
    return AddWeatherModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? AddWeatherDataModel.fromJson(json['data']) : null, 
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
