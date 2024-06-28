class DefaultWeatherModel {
  int statusCode;
  String message;
  DefaultWetherData data;

  DefaultWeatherModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DefaultWeatherModel.fromJson(Map<String, dynamic> json) {
    return DefaultWeatherModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: DefaultWetherData.fromJson(json['data']),
    );
  }
}

class DefaultWetherData {
  String widget;
  String probPrecip;
  bool isTempDiffHigh;
  String hourlyTemp;

  DefaultWetherData({
    required this.widget,
    required this.probPrecip,
    required this.isTempDiffHigh,
    required this.hourlyTemp,
  });

  factory DefaultWetherData.fromJson(Map<String, dynamic> json) {
    return DefaultWetherData(
      widget: json['widget'] ?? '',
      probPrecip: json['probPrecip'] ?? '',
      isTempDiffHigh: json['isTempDiffHigh'] ?? false,
      hourlyTemp: json['hourlyTemp'] ?? '',
    );
  }
}
