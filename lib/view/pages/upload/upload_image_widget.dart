import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';

import '../../../statics/images.dart';

class UploadImageWidget extends StatefulWidget {
  final List<AssetEntity> media;
  final ValueChanged<int> onSelectedIndexChanged;

  const UploadImageWidget({
    required this.media,
    Key? key,
    required this.onSelectedIndexChanged,
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

            widget.onSelectedIndexChanged(_selectIndex);
          },
          child: Stack(
            children: [
              FutureBuilder<Uint8List?>(
                future: widget.media[index].thumbnailData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  } else {
                    return Container(
                      color: Colors.grey[200],
                    );
                  }
                },
              ),
              if (widget.media[index].type == AssetType.video)
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                  ),
                ),
              Positioned(
                top: ScreenUtil().setHeight(8.0),
                right: ScreenUtil().setWidth(8.0),
                child: (index == _selectIndex)
                    ? SvgPicture.asset(Images.imageSelect)
                    : SvgPicture.asset(Images.imageNotSelect),
              ),
            ],
          ),
        );
      },
      itemCount: widget.media.length,
    );
  }
}
