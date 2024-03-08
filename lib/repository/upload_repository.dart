import 'dart:convert';
import 'dart:typed_data';

import 'package:oha/models/upload/upload_model.dart';

import '../network/api_url.dart';
import '../network/network_manager.dart';

class UploadRepository {
  Future<UploadModel> posting(Map<String, dynamic> data, Uint8List? thumbnailData) async {
    try {
      dynamic response = await NetworkManager.instance
          .imagePost(ApiUrl.posting, data, thumbnailData);
      return UploadModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}