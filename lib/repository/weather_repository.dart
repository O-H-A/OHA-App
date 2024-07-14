import 'dart:convert';

import 'package:oha/models/weather/default_weather_model.dart';
import 'package:oha/models/weather/delete_weather_model.dart';
import 'package:oha/models/weather/weather_model.dart';

import '../models/weather/add_weather_model.dart';
import '../models/weather/edit_weather_model.dart';
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

  Future<AddWeatherModel> addWeatherPosting(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.weather, data);
      return AddWeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<EditWeatherModel> editWeatherPosting(
      Map<String, dynamic> queryParams) async {
    try {
      final response =
          await NetworkManager.instance.put(ApiUrl.weather, queryParams);
      return EditWeatherModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }

  Future<PostingWeatherMyModel> getWeatherPostingMy() async {
    try {
      dynamic response =
          await NetworkManager.instance.get(ApiUrl.weatherPostingMy);
      return PostingWeatherMyModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<DeleteWeatherModel> deleteMyWeather(
      Map<String, dynamic> queryParams) async {
    try {
      dynamic response =
          await NetworkManager.instance.delete(ApiUrl.weather, queryParams);
      return DeleteWeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<DefaultWeatherModel> defaultWeather() async {
    try {
      dynamic response =  
          await NetworkManager.instance.get(ApiUrl.defaultWeather);
      return DefaultWeatherModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
