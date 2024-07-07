import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';

class CategoryFeedWidget extends StatefulWidget {
  final int length;
  final String imageUrl;
  final String nickName;
  final String locationInfo;
  final int likesCount;
  final String description;
  final List<String> hashTag;

  const CategoryFeedWidget({
    Key? key,
    required this.length,
    required this.imageUrl,
    required this.nickName,
    required this.locationInfo,
    required this.likesCount,
    required this.description,
    required this.hashTag,
  }) : super(key: key);

  @override
  State<CategoryFeedWidget> createState() => _CategoryFeedWidgetState();
}

class _CategoryFeedWidgetState extends State<CategoryFeedWidget> {
  ScrollController _scrollController = ScrollController();

  TextSpan _buildTextSpan(String text) {
    return TextSpan(
      text: text,
    );
  }

  TextPainter _getTextPainter(TextSpan textSpan) {
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter;
  }

  Widget _buildHashTagWidget(String text) {
    final textSpan = _buildTextSpan(text);
    final textPainter = _getTextPainter(textSpan);

    return Container(
      height: ScreenUtil().setHeight(26.0),
      width: ScreenUtil()
          .setWidth(textPainter.width * 1 + ScreenUtil().setWidth(16.0)),
      decoration: BoxDecoration(
        //border: Border.all(color: const Color(UserColors.primaryColor)),
        color: Color(0x88858585),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(12.0)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(UserColors.ui08),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtil().setHeight(59.0)),
              Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(390.0)),
              SizedBox(height: ScreenUtil().setHeight(30.0)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(28.0),
                              height: ScreenUtil().setHeight(28.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: SvgPicture.asset(Images.defaultProfile),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(8.0)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.nickName,
                                  style: const TextStyle(
                                    fontFamily: "Pretendard",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(3.0)),
                                Text(
                                  widget.locationInfo,
                                  style: const TextStyle(
                                    fontFamily: "Pretendard",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Color(UserColors.ui04),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(Icons.favorite_border,
                            color: Colors.white),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(15.5)),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        fontFamily: "Pretendard",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(12.0)),
                    Wrap(
                      spacing: ScreenUtil().setWidth(6.0),
                      runSpacing: ScreenUtil().setHeight(6.0),
                      children: widget.hashTag.map((hashTag) {
                        return _buildHashTagWidget(hashTag);
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(24.0)),
            ],
          );
        },
      ),
    );
  }
}
