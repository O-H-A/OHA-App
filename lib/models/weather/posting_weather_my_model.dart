class PostingWeatherMyModel {
  int statusCode;
  String message;
  List<PostingWeatherData> data;

  PostingWeatherMyModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PostingWeatherMyModel.fromJson(Map<String, dynamic> json) {
    var dataList = (json['data'] as List).map((item) => PostingWeatherData.fromJson(item)).toList();
    return PostingWeatherMyModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: dataList,
    );
  }
}


class PostingWeatherData {
  int weatherId;
  int userId;
  int regionCode;
  String weatherCode;
  String weatherName;
  int dayParts;
  String weatherDt;

  PostingWeatherData({
    required this.weatherId,
    required this.userId,
    required this.regionCode,
    required this.weatherCode,
    required this.weatherName,
    required this.dayParts,
    required this.weatherDt,
  });

  factory PostingWeatherData.fromJson(Map<String, dynamic> json) {
    return PostingWeatherData(
      weatherId: json['weatherId'] ?? 0,
      userId: json['userId'] ?? 0,
      regionCode: json['regionCode'] ?? 0,
      weatherCode: json['weatherCode'] ?? '',
      weatherName: json['weatherName'] ?? '',
      dayParts: json['dayParts'] ?? 0,
      weatherDt: json['weatherDt'] ?? '',
    );
  }
}
