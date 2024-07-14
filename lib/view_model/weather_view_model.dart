import 'package:flutter/cupertino.dart';
import 'package:oha/models/weather/default_weather_model.dart';
import 'package:oha/models/weather/weather_model.dart';
import '../models/weather/posting_weather_my_model.dart';
import '../network/api_response.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel with ChangeNotifier {
  final _weatherRepository = WeatherRepository();

  ApiResponse<WeatherModel> _weatherCountData = ApiResponse.loading();
  ApiResponse<PostingWeatherMyModel> _weatherPostingMy = ApiResponse.loading();
  ApiResponse<DefaultWeatherModel> _defaultWeatherData = ApiResponse.loading();

  ApiResponse<WeatherModel> get weatherCountData => _weatherCountData;

  ApiResponse<DefaultWeatherModel> get defaultWeatherData => _defaultWeatherData;

  List<WeatherData> get topThreeWeatherData =>
      _weatherCountData.data?.data ?? [];
  ApiResponse<PostingWeatherMyModel> get getWeatherPostingMy =>
      _weatherPostingMy;

  setWeatherCount(ApiResponse<WeatherModel> response) {
    _weatherCountData = response;
    notifyListeners();
  }

  setWeatherPostingMy(ApiResponse<PostingWeatherMyModel> response) {
    _weatherPostingMy = response;
    notifyListeners();
  }

  setDefaultWeatherData(ApiResponse<DefaultWeatherModel> response) {
    _defaultWeatherData = response;
    notifyListeners();
  }

  Future<void> fetchWeatherCount(Map<String, dynamic> queryParams) async {
    await _weatherRepository.getWeatherCount(queryParams).then((value) {
      var sortedData = List<WeatherData>.from(value.data)
        ..sort((a, b) => b.count.compareTo(a.count));
      var filteredData = sortedData.where((item) => item.count > 0).toList();
      var topThreeData = filteredData.take(3).toList();

      var filteredWeather = WeatherModel(
          statusCode: value.statusCode,
          message: value.message,
          data: topThreeData);
      setWeatherCount(ApiResponse.complete(filteredWeather));
    }).onError((error, stackTrace) {
      setWeatherCount(ApiResponse.error(error.toString()));
    });
  }

  Future<int> addWeatherPosting(Map<String, dynamic> data) async {
    try {
      final value = await _weatherRepository.addWeatherPosting(data);
      return value.statusCode;
    } catch (error) {
      return 400;
    }
  }

  Future<int> editWeatherPosting(Map<String, dynamic> queryParams) async {
    try {
      final value = await _weatherRepository.editWeatherPosting(queryParams);
      return value.statusCode;
    } catch (error) {
      return 400;
    }
  }

  Future<void> fetchWeatherPostingMy() async {
    await _weatherRepository.getWeatherPostingMy().then((value) {
      setWeatherPostingMy(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      setWeatherPostingMy(ApiResponse.error(error.toString()));
    });
  }

  Future<int> deleteMyWeather(Map<String, dynamic> queryParams) async {
    try {
      final value = await _weatherRepository.deleteMyWeather(queryParams);
      return value.statusCode;
    } catch (error) {
      return 400;
    }
  }

  Future<int> getDefaultWeather() async {
    try {
      final value = await _weatherRepository.defaultWeather();
      setDefaultWeatherData(ApiResponse.complete(value));
      return value.statusCode;
    } catch (error) {
      return 400;
    }
  }
}
