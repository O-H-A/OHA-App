import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:oha/repository/upload_repository.dart';
import '../models/upload/upload_get_model.dart';
import '../models/upload/upload_like_model.dart';
import '../network/api_response.dart';

class UploadViewModel with ChangeNotifier {
  UploadRepository _uploadRepository = UploadRepository();

  List<String> _keywordList = [];
  String _uploadLocation = "";

  List<String> get getKetwordList => _keywordList;
  String get getUploadLocation => _uploadLocation;

  ApiResponse<UploadGetModel> uploadGetData = ApiResponse.loading();

  ApiResponse<UploadLikeModel> likeData = ApiResponse.loading();

  void setUploadKeywordList(String keyword) {
    _keywordList.add(keyword);
    notifyListeners();
  }

  void setUploadLocation(String location) {
    _uploadLocation = location;
    notifyListeners();
  }

  void _setUploadGetData(ApiResponse<UploadGetModel> response, {bool append = false}) {
    if (append && response.status == Status.complete && uploadGetData.status == Status.complete) {
      uploadGetData.data?.data.addAll(response.data?.data ?? []);
    } else {
      uploadGetData = response;
    }
    notifyListeners();
  }

  void _setLikeData(ApiResponse<UploadLikeModel> response) {
    likeData = response;
    notifyListeners();
  }

  Future<int> posting(Map<String, dynamic> data, Uint8List? thumbnailData) async {
    final result = await _uploadRepository.posting(data, thumbnailData);

    return result.statusCode;
  }

  Future<int> posts(Map<String, dynamic> queryParams, {bool append = false}) async {
    int statusCode = 400;
    await _uploadRepository.posts(queryParams).then((value) {
      _setUploadGetData(ApiResponse.complete(value), append: append);
      statusCode = value.statusCode;
    }).onError((error, stackTrace) {
      _setUploadGetData(ApiResponse.error(error.toString()));
      statusCode = 400;
    });
    return statusCode;
  }

  Future<int> like(Map<String, dynamic> data) async {
    final result = await _uploadRepository.like(data);
    _setLikeData(ApiResponse.complete(result));
    return result.statusCode;
  }

  Future<int> delete(String postId) async {
    final result = await _uploadRepository.delete(postId);

    if (result.statusCode == 200) {
      uploadGetData.data?.data.removeWhere((item) => item.postId == int.parse(postId));
      notifyListeners();
    }

    return result.statusCode;
  }
}
