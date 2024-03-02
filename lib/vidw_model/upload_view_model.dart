import 'package:flutter/material.dart';

class UploadViewModel with ChangeNotifier {

  List<String> keywordList = [];

  List<String> get getKetwordList => keywordList;

  void setUploadKeywordList(String keyword) {
    keywordList.add(keyword);

    print("Jehee : ${keywordList}");

    notifyListeners();
  }
}