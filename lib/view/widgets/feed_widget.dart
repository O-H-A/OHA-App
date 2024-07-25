import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/view/widgets/button_image.dart';

import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';
import 'button_icon.dart';
import 'comment_sheet.dart';
import '../../../../models/upload/upload_get_model.dart';

class FeedWidget extends StatefulWidget {
  final UploadData uploadData;
  final VoidCallback? onLikePressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onProfilePressed;

  const FeedWidget({
    Key? key,
    required this.uploadData,
    this.onLikePressed,
    this.onMorePressed,
    this.onProfilePressed,
  }) : super(key: key);

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  late int _likesCount;
  late bool _isLike;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.uploadData.likeCount;
    _isLike = widget.uploadData.isLike;
  }

  void _toggleLike() {
    setState(() {
      _isLike = !_isLike;
      _likesCount += _isLike ? 1 : -1;
    });
    if (widget.onLikePressed != null) {
      widget.onLikePressed!();
    }
  }

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
    bool isProfileUrlValid = widget.uploadData.profileUrl.isNotEmpty;

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
                child: GestureDetector(
                  onTap: widget.onProfilePressed,
                  child: ClipOval(
                    child: isProfileUrlValid
                        ? Image.network(widget.uploadData.profileUrl,
                            fit: BoxFit.cover)
                        : SvgPicture.asset(Images.defaultProfile),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(8.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.uploadData.userName,
                    style: const TextStyle(
                      fontFamily: "Pretendard",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(UserColors.ui01),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(3.0)),
                  Text(
                    widget.uploadData.locationDetail,
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
            icon: _isLike ? Icons.favorite : Icons.favorite_border,
            iconColor: _isLike ? Colors.red : const Color(UserColors.ui01),
            callback: () => _toggleLike(),
          ),
          Text(
            ' ${_likesCount}${Strings.likes}',
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(UserColors.ui01),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(8.0)),
          ButtonImage(
            imagePath: Images.comment,
            callback: () => _showCommentSheet(context),
          ),
          Text(
            ' ${widget.uploadData.commentCount}${Strings.comments}',
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

  void _showCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: CommentSheet(postId: widget.uploadData.postId),
      ),
    );
  }

  Widget _buildDescriptionTextWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Text(
        widget.uploadData.content,
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
        Image.network(
            widget.uploadData.files.isNotEmpty
                ? widget.uploadData.files[0].url
                : '',
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
            children: widget.uploadData.keywords.map((hashTag) {
              return _buildHashTagWidget(hashTag);
            }).toList(),
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(24.0)),
      ],
    );
  }
}
