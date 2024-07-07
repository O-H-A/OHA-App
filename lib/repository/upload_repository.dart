import 'dart:convert';
import 'dart:typed_data';

import 'package:oha/models/upload/comment_read_model.dart';
import 'package:oha/models/upload/comment_write_model.dart';
import 'package:oha/models/upload/upload_like_model.dart';
import 'package:oha/models/upload/upload_model.dart';

import '../models/upload/upload_delete_model.dart';
import '../models/upload/upload_get_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

class UploadRepository {
  Future<UploadModel> posting(
      Map<String, dynamic> data, Uint8List? thumbnailData) async {
    try {
      dynamic response = await NetworkManager.instance
          .imagePost(ApiUrl.posting, data, thumbnailData);

      String responseBody = jsonEncode(response);
      return UploadModel.fromJson(jsonDecode(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadGetModel> posts(Map<String, dynamic> queryParams) async {
    try {
      dynamic response =
          await NetworkManager.instance.getWithQuery(ApiUrl.posts, queryParams);
      return UploadGetModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadLikeModel> like(Map<String, dynamic> data) async {
    try {
      dynamic response = await NetworkManager.instance.post(ApiUrl.like, data);
      return UploadLikeModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadDeleteModel> delete(String postId) async {
    try {
      dynamic response =
          await NetworkManager.instance.postDelete(ApiUrl.posting, postId);
      return UploadDeleteModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentReadModel> commentRead(Map<String, dynamic> queryParams) async {
    try {
      dynamic response = await NetworkManager.instance
          .getWithQuery(ApiUrl.comments, queryParams);
      return CommentReadModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<CommentWriteModel> commentWrite(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.comment, data);
      return CommentWriteModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
