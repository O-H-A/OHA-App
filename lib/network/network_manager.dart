import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../utils/secret_key.dart';
import 'api_response.dart';

class NetworkManager {
  Map<String, String> commonHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "AUTHORIZATION": SecretKey.kakaoJWTKey,
  };

  static final NetworkManager _instance = NetworkManager._internal();

  NetworkManager._internal();

  static NetworkManager get instance => _instance;

  Future<dynamic> get(String serverUrl) async {
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
        headers: commonHeaders,
      );

      responseJson = returnResponse(response);

      responseJson = utf8.decode(response.bodyBytes);

      print("GET 성공: ${responseJson}");

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> getWithQuery(
      String serverUrl, Map<String, dynamic> queryParams) async {
    dynamic responseJson;

    try {
      final Uri uri =
          Uri.parse(serverUrl).replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: commonHeaders,
      );

      responseJson = returnResponse(response);

      responseJson = utf8.decode(response.bodyBytes);

      print("GET with Query 성공: ${responseJson}");

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> post(String serverUrl, Map<String, dynamic> userData) async {
    try {
      String jsonData = jsonEncode(userData);
      dynamic responseJson;

      final response = await http.post(
        Uri.parse(serverUrl),
        headers: commonHeaders,
        body: jsonData,
      );

      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("POST 성공: ${response.body}");
      } else {
        print("POST 실패: ${response.statusCode}    ${responseJson}");
      }

      return response;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> delete(
      String serverUrl, Map<String, dynamic> userData) async {
    dynamic responseJson;

    try {
      String jsonData = jsonEncode(userData);

      final response = await http.delete(
        Uri.parse(serverUrl),
        headers: commonHeaders,
        body: jsonData,
      );

      responseJson = returnResponse(response);

      responseJson = utf8.decode(response.bodyBytes);

      print("DELETE 성공: ${responseJson}");

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<http.Response> imagePut(String serverUrl, XFile? imageFile) async {
    try {
      if (imageFile == null) {
        return http.Response('No image file provided', 400);
      }

      List<int> imageBytes = await imageFile.readAsBytes();
      final response = await http.put(
        Uri.parse(serverUrl),
        headers: commonHeaders,
        body: imageBytes,
      );

      if (response.statusCode == 200) {
        print("Image uploaded successfully: ${response.body}");
      } else {
        print("Failed to upload image: ${response.statusCode}");
      }

      return response;
    } catch (e) {
      print("An error occurred while uploading the image: $e");
      throw e;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 0:
      case 200:
        return response.body;
      default:
        return ApiResponse.error;
    }
  }
}
