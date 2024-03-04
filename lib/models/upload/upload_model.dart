class UploadModel {
  int statusCode;
  String message;
  UploadData data;

  UploadModel({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? UploadData.fromJson(json['data'])
          : UploadData(postId: 0),
    );
  }
}

class UploadData {
  int postId;

  UploadData({required this.postId});

  factory UploadData.fromJson(Map<String, dynamic> json) {
    return UploadData(
      postId: json['postId'] ?? 0,
    );
  }
}
