import 'package:flutter/material.dart';

class UploadViewModel with ChangeNotifier {

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
}