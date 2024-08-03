import 'dart:convert';
import 'dart:typed_data';

import 'package:oha/models/diary/diary_delete_model.dart';
import 'package:oha/models/diary/diary_update_model.dart';
import 'package:oha/models/diary/my_diary_model.dart';
import 'package:oha/network/api_url.dart';
import 'package:oha/network/network_manager.dart';

import '../models/diary/diary_write_model.dart';

import 'package:http_parser/http_parser.dart';

class DiaryRepository {
  Future<MyDiaryModel> getMyDiary() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.myDiary);
      return MyDiaryModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<DiaryWriteModel> diaryWrite(
      Map<String, dynamic> data, Uint8List? thumbnailData) async {
    try {
      const String fileName = "file.png";
      const String fileKey = "file";
      MediaType contentType = MediaType('image', 'png');

      dynamic response = await NetworkManager.instance.notDtoimagePost(
          ApiUrl.diary, data, thumbnailData, fileName, fileKey, contentType);
      return DiaryWriteModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<DiaryDeleteModel> diaryDelete(String diaryId) async {
    String url = '${ApiUrl.diary}/$diaryId';
    try {
      dynamic response = await NetworkManager.instance.postDelete(url);
      return DiaryDeleteModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }


  Future<DiaryUpdateModel> diaryUpdate(
      Map<String, dynamic> data, Uint8List? thumbnailData, int diaryId) async {
        String url = '${ApiUrl.diary}/$diaryId';
    try {
      const String fileName = "file.png";
      const String fileKey = "file";
      MediaType contentType = MediaType('image', 'png');

      dynamic response = await NetworkManager.instance.notDtoimagePut(
          url, data, thumbnailData, fileName, fileKey, contentType);
      return DiaryUpdateModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
