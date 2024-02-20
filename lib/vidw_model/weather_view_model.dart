import 'package:flutter/cupertino.dart';
import 'package:oha/models/weather/weather_model.dart';

import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel with ChangeNotifier {
  final _weatherRepository = WeatherRepository();

  ApiResponse<WeatherModel> _weatherCountData = ApiResponse.loading();

  setWeatherCount(ApiResponse<WeatherModel> response) {
    _weatherCountData = response;
  }

  Future<void> fetchWeatherCount(Map<String, dynamic> queryParams) async {
    await _weatherRepository.getWeatherCount(queryParams).then((value) {
      setWeatherCount(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setWeatherCount(ApiResponse.error(error.toString()));
    });
  }
}
