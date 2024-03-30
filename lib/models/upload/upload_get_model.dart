import 'dart:convert';

class UploadGetModel {
  final int statusCode;
  final String message;
  final List<UploadData> data;

  UploadGetModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UploadGetModel.fromJson(Map<String, dynamic> json) => UploadGetModel(
        statusCode: json['statusCode'],
        message: json['message'],
        data: List<UploadData>.from(json['data'].map((x) => UploadData.fromJson(x))),
      );
}

class UploadData {
  final int postId;
  final int userId;
  final String userNickname;
  final List<int> likeUsers;
  final int likeCount;
  final String categoryCode;
  final String categoryName;
  final List<String> keywords;
  final String content;
  final int regionCode;
  final String firstAddress;
  final String secondAddress;
  final String thirdAddress;
  final String locationDetail;
  final String regDtm;
  final String updDtm;
  final List<FileData> files;
  final String profileUrl;

  UploadData({
    required this.postId,
    required this.userId,
    required this.userNickname,
    required this.likeUsers,
    required this.likeCount,
    required this.categoryCode,
    required this.categoryName,
    required this.keywords,
    required this.content,
    required this.regionCode,
    required this.firstAddress,
    required this.secondAddress,
    required this.thirdAddress,
    required this.locationDetail,
    required this.regDtm,
    required this.updDtm,
    required this.files,
    required this.profileUrl,
  });

  factory UploadData.fromJson(Map<String, dynamic> json) => UploadData(
        postId: json['postId'],
        userId: json['userId'],
        userNickname: json['userNickname'],
        likeUsers: List<int>.from(json['likeUsers'].map((x) => x)),
        likeCount: json['likeCount'],
        categoryCode: json['categoryCode'],
        categoryName: json['categoryName'],
        keywords: List<String>.from(json['keywords'].map((x) => x)),
        content: json['content'],
        regionCode: json['regionCode'],
        firstAddress: json['firstAddress'],
        secondAddress: json['secondAddress'],
        thirdAddress: json['thirdAddress'],
        locationDetail: json['locationDetail'],
        regDtm: json['regDtm'],
        updDtm: json['updDtm'],
        files: List<FileData>.from(json['files'].map((x) => FileData.fromJson(x))),
        profileUrl: json['profileUrl'],
      );  
}

class FileData {
  final String url;
  final String thumbnailUrl;
  final int seq;

  FileData({
    required this.url,
    required this.thumbnailUrl,
    required this.seq,
  });

  factory FileData.fromJson(Map<String, dynamic> json) => FileData(
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl'],
        seq: json['seq'],
      );
}
