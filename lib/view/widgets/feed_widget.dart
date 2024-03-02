import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';

class FeedWidget extends StatefulWidget {
  final int length;
  final String nickName;
  final String locationInfo;
  final int likesCount;
  final String description;
  final List<String> hashTag;

  const FeedWidget({
    Key? key,
    required this.length,
    required this.nickName,
    required this.locationInfo,
    required this.likesCount,
    required this.description,
    required this.hashTag,
  }) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
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
        border: Border.all(color: const Color(UserColors.primaryColor)),
        borderRadius: BorderRadius.circular(ScreenUtil().radius(12.0)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(UserColors.primaryColor),
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
                              color: Color(UserColors.ui01),
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
                  const Icon(Icons.more_horiz, color: Color(UserColors.ui06))
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(16.0)),
              //here image not padding
              Image.network(
                  "https://mediahub.seoul.go.kr/wp-content/uploads/2020/03/53552dfe5d897d0a50138605f19628a6.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(390.0)),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              Row(
                children: [
                  const Icon(Icons.favorite_border,
                      color: Color(UserColors.ui01)),
                  Text(
                    widget.likesCount.toString() + Strings.likes,
                    style: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(UserColors.ui01),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(15.5)),
              Text(
                widget.description,
                style: const TextStyle(
                  fontFamily: "Pretendard",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(UserColors.ui01),
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
              SizedBox(height: ScreenUtil().setHeight(24.0)),
            ],
          );
        },
      ),
    );
  }
}
