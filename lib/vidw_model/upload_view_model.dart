import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oha/repository/upload_repository.dart';

import '../network/api_response.dart';

class UploadViewModel with ChangeNotifier {
  UploadRepository _uploadRepository = UploadRepository();

  List<String> _keywordList = [];
  String _uploadLocation = "";

  List<String> get getKetwordList => _keywordList;
  String get getUploadLocation => _uploadLocation;

  void setUploadKeywordList(String keyword) {
    _keywordList.add(keyword);

    notifyListeners();
  }

  void setUploadLocation(String location) {
    _uploadLocation = location;

    notifyListeners();
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
}
