import 'package:flutter/material.dart';
import 'package:oha/models/diary/my_diary_model.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/repository/diary_repository.dart';
class DiaryViewModel with ChangeNotifier {
  final _diaryRepository = DiaryRepository();

  ApiResponse<MyDiaryModel> _myDiary = ApiResponse.loading();
  List<MyDiary> diaryEntries = [];

  ApiResponse<MyDiaryModel> get myDiary => _myDiary;

  void setMyDiary(ApiResponse<MyDiaryModel> response) {
    _myDiary = response;
    if (response.status == Status.complete) {
      diaryEntries = response.data?.data?.diaries ?? [];
    }
    notifyListeners();
  }

  Future<int> fetchMyDiary() async {
    final result = await _diaryRepository.getMyDiary();
    
    if(result.statusCode == 200) {
      setMyDiary(ApiResponse.complete(result));
    }
    else {
      setMyDiary(ApiResponse.error());
    }

    return result.statusCode;
  }
}