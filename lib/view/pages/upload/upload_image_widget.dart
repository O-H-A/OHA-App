import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../statics/images.dart';

class UploadImageWidget extends StatefulWidget {
  final List<AssetEntity> images;

  const UploadImageWidget({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectIndex = index;
            });
          },
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AssetEntityImage(
                  widget.images[index],
                  isOriginal: false,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  top: ScreenUtil().setHeight(8.0),
                  right: ScreenUtil().setWidth(8.0),
                  child: (index == _selectIndex)
                      ? SvgPicture.asset(Images.imageSelect)
                      : SvgPicture.asset(Images.imageNotSelect)),
            ],
          ),
        );
      },
      itemCount: widget.images.length,
    );
  }
}
