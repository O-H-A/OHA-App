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

  factory UploadData.fromJson(Map<String, dynamic>? json) => UploadData(
        postId: json?['postId'] ?? 0,
        userId: json?['userId'] ?? 0,
        userNickname: json?['userNickname'] ?? '',
        likeUsers: (json?['likeUsers'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            [],
        likeCount: json?['likeCount'] ?? 0,
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
