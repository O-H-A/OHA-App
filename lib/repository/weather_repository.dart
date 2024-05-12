import 'dart:convert';

import 'package:oha/models/weather/weather_model.dart';

import '../models/weather/posting_weather_my_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class WeatherRepository {
  Future<WeatherModel> getWeatherCount(Map<String, dynamic> queryParams) async {
    try {
      dynamic response = await NetworkManager.instance
          .getWithQuery(ApiUrl.weatherCount, queryParams);
      return WeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<WeatherModel> addWeatherPosting(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.weather, data);
      return WeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<PostingWeatherMyModel> getWeatherPostingMy() async {
    try {
      dynamic response = await NetworkManager.instance
          .get(ApiUrl.weatherPostingMy);
      return PostingWeatherMyModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
