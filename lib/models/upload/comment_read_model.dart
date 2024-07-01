class CommentReadModel {
  int statusCode;
  String message;
  List<CommentData> data;

  CommentReadModel(
      {required this.statusCode, required this.message, required this.data});

  factory CommentReadModel.fromJson(Map<String, dynamic> json) {
    return CommentReadModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CommentData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class CommentData {
  int commentId;
  int parentId;
  int postId;
  String content;
  int userId;
  String userNickname;
  String profileUrl;
  int taggedUserId;
  String taggedUserNickname;
  String regDtm;
  String updDtm;
  int replyCount;
  List<int> likeUsers;
  int likeCount;

  CommentData({
    required this.commentId,
    required this.parentId,
    required this.postId,
    required this.content,
    required this.userId,
    required this.userNickname,
    required this.profileUrl,
    required this.taggedUserId,
    required this.taggedUserNickname,
    required this.regDtm,
    required this.updDtm,
    required this.replyCount,
    required this.likeUsers,
    required this.likeCount,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      commentId: json['commentId'] ?? 0,
      parentId: json['parentId'] ?? 0,
      postId: json['postId'] ?? 0,
      content: json['content'] ?? '',
      userId: json['userId'] ?? 0,
      userNickname: json['userNickname'] ?? '',
      profileUrl: json['profileUrl'] ?? '',
      taggedUserId: json['taggedUserId'] ?? 0,
      taggedUserNickname: json['taggedUserNickname'] ?? '',
      regDtm: json['regDtm'] ?? '',
      updDtm: json['updDtm'] ?? '',
      replyCount: json['replyCount'] ?? 0,
      likeUsers: (json['likeUsers'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
      likeCount: json['likeCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'parentId': parentId,
      'postId': postId,
      'content': content,
      'userId': userId,
      'userNickname': userNickname,
      'profileUrl': profileUrl,
      'taggedUserId': taggedUserId,
      'taggedUserNickname': taggedUserNickname,
      'regDtm': regDtm,
      'updDtm': updDtm,
      'replyCount': replyCount,
      'likeUsers': likeUsers,
      'likeCount': likeCount,
    };
  }
}
