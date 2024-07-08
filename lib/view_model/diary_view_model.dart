import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:oha/models/diary/diary_write_model.dart';
import 'package:oha/models/diary/my_diary_model.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/repository/diary_repository.dart';

class DiaryViewModel with ChangeNotifier {
  final _diaryRepository = DiaryRepository();

  ApiResponse<MyDiaryModel> _myDiary = ApiResponse.loading();
  List<MyDiary> diaryEntries = [];

  ApiResponse<MyDiaryModel> get getMyDiary => _myDiary;

  ApiResponse<DiaryWriteModel> diaryData = ApiResponse.loading();

  void setMyDiary(ApiResponse<MyDiaryModel> response) {
    _myDiary = response;
    if (response.status == Status.complete) {
      diaryEntries = response.data?.data?.diaries ?? [];
    }
    notifyListeners();
  }

  void setDiary(ApiResponse<DiaryWriteModel> response) {
    diaryData = response;

    notifyListeners();
  }

  Future<int> fetchMyDiary() async {
    final result = await _diaryRepository.getMyDiary();

    if (result.statusCode == 200) {
      setMyDiary(ApiResponse.complete(result));
    } else {
      setMyDiary(ApiResponse.error());
    }

    return result.statusCode;
  }

  List<MyDiary> getDiariesByDate(DateTime date) {
    return diaryEntries.where((diary) {
      final diaryDate = DateTime.parse(diary.setDate);
      return diaryDate.year == date.year &&
          diaryDate.month == date.month &&
          diaryDate.day == date.day;
    }).toList();
  }

  Future<void> diaryWrite(Map<String, dynamic> data, Uint8List? thumbnailData) async {
    final result = await _diaryRepository.diaryWrite(data, thumbnailData);

    if (result.statusCode == 200) {
      setDiary(ApiResponse.complete(result));
    } else {
      setDiary(ApiResponse.error());
    }
  }
}
