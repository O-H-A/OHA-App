import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/models/upload/upload_get_model.dart';
import 'category_detail_app_bar_widget.dart';
import 'category_feed_widget.dart';

class CategoryDetailPage extends StatefulWidget {
  final UploadData data;

  const CategoryDetailPage({Key? key, required this.data}) : super(key: key);

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CategoryDetailAppBarWidget(imageUrl: widget.data.files[0].url), // Pass imageUrl here
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CategoryFeedWidget(
            length: 1,
            imageUrl: widget.data.files[0].url,
            nickName: widget.data.userName,
            locationInfo: widget.data.locationDetail,
            likesCount: widget.data.likeCount,
            description: widget.data.content,
            hashTag: widget.data.keywords,
          ),
        ],
      ),
    );
  }
}
