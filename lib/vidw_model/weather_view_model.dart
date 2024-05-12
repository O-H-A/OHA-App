import 'package:flutter/cupertino.dart';
import 'package:oha/models/weather/weather_model.dart';

import '../models/weather/posting_weather_my_model.dart';
import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel with ChangeNotifier {
  final _weatherRepository = WeatherRepository();

  ApiResponse<WeatherModel> _weatherCountData = ApiResponse.loading();
  ApiResponse<PostingWeatherMyModel> _weatherPostingMy = ApiResponse.loading();

  List<WeatherData> get topThreeWeatherData => _weatherCountData.data?.data ?? [];

  setWeatherCount(ApiResponse<WeatherModel> response) {
    _weatherCountData = response;
  }

  setWeatherPostingMy(ApiResponse<PostingWeatherMyModel> response) {
    _weatherPostingMy = response;

    notifyListeners();
  }

  Future<void> fetchWeatherCount(Map<String, dynamic> queryParams) async {
    await _weatherRepository.getWeatherCount(queryParams).then((value) {
      var sortedData = List<WeatherData>.from(value.data)
        ..sort((a, b) => b.count.compareTo(a.count));
      var topThreeData = sortedData.take(3).toList();

      var filteredWeather = WeatherModel(
        statusCode: value.statusCode,
        message: value.message,
        data: topThreeData
      );
      
      setWeatherCount(ApiResponse.complete(filteredWeather));
    }).onError((error, stackTrace) {
      setWeatherCount(ApiResponse.error(error.toString()));
    });
  }

  Future<int> addWeatherPosting(Map<String, dynamic> data) async {
    await _weatherRepository.addWeatherPosting(data).then((value) {
      return value.statusCode;
      //setFrequentLocationData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      //setFrequentLocationData(ApiResponse.error(error.toString()));
      return 400;
    });

    return 400;
  }

  Future<void> fetchWeatherPostingMy(Map<String, dynamic> queryParams) async {
    await _weatherRepository.getWeatherPostingMy(queryParams).then((value) {
      setWeatherPostingMy(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setWeatherPostingMy(ApiResponse.error(error.toString()));
    });
  }
}
