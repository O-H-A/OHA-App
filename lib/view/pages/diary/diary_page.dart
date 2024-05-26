import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:oha/network/api_response.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:oha/vidw_model/diary_view_model.dart';
import 'package:oha/view/pages/diary/month_calendar_widget.dart';
import 'package:oha/view/pages/diary/week_calendar_widget.dart';
import 'package:oha/view/widgets/notification_app_bar.dart';
import 'package:provider/provider.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DateTime currentTime = DateTime.now();
  bool viewMonth = true;
  VoidCallback? _retryCallback;

  @override
  void initState() {
    super.initState();

    final diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);

    try {
      diaryViewModel.fetchMyDiary().then((_) {
        _retryCallback = null;
      }).catchError((error) {
        _retryCallback = () => diaryViewModel.fetchMyDiary();
      });
      diaryViewModel.setMyDiary(ApiResponse.loading());
    } catch (error) {
      _retryCallback = () => diaryViewModel.fetchMyDiary();
    }
  }

  String getCurrentTime() {
    return DateFormat('yyyy년 MM월', 'ko_KR').format(currentTime);
  }

  void addCurrentTime() {
    currentTime =
        DateTime(currentTime.year, currentTime.month + 1, currentTime.day);
  }

  void subCurrentTime() {
    currentTime =
        DateTime(currentTime.year, currentTime.month - 1, currentTime.day);
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

  Widget _buildPostingImageWidget() {
    return Container(
      width: ScreenUtil().setWidth(92.0),
      height: ScreenUtil().setHeight(100.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(5.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui11)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(10.0)),
        child: Center(
          child: SvgPicture.asset(
            Images.defaultProfile,
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
                onPressed: () {
                  setState(() {
                    subCurrentTime();
                  });
                },
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
                onPressed: () {
                  setState(() {
                    addCurrentTime();
                  });
                },
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostingImageWidget(),
            SizedBox(width: ScreenUtil().setWidth(12.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "영종도 일몰 이쁘다...",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.location),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "서울 인천 용종도 다리",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.heart),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "32",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    SvgPicture.asset(Images.views),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "32",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        const Icon(Icons.more_horiz, color: Color(UserColors.ui06))
      ],
    );
  }

  Widget _buildDiaryText() {
    return Row(
      children: const [
        Text(
          Strings.diary,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        Icon(Icons.add, color: Color(UserColors.ui04))
      ],
    );
  }

  Widget _buildDiaryWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostingImageWidget(),
            SizedBox(width: ScreenUtil().setWidth(12.0)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "베트남 여행 추억",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.location),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "베트남 푸꾸옥",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(Images.heart),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "32",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    SvgPicture.asset(Images.views),
                    SizedBox(width: ScreenUtil().setWidth(3.0)),
                    const Text(
                      "32",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Pretendard",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        const Icon(Icons.more_horiz, color: Color(UserColors.ui06))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  ? MonthCalendarWidget(currentDate: currentTime)
                  : WeekCalendarWidget(currentDate: currentTime),
              SizedBox(height: ScreenUtil().setHeight(22.0)),
              _buildPostingText(),
              SizedBox(height: ScreenUtil().setHeight(19.0)),
              _buildPostingWidget(),
              SizedBox(height: ScreenUtil().setHeight(37.0)),
              _buildDiaryText(),
              SizedBox(height: ScreenUtil().setHeight(19.0)),
              _buildDiaryWidget(),
              SizedBox(height: ScreenUtil().setHeight(150.0)),
            ],
          ),
        ),
      ),
    );
  }
}
