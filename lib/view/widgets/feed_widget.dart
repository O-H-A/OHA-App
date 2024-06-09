import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';
import 'button_icon.dart';

class FeedWidget extends StatefulWidget {
  final int postId;
  final String nickName;
  final String locationInfo;
  final int likesCount;
  final String description;
  final List<String> hashTag;
  final String imageUrl;
  final VoidCallback? onLikePressed;
  final VoidCallback? onMorePressed;

  const FeedWidget({
    Key? key,
    required this.postId,
    required this.nickName,
    required this.locationInfo,
    required this.likesCount,
    required this.description,
    required this.hashTag,
    required this.imageUrl,
    this.onLikePressed,
    this.onMorePressed,
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

  Widget _buildProfileWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Row(
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
          ButtonIcon(
            icon: Icons.more_horiz,
            iconColor: const Color(UserColors.ui06),
            callback: widget.onMorePressed ?? () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLikesWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Row(
        children: [
          ButtonIcon(
            icon: Icons.favorite_border,
            iconColor: Color(UserColors.ui01),
            callback: widget.onLikePressed ?? () {},
          ),
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
    );
  }

  Widget _buildDescriptionTextWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Text(
        widget.description,
        style: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(UserColors.ui01),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileWidget(),
        SizedBox(height: ScreenUtil().setHeight(16.0)),
        Image.network(widget.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: ScreenUtil().setHeight(390.0)),
        SizedBox(height: ScreenUtil().setHeight(12.0)),
        _buildLikesWidget(),
        SizedBox(height: ScreenUtil().setHeight(15.5)),
        _buildDescriptionTextWidget(),
        SizedBox(height: ScreenUtil().setHeight(12.0)),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(22.0),
          ),
          child: Wrap(
            spacing: ScreenUtil().setWidth(6.0),
            runSpacing: ScreenUtil().setHeight(6.0),
            children: widget.hashTag.map((hashTag) {
              return _buildHashTagWidget(hashTag);
            }).toList(),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(24.0)),
      ],
    );
  }
}
