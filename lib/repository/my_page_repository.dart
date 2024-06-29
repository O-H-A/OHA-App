import 'dart:convert';

import '../models/my_page/my_info_model.dart';
import '../models/my_page/name_update_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class MyPageRepository {
  Future<NameUpdateModel> changeUserNickName(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.put(ApiUrl.nickNameUpdate, data);
      return NameUpdateModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<MyInfoModel> myInfo() async {
    try {
      dynamic response =
          await NetworkManager.instance.get(ApiUrl.myInfo);
      return MyInfoModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
