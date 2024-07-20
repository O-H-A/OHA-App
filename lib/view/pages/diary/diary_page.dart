import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/view_model/diary_view_model.dart';
import 'package:oha/view_model/upload_view_model.dart';
import 'package:oha/view/pages/diary/month_calendar_widget.dart';
import 'package:oha/view/pages/diary/week_calendar_widget.dart';
import 'package:oha/view/widgets/button_icon.dart';
import 'package:oha/view/widgets/notification_app_bar.dart';
import 'package:provider/provider.dart';

import '../../../models/diary/my_diary_model.dart';
import 'diary_register_page.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DateTime currentTime = DateTime.now();
  bool viewMonth = true;
  VoidCallback? _retryCallback;
  DiaryViewModel _diaryViewModel = DiaryViewModel();
  UploadViewModel _uploadViewModel = UploadViewModel();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    _diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);

    try {
      _diaryViewModel.fetchMyDiary().then((_) {
        _retryCallback = null;
      }).catchError((error) {
        _retryCallback = () => _diaryViewModel.fetchMyDiary();
      });
      _diaryViewModel.setMyDiary(ApiResponse.loading());

      _uploadViewModel.myPosts().then((_) {
        _retryCallback = null;
      }).catchError((error) {
        _retryCallback = () => _uploadViewModel.myPosts();
      });
      _uploadViewModel.clearMyUploadGetData();
    } catch (error) {
      _retryCallback = () {
        _diaryViewModel.fetchMyDiary();
        _uploadViewModel.myPosts();
      };
    }
  }

  String getCurrentTime() {
    return DateFormat('yyyy년 MM월', 'ko_KR').format(currentTime);
  }

  void addCurrentTime() {
    setState(() {
      if (viewMonth) {
        currentTime =
            DateTime(currentTime.year, currentTime.month + 1, currentTime.day);
      } else {
        currentTime = currentTime.add(Duration(days: 7));
      }
    });
  }

  void subCurrentTime() {
    setState(() {
      if (viewMonth) {
        currentTime =
            DateTime(currentTime.year, currentTime.month - 1, currentTime.day);
      } else {
        currentTime = currentTime.subtract(Duration(days: 7));
      }
    });
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  Widget _buildCalendarTypeWidget(bool month, String type) {
    return Container(
      width: ScreenUtil().setWidth(46.0),
      height: ScreenUtil().setHeight(35.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(22.0)),
        border: Border.all(
            color: const Color(UserColors.ui08),
            width: (month)
                ? ScreenUtil().setWidth(0.0)
                : ScreenUtil().setWidth(1.0)),
        color: (month) ? const Color(UserColors.primaryColor) : Colors.white,
      ),
      child: Center(
        child: Text(
          type,
          style: TextStyle(
            color: (month) ? Colors.white : const Color(UserColors.ui01),
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPostingImageWidget(String? fileUrl) {
    return Container(
      width: ScreenUtil().setWidth(92.0),
      height: ScreenUtil().setHeight(100.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui11)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: fileUrl != null && fileUrl.isNotEmpty
            ? Container(
                width: ScreenUtil().setWidth(80.0),
                height: ScreenUtil().setHeight(80.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
                  image: DecorationImage(
                    image: NetworkImage(fileUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                width: ScreenUtil().setWidth(80.0),
                height: ScreenUtil().setHeight(80.0),
                decoration: BoxDecoration(
                  color: const Color(UserColors.ui10),
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
                ),
              ),
      ),
    );
  }

  Widget _buildUserInfoWidget() {
    return Row(
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
        SizedBox(width: ScreenUtil().setWidth(14.0)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "User Name",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              "다이어리 등록 수 반응",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w300,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthChangeWidget() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(53.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui11)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: subCurrentTime,
              ),
              Text(
                getCurrentTime(),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: addCurrentTime,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(15.0)),
            child: Row(
              children: [
                SvgPicture.asset(Images.diaryCalendarEnable),
                SizedBox(width: ScreenUtil().setWidth(15.0)),
                SvgPicture.asset(Images.diaryFeedDisable),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarTypeContainerWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              viewMonth = true;
            });
          },
          child: _buildCalendarTypeWidget(viewMonth, Strings.month),
        ),
        SizedBox(width: ScreenUtil().setWidth(6.0)),
        GestureDetector(
          onTap: () {
            setState(() {
              viewMonth = false;
            });
          },
          child: _buildCalendarTypeWidget(!viewMonth, Strings.week),
        ),
      ],
    );
  }

  Widget _buildPostingText() {
    return const Text(
      Strings.posting,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Pretendard",
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _buildPostingWidget() {
    final myUploads = _uploadViewModel.myUploadGetData.data?.data ?? [];
    final selectedDateUploads = myUploads.where((upload) {
      final uploadDate = DateTime.parse(upload.regDtm);
      return uploadDate.year == selectedDate.year &&
          uploadDate.month == selectedDate.month &&
          uploadDate.day == selectedDate.day;
    }).toList();

    if (selectedDateUploads.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12.0)),
        child: Row(
          children: [
            _buildPostingImageWidget(null),
            SizedBox(width: ScreenUtil().setWidth(12.0)),
            Text(
              Strings.postEmpty,
              style: TextStyle(
                color: const Color(UserColors.ui06),
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(14.0),
              ),
            ),
          ],
        ),
      );
    }

    final upload = selectedDateUploads.first;

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostingImageWidget(upload.thumbnailUrl),
              SizedBox(width: ScreenUtil().setWidth(12.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: ScreenUtil().setWidth(180.0),
                    child: Text(
                      upload.content,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Images.location),
                      SizedBox(width: ScreenUtil().setWidth(3.0)),
                      Container(
                        width: ScreenUtil().setWidth(150.0),
                        child: Text(
                          "${upload.firstAddress} ${upload.secondAddress} ${upload.thirdAddress}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Images.heart),
                      SizedBox(width: ScreenUtil().setWidth(3.0)),
                      Text(
                        "${upload.likeCount}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(3.0)),
                      SvgPicture.asset(Images.views),
                      SizedBox(width: ScreenUtil().setWidth(3.0)),
                      Text(
                        "${upload.commentCount}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Pretendard",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.more_horiz, color: Color(UserColors.ui06)),
        ],
      ),
    );
  }

  Widget _buildDiaryText() {
    return Row(
      children: [
        const Text(
          Strings.diary,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        ButtonIcon(
          icon: Icons.add,
          iconColor: const Color(UserColors.ui04),
          callback: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiaryRegisterPage(selectDate: selectedDate),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDiaryWidget(MyDiary? diary) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(12.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostingImageWidget(diary?.fileRelation?.isNotEmpty == true
                  ? (diary?.fileRelation?[0].fileUrl)
                  : null),
              SizedBox(width: ScreenUtil().setWidth(12.0)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    diary?.title ?? Strings.diaryEmpty,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: const Color(UserColors.ui06),
                      fontFamily: "Pretendard",
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14.0),
                    ),
                  ),
                  if (diary != null) ...[
                    Row(
                      children: [
                        SvgPicture.asset(Images.location),
                        SizedBox(width: ScreenUtil().setWidth(3.0)),
                        Container(
                          width: ScreenUtil().setWidth(150.0),
                          child: Text(
                            diary.location,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "Pretendard",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(Images.heart),
                        SizedBox(width: ScreenUtil().setWidth(3.0)),
                        Text(
                          diary.likes,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(3.0)),
                        SvgPicture.asset(Images.views),
                        SizedBox(width: ScreenUtil().setWidth(3.0)),
                        Text(
                          diary.views,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ],
          ),
          if (diary != null)
            const Icon(Icons.more_horiz, color: Color(UserColors.ui06)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final diaries = _diaryViewModel.getDiariesByDate(selectedDate);
    final myDiary = diaries.isNotEmpty ? diaries.first : null;

    return Scaffold(
      appBar: const NotificationAppBar(
        title: Strings.diary,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfoWidget(),
              SizedBox(height: ScreenUtil().setHeight(36.0)),
              _buildMonthChangeWidget(),
              SizedBox(height: ScreenUtil().setHeight(12.0)),
              _buildCalendarTypeContainerWidget(),
              SizedBox(height: ScreenUtil().setHeight(18.0)),
              (viewMonth)
                  ? MonthCalendarWidget(
                      currentDate: currentTime,
                      onDateSelected: onDateSelected,
                    )
                  : WeekCalendarWidget(
                      currentDate: currentTime,
                      onDateSelected: onDateSelected,
                    ),
              SizedBox(height: ScreenUtil().setHeight(22.0)),
              _buildPostingText(),
              SizedBox(height: ScreenUtil().setHeight(19.0)),
              _buildPostingWidget(),
              SizedBox(height: ScreenUtil().setHeight(37.0)),
              _buildDiaryText(),
              SizedBox(height: ScreenUtil().setHeight(19.0)),
              _buildDiaryWidget(myDiary),
              SizedBox(height: ScreenUtil().setHeight(150.0)),
            ],
          ),
        ),
      ),
    );
  }
}
