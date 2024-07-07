import 'comment_read_model.dart';

class CommentWriteModel {
  final int statusCode;
  final String message;
  final CommentWriteData data;

  CommentWriteModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CommentWriteModel.fromJson(Map<String, dynamic> json) {
    return CommentWriteModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: CommentWriteData.fromJson(json['data'] ?? {}),
    );
  }
}

class CommentWriteData {
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

  CommentWriteData({
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

  factory CommentWriteData.fromJson(Map<String, dynamic> json) {
    return CommentWriteData(
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

  CommentReadData toCommentReadData() {
    return CommentReadData(
      commentId: commentId,
      parentId: parentId,
      postId: postId,
      content: content,
      userId: userId,
      userNickname: userNickname,
      profileUrl: profileUrl,
      taggedUserId: taggedUserId,
      taggedUserNickname: taggedUserNickname,
      regDtm: regDtm.toString(),
      updDtm: '',
      replyCount: 0,
      likeUsers: [],
      likeCount: 0,
    );
  }
}
