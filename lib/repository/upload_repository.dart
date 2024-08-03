import 'dart:convert';
import 'dart:typed_data';

import 'package:oha/models/upload/comment_read_model.dart';
import 'package:oha/models/upload/comment_write_model.dart';
import 'package:oha/models/upload/upload_like_model.dart';
import 'package:oha/models/upload/upload_model.dart';
import 'package:oha/models/upload/upload_report_model.dart';

import '../models/upload/upload_delete_model.dart';
import '../models/upload/upload_get_model.dart';
import '../network/api_url.dart';
import '../network/network_manager.dart';

import 'package:http_parser/http_parser.dart';

class UploadRepository {
  Future<UploadModel> posting(
      Map<String, dynamic> data, Uint8List? thumbnailData, bool isVideo) async {
        
        String fileName = "";
        const String fileKey = "files";
        MediaType contentType = MediaType('image', 'png');

        if(isVideo == true) {
          fileName = 'files.mp4';
          contentType =  MediaType('video', 'mp4');
        }
        else {
          fileName = 'files.png';
        }

    try {
      dynamic response = await NetworkManager.instance
          .imagePost(ApiUrl.posting, data, thumbnailData, fileName, fileKey, contentType);

      String responseBody = jsonEncode(response);
      return UploadModel.fromJson(jsonDecode(responseBody));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadModel> edit(
      Map<String, dynamic> data, Uint8List? thumbnailData, isVideo) async {
    try {
      dynamic response = await NetworkManager.instance
          .imagePatch(ApiUrl.post, data, thumbnailData);

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

  Future<UploadGetModel> myPosts() async {
    try {
      dynamic response = await NetworkManager.instance.get(ApiUrl.myPosts);
      return UploadGetModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadGetModel> userPosts(int userId) async {
    try {
      final response =
          await NetworkManager.instance.get("${ApiUrl.posts}/user/$userId");
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
    String url = '${ApiUrl.posting}/$postId';
    try {
      dynamic response =
          await NetworkManager.instance.postDelete(url);
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

  Future<UploadReportModel> report(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.report, data);
      return UploadReportModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<UploadLikeModel> commentLike(Map<String, dynamic> data) async {
    try {
      dynamic response =
          await NetworkManager.instance.post(ApiUrl.commentLike, data);
      return UploadLikeModel.fromJson(jsonDecode(response));
    } catch (e) {
      rethrow;
    }
  }
}
