import 'dart:convert';

import '../models/my_page/my_page_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class MyPageRepository {
  Future<MyPageModel> changeUserNickName(Map<String, dynamic> data) async {
    try {
      dynamic response = await NetworkManager.instance.put(ApiUrl.nickNameUpdate, data);
      return MyPageModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
