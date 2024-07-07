class CommentWriteModel {
  final int statusCode;
  final String message;
  final CommentData data;

  CommentWriteModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CommentWriteModel.fromJson(Map<String, dynamic> json) {
    return CommentWriteModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: CommentData.fromJson(json['data'] ?? {}),
    );
  }
}

class CommentData {
  final int postId;
  final int parentId;
  final String content;
  final int taggedUserId;
  final int commentId;
  final int userId;
  final String userNickname;
  final String taggedUserNickname;
  final String profileUrl;
  final DateTime regDtm;

  CommentData({
    required this.postId,
    required this.parentId,
    required this.content,
    required this.taggedUserId,
    required this.commentId,
    required this.userId,
    required this.userNickname,
    required this.taggedUserNickname,
    required this.profileUrl,
    required this.regDtm,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      postId: json['postId'] ?? 0,
      parentId: json['parentId'] ?? 0,
      content: json['content'] ?? '',
      taggedUserId: json['taggedUserId'] ?? 0,
      commentId: json['commentId'] ?? 0,
      userId: json['userId'] ?? 0,
      userNickname: json['userNickname'] ?? '',
      taggedUserNickname: json['taggedUserNickname'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      regDtm: DateTime.parse(json['regDtm'] ?? {}),
    );
  }
}