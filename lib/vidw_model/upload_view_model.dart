import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oha/repository/upload_repository.dart';

import '../models/upload/upload_get_model.dart';
import '../network/api_response.dart';

class UploadViewModel with ChangeNotifier {
  UploadRepository _uploadRepository = UploadRepository();

  List<String> _keywordList = [];
  String _uploadLocation = "";

  List<String> get getKetwordList => _keywordList;
  String get getUploadLocation => _uploadLocation;

  ApiResponse<UploadGetModel> uploadGetData = ApiResponse.loading();

  void setUploadKeywordList(String keyword) {
    _keywordList.add(keyword);

    notifyListeners();
  }

  void setUploadLocation(String location) {
    _uploadLocation = location;

    notifyListeners();
  }

  void _setUploadGetData(ApiResponse<UploadGetModel> response) {
      uploadGetData = response;
  }

  Future<int> posting(
      Map<String, dynamic> data, Uint8List? thumbnailData) async {
    await _uploadRepository.posting(data, thumbnailData).then((value) {
      return value.statusCode;
      //setFrequentLocationData(ApiResponse.complete(value));
    }).onError((error, stackTrace) {
      //setFrequentLocationData(ApiResponse.error(error.toString()));
      return 400;
    });

    return 400;
  }

  Future<int> posts(Map<String, dynamic> queryParams) async {
    int statusCode = 400;
    await _uploadRepository.posts(queryParams).then((value) {
      _setUploadGetData(ApiResponse.complete(value));
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      _setUploadGetData(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }
}
