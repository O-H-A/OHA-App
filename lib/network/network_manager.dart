import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import '../statics/strings.dart';
import '../utils/secret_key.dart';
import 'api_response.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class NetworkManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, String>> get commonHeaders async {
    String? accessToken = await _storage.read(key: Strings.accessTokenKey);
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken"
    };
  }

  Future<Map<String, String>> get refreshHeaders async {
    String? refreshToken = await _storage.read(key: Strings.refreshTokenKey);
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $refreshToken"
    };
  }

  static final NetworkManager _instance = NetworkManager._internal();

  NetworkManager._internal();

  static NetworkManager get instance => _instance;

  Future<dynamic> get(String serverUrl) async {
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
        headers: await commonHeaders,
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
        headers: await commonHeaders,
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
        headers: await commonHeaders,
        body: jsonData,
      );

      responseJson = returnResponse(response);

      responseJson = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        print("POST 성공: ${response.body}");
      } else {
        print("POST 실패: ${response.statusCode}    ${responseJson}");
      }

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> refresh(String serverUrl) async {
    dynamic responseJson;

    try {
      final response = await http.get(
        Uri.parse(serverUrl),
        headers: await refreshHeaders,
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

  Future<dynamic> imagePost(String serverUrl, Map<String, dynamic> userData,
      Uint8List? thumbnailData) async {
    Map<String, dynamic> sendData = userData;

    var dio = Dio();

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromBytes(
        thumbnailData!,
        filename: 'file.jpeg',
        contentType: MediaType('application', 'octet-stream'),
      ),
      "dto": MultipartFile.fromString(
        jsonEncode(sendData),
        contentType: MediaType('application', 'json'),
      ),
    });

    try {
      Response response = await dio.post(
        serverUrl,
        data: formData,
        options: Options(
          headers: await commonHeaders,
        ),
      );

      if (response.statusCode == 200) {
        print('Image upload successful');
      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }

      return response.data;
    } catch (error) {
      print('Error uploading: $error');
      throw error;
    }
  }

  Future<dynamic> imagePatch(String serverUrl, Map<String, dynamic> userData,
      Uint8List? thumbnailData) async {
    Map<String, dynamic> sendData = userData;

    var dio = Dio();

    FormData formData = FormData.fromMap({
      "files": await MultipartFile.fromBytes(
        thumbnailData!,
        filename: 'files.png',
        contentType: MediaType('application', 'octet-stream'),
      ),
      "dto": MultipartFile.fromString(
        jsonEncode(sendData),
        contentType: MediaType('application', 'json'),
      ),
    });

    try {
      Response response = await dio.patch(
        serverUrl,
        data: formData,
        options: Options(
          headers: await commonHeaders,
        ),
      );

      if (response.statusCode == 200) {
        print('Image patch successful');
      } else {
        print('Image patch failed with status: ${response.statusCode}');
      }

      return response.data;
    } catch (error) {
      print('Error patching: $error');
      throw error;
    }
  }

  Future<dynamic> put(String serverUrl, Map<String, dynamic> userData) async {
    try {
      String jsonData = jsonEncode(userData);
      dynamic responseJson;

      final response = await http.put(
        Uri.parse(serverUrl),
        headers: await commonHeaders,
        body: jsonData,
      );

      responseJson = returnResponse(response);

      if (response.statusCode == 200) {
        print("PUT 성공: ${response.body}");
      } else {
        print("PUT 실패: ${response.statusCode}    ${responseJson}");
      }

      return response;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> imagePut(String serverUrl, Map<String, dynamic> userData,
      Uint8List? fileData) async {
    Map<String, dynamic> sendData = userData;

    var dio = Dio();

    FormData formData = FormData.fromMap({
      "profileImage": await MultipartFile.fromBytes(
        fileData!,
        filename: 'profileImage.png',
        contentType: MediaType('application', 'octet-stream'),
      ),
      "dto": MultipartFile.fromString(
        jsonEncode(sendData),
        contentType: MediaType('application', 'json'),
      ),
    });

    try {
      Response response = await dio.put(
        serverUrl,
        data: formData,
        options: Options(
          headers: await commonHeaders,
        ),
      );

      if (response.statusCode == 200) {
        print('Multipart PUT successful');
      } else {
        print('Multipart PUT failed with status: ${response.statusCode}');
      }

      return response.data;
    } catch (error) {
      print('Error in multipart PUT: $error');
      throw error;
    }
  }

  Future<dynamic> delete(String serverUrl,
      [Map<String, dynamic>? userData]) async {
    dynamic responseJson;

    try {
      String jsonData = jsonEncode(userData ?? {});

      final response = await http.delete(
        Uri.parse(serverUrl),
        headers: await commonHeaders,
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

  Future<dynamic> postDelete(String serverUrl, String postId) async {
    dynamic responseJson;

    try {
      final uri = Uri.parse('$serverUrl/$postId');

      final response = await http.delete(
        uri,
        headers: await commonHeaders,
      );

      responseJson = returnResponse(response);

      print("DELETE 성공: ${responseJson}");

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  Future<dynamic> deleteWeather(
      String serverUrl, Map<String, dynamic> data) async {
    dynamic responseJson;

    try {
      final uri = Uri.parse('$serverUrl/${data['weatherId']}');
      data.remove('weatherId');
      String jsonData = jsonEncode(data);

      final response = await http.delete(
        uri,
        headers: await commonHeaders,
        body: jsonData,
      );

      responseJson = returnResponse(response);
      responseJson = utf8.decode(response.bodyBytes);

      print("DELETE with Path and Body 성공: ${responseJson}");

      return responseJson;
    } catch (error) {
      print("에러 발생: $error");
      return "";
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 0:
      case 200:
      case 201:
      case 400:
      case 404:
        return response.body;
      default:
        return ApiResponse.error;
    }
  }
}
