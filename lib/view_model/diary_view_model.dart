import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:oha/models/diary/diary_delete_model.dart';
import 'package:oha/models/diary/diary_update_model.dart';
import 'package:oha/models/diary/diary_write_model.dart';
import 'package:oha/models/diary/my_diary_model.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/repository/diary_repository.dart';

class DiaryViewModel with ChangeNotifier {
  final _diaryRepository = DiaryRepository();

  ApiResponse<MyDiaryModel> _myDiary = ApiResponse.loading();
  List<MyDiary> diaryEntries = [];
  ApiResponse<MyDiaryModel> _userDiary = ApiResponse.loading();

  ApiResponse<MyDiaryModel> get getMyDiary => _myDiary;

  ApiResponse<DiaryWriteModel> diaryData = ApiResponse.loading();
  ApiResponse<DiaryDeleteModel> diaryDeleteData = ApiResponse.loading();
  ApiResponse<DiaryUpdateModel> diaryUpdateData = ApiResponse.loading();

  void setMyDiary(ApiResponse<MyDiaryModel> response) {
    _myDiary = response;
    if (response.status == Status.complete) {
      diaryEntries = response.data?.data?.diaries ?? [];
    }

    notifyListeners();
  }

  void setUserDiary(ApiResponse<MyDiaryModel> response) {
    _userDiary = response;
    if (response.status == Status.complete) {
      diaryEntries = response.data?.data?.diaries ?? [];
    }

    notifyListeners();
  }

  void setDiary(ApiResponse<DiaryWriteModel> response) {
    diaryData = response;

    notifyListeners();
  }

  void setDiaryDelete(ApiResponse<DiaryDeleteModel> response) {
    diaryDeleteData = response;

    notifyListeners();
  }

  void setDiaryUpdate(ApiResponse<DiaryUpdateModel> response) {
    diaryUpdateData = response;

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

  Future<int> fetchUserDiary(int userId) async {
    final result = await _diaryRepository.getUserDiary(userId);

    if (result.statusCode == 200) {
      setMyDiary(ApiResponse.complete(result));
    } else {
      setMyDiary(ApiResponse.error());
    }

    return result.statusCode;
  }

  List<MyDiary> getDiariesByDate(DateTime date) {
    return diaryEntries.where((diary) {
      final diaryDate = DateTime.parse(
          "${diary.setDate.substring(0, 4)}-${diary.setDate.substring(4, 6)}-${diary.setDate.substring(6, 8)}");
      print("Comparing: ${diaryDate} with ${date}");
      return diaryDate.year == date.year &&
          diaryDate.month == date.month &&
          diaryDate.day == date.day;
    }).toList();
  }

  Future<void> diaryWrite(
      Map<String, dynamic> data, Uint8List? thumbnailData) async {
    final result = await _diaryRepository.diaryWrite(data, thumbnailData);

    print("Jehee : ${result.statusCode}");

    if (result.statusCode == 200 || result.statusCode == 201) {
      setDiary(ApiResponse.complete(result));
    } else {
      setDiary(ApiResponse.error());
    }
  }

  Future<int> diaryDelete(String diaryId) async {
    final result = await _diaryRepository.diaryDelete(diaryId);

    if (result.statusCode == 200 || result.statusCode == 201) {
      setDiaryDelete(ApiResponse.complete(result));
    } else {
      setDiaryDelete(ApiResponse.error());
    }

    return result.statusCode;
  }

  Future<int> diaryUpdate(Map<String, dynamic> sendData,
      Uint8List? thumbnailData, int diaryId) async {
    final result =
        await _diaryRepository.diaryUpdate(sendData, thumbnailData, diaryId);

    print("Jehee : ${result.statusCode}");

    if (result.statusCode == 200 || result.statusCode == 201) {
      setDiaryUpdate(ApiResponse.complete(result));
    } else {
      setDiaryDelete(ApiResponse.error());
    }

    return result.statusCode;
  }
}
