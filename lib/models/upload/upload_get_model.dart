class UploadGetModel {
  final int statusCode;
  final String message;
  final List<UploadData> data;

  UploadGetModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UploadGetModel.fromJson(Map<String, dynamic>? json) => UploadGetModel(
        statusCode: json?['statusCode'] ?? 0,
        message: json?['message'] ?? '',
        data: (json?['data'] as List<dynamic>?)
                ?.map((e) => UploadData.fromJson(e))
                .toList() ??
            [],
      );
}

class UploadData {
  final int postId;
  final int userId;
  final String userName;
  bool isLike;
  int likeCount;
  final int commentCount;
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
  final bool isOwn;

  UploadData({
    required this.postId,
    required this.userId,
    required this.userName,
    required this.isLike,
    required this.likeCount,
    required this.commentCount,
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
    required this.isOwn,
  });

  factory UploadData.fromJson(Map<String, dynamic>? json) => UploadData(
        postId: json?['postId'] ?? 0,
        userId: json?['userId'] ?? 0,
        userName: json?['userName'] ?? '',
        isLike: json?['isLike'] ?? false,
        likeCount: json?['likeCount'] ?? 0,
        commentCount: json?['commentCount'] ?? 0,
        categoryCode: json?['categoryCode'] ?? '',
        categoryName: json?['categoryName'] ?? '',
        keywords: (json?['keywords'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [],
        content: json?['content'] ?? '',
        regionCode: json?['regionCode'] ?? 0,
        firstAddress: json?['firstAddress'] ?? '',
        secondAddress: json?['secondAddress'] ?? '',
        thirdAddress: json?['thirdAddress'] ?? '',
        locationDetail: json?['locationDetail'] ?? '',
        regDtm: json?['regDtm'] ?? '',
        updDtm: json?['updDtm'] ?? '',
        files: (json?['files'] as List<dynamic>?)
                ?.map((e) => FileData.fromJson(e))
                .toList() ??
            [],
        profileUrl: json?['profileUrl'] ?? '',
        isOwn: json?['isOwn'] ?? false,
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

  factory FileData.fromJson(Map<String, dynamic>? json) => FileData(
        url: json?['url'] ?? '',
        thumbnailUrl: json?['thumbnailUrl'] ?? '',
        seq: json?['seq'] ?? 0,
      );
}
