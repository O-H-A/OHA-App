class CommentReadModel {
  int statusCode;
  String message;
  List<CommentReadData> data;

  CommentReadModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CommentReadModel.fromJson(Map<String, dynamic> json) {
    return CommentReadModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => CommentReadData.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class CommentReadData {
  int commentId;
  int parentId;
  int postId;
  String content;
  int userId;
  String userName;
  String? profileUrl;
  int replyUserId;
  String replyUserName;
  int taggedUserId;
  String taggedUserNickname;
  String regDtm;
  String updDtm;
  int replyCount;
  bool isLike;
  int likeCount;
  String type;

  CommentReadData({
    required this.commentId,
    required this.parentId,
    required this.postId,
    required this.content,
    required this.userId,
    required this.userName,
    required this.profileUrl,
    required this.replyUserId,
    required this.replyUserName,
    required this.taggedUserId,
    required this.taggedUserNickname,
    required this.regDtm,
    required this.updDtm,
    required this.replyCount,
    required this.isLike,
    required this.likeCount,
    required this.type,
  });

  factory CommentReadData.fromJson(Map<String, dynamic> json) {
    return CommentReadData(
      commentId: json['commentId'] ?? 0,
      parentId: json['parentId'] ?? 0,
      postId: json['postId'] ?? 0,
      content: json['content'] ?? '',
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      taggedUserId: json['taggedUserId'] ?? 0,
      profileUrl: json['profileUrl'] ?? '',
      replyUserId: json['replyUserId'] ?? 0,
      replyUserName: json['replyUserName'] ?? '',
      taggedUserNickname: json['taggedUserNickname'] ?? '',
      regDtm: json['regDtm'] ?? '',
      updDtm: json['updDtm'] ?? '',
      replyCount: json['replyCount'] ?? 0,
      isLike: json['isLike'] ?? false,
      likeCount: json['likeCount'] ?? 0,
      type: json['type'] ?? '',
    );
  }
}
