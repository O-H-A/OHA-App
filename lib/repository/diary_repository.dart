import 'dart:convert';

import 'package:oha/models/diary/my_diary_model.dart';
import 'package:oha/network/api_url.dart';
import 'package:oha/network/network_manager.dart';

class DiaryRepository {
  Future<MyDiaryModel> getMyDiary() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.myDiary);
      return MyDiaryModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
