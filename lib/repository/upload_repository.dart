import 'dart:convert';

import 'package:oha/models/upload/upload_model.dart';

import '../network/api_url.dart';
import '../network/network_manager.dart';

class UploadRepository {
  Future<UploadModel> posting(Map<String, dynamic> data) async {
    try {
      dynamic response = await NetworkManager.instance
          .post(ApiUrl.posting, data);
      return UploadModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}