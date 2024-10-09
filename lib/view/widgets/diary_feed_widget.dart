import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oha/statics/images.dart';
import 'package:video_player/video_player.dart';

import '../../statics/Colors.dart';
import '../../statics/strings.dart';
import 'button_icon.dart';
import '../../../../models/diary/my_diary_model.dart';

class DiaryFeedWidget extends StatefulWidget {
  final MyDiary diaryData;
  final MyDiaryWriter writerData;
  final VoidCallback? onLikePressed;
  final VoidCallback? onMorePressed;
  final VoidCallback? onProfilePressed;
  final bool showLine;

  const DiaryFeedWidget({
    Key? key,
    required this.diaryData,
    required this.writerData,
    this.onLikePressed,
    this.onMorePressed,
    this.onProfilePressed,
    this.showLine = false,
  }) : super(key: key);

  @override
  State<DiaryFeedWidget> createState() => _DiaryFeedWidgetState();
}

class _DiaryFeedWidgetState extends State<DiaryFeedWidget> {
  late int _likesCount;
  late bool _isLike;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _likesCount = int.tryParse(widget.diaryData.likes) ?? 0;
    _isLike = false;
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
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

  Widget _buildDiaryTitle() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(22.0), right: ScreenUtil().setWidth(13.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.diaryData.title,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: ScreenUtil().setSp(20.0),
              fontWeight: FontWeight.w500,
              color: const Color(UserColors.ui01),
            ),
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

  Widget _buildWeatherWidget() {
    final imagePath = Images.diaryWeatherImageMap[widget.diaryData.weather] ??
        Images.cloudyEnable;
    final weather = Strings.weatherCodeMap[widget.diaryData.weather] ??
        Strings.cloudy;

    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(22.0)),
      child: Row(
        children: [
          SvgPicture.asset(
            imagePath,
            width: ScreenUtil().setWidth(18.0),
            height: ScreenUtil().setHeight(13.0),
          ),
          SizedBox(width: ScreenUtil().setWidth(6.0)),
          Text(
            weather,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: ScreenUtil().setSp(14.0),
              fontWeight: FontWeight.w500,
              color: const Color(UserColors.ui04),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationWidget() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(22.0)),
      child: Row(
        children: [
          SvgPicture.asset(
            Images.location,
            width: ScreenUtil().setWidth(18.0),
            height: ScreenUtil().setHeight(13.0),
          ),
          SizedBox(width: ScreenUtil().setWidth(6.0)),
          Text(
            widget.diaryData.location,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontSize: ScreenUtil().setSp(14.0),
              fontWeight: FontWeight.w500,
              color: const Color(UserColors.ui04),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiaryImageWidget() {
    final imageUrl = widget.diaryData.fileRelation?.isNotEmpty == true
        ? widget.diaryData.fileRelation![0].fileUrl
        : null;

    if (imageUrl == null || imageUrl.isEmpty) {
      return Container();
    }

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: ScreenUtil().setHeight(390.0),
      fit: BoxFit.cover,
    );
  }

  Widget _buildLikesWidget() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20.0)),
      child: Row(
        children: [
          ButtonIcon(
            icon: _isLike ? Icons.favorite : Icons.favorite_border,
            iconColor: _isLike ? Colors.red : const Color(UserColors.ui01),
            callback: () => _toggleLike(),
          ),
          Text(
            ' $_likesCount${Strings.diaryLikes}',
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(UserColors.ui01),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(8.0)),
        ],
      ),
    );
  }

  Widget _buildDescriptionTextWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Text(
        widget.diaryData.content,
        style: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(UserColors.ui01),
        ),
      ),
    );
  }

  Widget _buildSplitLine() {
    return Container(
      width: double.infinity,
      height: (widget.showLine) ? ScreenUtil().setHeight(12.0) : 0,
      color: const Color(UserColors.ui12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDiaryTitle(),
        SizedBox(height: ScreenUtil().setHeight(10.0)),
        _buildWeatherWidget(),
        SizedBox(height: ScreenUtil().setHeight(10.0)),
        _buildLocationWidget(),
        SizedBox(height: ScreenUtil().setHeight(12.0)),
        _buildDiaryImageWidget(),
        SizedBox(height: ScreenUtil().setHeight(23.0)),
        _buildLikesWidget(),
        SizedBox(height: ScreenUtil().setHeight(15.5)),
        _buildDescriptionTextWidget(),
        SizedBox(height: ScreenUtil().setHeight(24.0)),
        _buildSplitLine(),
      ],
    );
  }
}
