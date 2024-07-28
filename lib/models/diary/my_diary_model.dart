class MyDiaryModel {
  final int statusCode;
  final String message;
  final MyDiaryData? data;

  MyDiaryModel({
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory MyDiaryModel.fromJson(Map<String, dynamic> json) {
    return MyDiaryModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? MyDiaryData.fromJson(json['data']) : null,
    );
  }
}

class MyDiaryData {
  final MyDiaryWriter? writer;
  final List<MyDiary>? diaries;

  MyDiaryData({
    this.writer,
    this.diaries,
  });

  factory MyDiaryData.fromJson(Map<String, dynamic> json) {
    return MyDiaryData(
      writer: json['writer'] != null ? MyDiaryWriter.fromJson(json['writer']) : null,
      diaries: json['diaries'] != null ? (json['diaries'] as List).map((item) => MyDiary.fromJson(item)).toList() : null,
    );
  }
}

class MyDiaryWriter {
  final int userId;
  final String providerType;
  final String email;
  final String name;
  final String? profileUrl;
  final String createdAt;
  final String updatedAt;

  MyDiaryWriter({
    required this.userId,
    required this.providerType,
    required this.email,
    required this.name,
    required this.profileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyDiaryWriter.fromJson(Map<String, dynamic> json) {
    return MyDiaryWriter(
      userId: json['userId'] ?? 0,
      providerType: json['providerType'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profileUrl: json['profileUrl'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class MyDiary {
  final int diaryId;
  final String userId;
  final String title;
  final String weather;
  final String content;
  final String setDate;
  final String location;
  final bool isPublic;
  final String likes;
  final String views;
  final String createdAt;
  final String updatedAt;
  final List<MyDiaryFile>? fileRelation;

  MyDiary({
    required this.diaryId,
    required this.userId,
    required this.title,
    required this.weather,
    required this.content,
    required this.setDate,
    required this.location,
    required this.isPublic,
    required this.likes,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
    this.fileRelation,
  });

  factory MyDiary.fromJson(Map<String, dynamic> json) {
    return MyDiary(
      diaryId: json['diaryId'] ?? 0,
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      weather: json['weather'] ?? '',
      content: json['content'] ?? '',
      setDate: json['setDate'] ?? '',
      location: json['location'] ?? '',
      isPublic: json['isPublic'] ?? false,
      likes: json['likes'] ?? '',
      views: json['views'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      fileRelation: json['fileRelation'] != null ? (json['fileRelation'] as List).map((item) => MyDiaryFile.fromJson(item)).toList() : null,
    );
  }
}

class MyDiaryFile {
  final int fileId;
  final String fileUrl;
  final String createdAt;
  final String updatedAt;

  MyDiaryFile({
    required this.fileId,
    required this.fileUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyDiaryFile.fromJson(Map<String, dynamic> json) {
    return MyDiaryFile(
      fileId: json['fileId'] ?? 0,
      fileUrl: json['fileUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
