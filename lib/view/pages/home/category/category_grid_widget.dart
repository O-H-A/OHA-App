import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/home/category/category_detail_page.dart';

import '../../../../models/upload/upload_get_model.dart';

class CategoryGridWidget extends StatelessWidget {
  final List<String> imageList;
  final List<UploadData> dataList;

  const CategoryGridWidget({Key? key, required this.imageList, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: ScreenUtil().setHeight(8.0),
        crossAxisSpacing: ScreenUtil().setWidth(8.0),
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDetailPage(data: dataList[index]),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(8.0)),
            child: Image.network(imageList[index], fit: BoxFit.cover),
          ),
        );
      },
      itemCount: imageList.length,
    );
  }
}
