class WeatherModel {
  int statusCode;
  String message;
  List<WeatherData> data;

  WeatherModel(
      {required this.statusCode, required this.message, required this.data});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List)
          .map((item) => WeatherData.fromJson(item))
          .toList(),
    );
  }
}

class WeatherData {
  String weatherCode;
  String weatherName;
  int count;

  WeatherData(
      {required this.weatherCode,
      required this.weatherName,
      required this.count});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      weatherCode: json['weatherCode'] ?? '',
      weatherName: json['weatherName'] ?? '',
      count: json['count'] ?? '',
    );
  }
}
