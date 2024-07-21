import 'dart:convert';
import 'dart:typed_data';

import '../models/my_page/my_info_model.dart';
import '../models/my_page/name_update_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class MyPageRepository {
  Future<NameUpdateModel> changeUserInfo(
      Map<String, dynamic> data, Uint8List? image) async {
    try {
      dynamic response = await NetworkManager.instance
          .imagePut(ApiUrl.myInfo, data, image);
      return NameUpdateModel.fromJson(jsonDecode(response));  
    } catch (e) {
      rethrow;
    }
  }

  Future<MyInfoModel> myInfo() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.myInfo);
      return MyInfoModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
