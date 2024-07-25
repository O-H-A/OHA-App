import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../../../models/upload/upload_get_model.dart';
import '../../widgets/complete_dialog.dart';
import '../../widgets/feed_widget.dart';
import '../../widgets/four_more_dialog.dart';
import '../../widgets/loading_widget.dart';
import '../mypage/delete_dialog.dart';
import 'diary_register_page.dart';

class DiaryPage extends StatefulWidget {
  final int? userId;

  const DiaryPage({super.key, this.userId});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DateTime currentTime = DateTime.now();
  bool viewMonth = true;
  bool showFeed = false;
  VoidCallback? _retryCallback;
  late DiaryViewModel _diaryViewModel;
  late UploadViewModel _uploadViewModel;
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _offset = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();

    _diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);

    if (widget.userId != null) {
      _fetchUserPosts(widget.userId!);
    } else {
      _fetchData();
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore) {
        _loadMoreData();
      }
    });
  }

  Future<void> _fetchData() async {
    try {
      await _diaryViewModel.fetchMyDiary().then((_) {
        _retryCallback = null;
      }).catchError((error) {
        _retryCallback = () => _diaryViewModel.fetchMyDiary();
      });
      _diaryViewModel.setMyDiary(ApiResponse.loading());

      await _uploadViewModel.myPosts().then((_) {
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

  Future<void> _fetchUserPosts(int userId) async {
    try {
      await _uploadViewModel.userPosts(userId).then((_) {
        _retryCallback = null;
      }).catchError((error) {
        _retryCallback = () => _uploadViewModel.userPosts(userId);
      });
      _uploadViewModel.clearUserUploadGetData();
    } catch (error) {
      _retryCallback = () {
        _uploadViewModel.userPosts(userId);
      };
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    _offset += _pageSize;

    Map<String, dynamic> sendData = {
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
    };

    try {
      if (widget.userId != null) {
        await _uploadViewModel.userPosts(widget.userId!);
      } else {
        await _uploadViewModel.myPosts();
      }
    } catch (error) {
      // Handle error
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
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
      print("Selected Date: $selectedDate");
      print(
          "Diaries on Selected Date: ${_diaryViewModel.getDiariesByDate(selectedDate)}");
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
    return Consumer<DiaryViewModel>(
      builder: (context, viewModel, child) {
        final userName = viewModel.getMyDiary.data?.data?.writer?.name ?? '';
        final diaryCount = viewModel.diaryEntries.length;
        final totalLikes = _getTotalLikes(viewModel);
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
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(14.0),
                  ),
                ),
                Text(
                  Strings.diaryInfoText(diaryCount, totalLikes),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w300,
                    fontSize: ScreenUtil().setSp(12.0),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  int _getTotalLikes(DiaryViewModel viewModel) {
    int totalLikes = 0;
    for (var diary in viewModel.getMyDiary.data?.data?.diaries ?? []) {
      totalLikes += int.tryParse(diary.likes) ?? 0;
    }
    return totalLikes;
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
              ButtonIcon(
                icon: Icons.chevron_left,
                iconColor: Colors.black,
                callback: () => subCurrentTime(),
              ),
              SizedBox(width: ScreenUtil().setWidth(10.0)),
              Text(
                getCurrentTime(),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: ScreenUtil().setWidth(10.0)),
              ButtonIcon(
                icon: Icons.chevron_right,
                iconColor: Colors.black,
                callback: () => addCurrentTime(),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(15.0)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFeed = false;
                    });
                  },
                  child: SvgPicture.asset(
                    showFeed ? Images.diaryCalendarDisable : Images.diaryCalendarEnable,
                  ),
                ),
                SizedBox(width: ScreenUtil().setWidth(15.0)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFeed = true;
                    });
                  },
                  child: SvgPicture.asset(
                    showFeed ? Images.diaryFeedEnable : Images.diaryFeedDisable,
                  ),
                ),
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
    final myUploads = widget.userId != null
        ? _uploadViewModel.userUploadGetData.data?.data ?? []
        : _uploadViewModel.myUploadGetData.data?.data ?? [];
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
                  SizedBox(
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

  Widget _buildFeedWidget() {
    final myUploads = widget.userId != null
        ? _uploadViewModel.userUploadGetData.data?.data ?? []
        : _uploadViewModel.myUploadGetData.data?.data ?? [];
    final filteredUploads = myUploads.where((upload) {
      final uploadDate = DateTime.parse(upload.regDtm);
      if (viewMonth) {
        return uploadDate.year == currentTime.year &&
            uploadDate.month == currentTime.month;
      } else {
        return uploadDate.isAfter(currentTime.subtract(const Duration(days: 7))) &&
            uploadDate.isBefore(currentTime.add(const Duration(days: 7)));
      }
    }).toList();

    if (filteredUploads.isEmpty) {
      return _buildPostEmptyWidget();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: filteredUploads.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == filteredUploads.length) {
          return _buildLoadingWidget();
        }

        var data = filteredUploads[index];
        return Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(12.0)),
          child: FeedWidget(
            uploadData: data,
            onLikePressed: () => _onLikePressed(data.postId, data.isLike),
            onMorePressed: () => FourMoreDialog.show(
                context,
                (action) => _onMorePressed(data.postId, action, data),
                data.isOwn,
                data.files.isNotEmpty ? data.files[0].url : '',
                data.postId),
            onProfilePressed: () => _onProfilePressed(data.userId, data.isOwn),
          ),
        );
      },
    );
  }

  void _onLikePressed(int postId, bool isCurrentlyLiked) async {
    print("Like pressed for postId: $postId");

    Map<String, dynamic> data = {
      "postId": postId,
      "type": isCurrentlyLiked ? "U" : "L"
    };

    final statusCode = await _uploadViewModel.like(data);

    if (statusCode == 201 || statusCode == 200) {
      setState(() {});
    }
  }

  void _onMorePressed(int postId, String action, UploadData data) {
    switch (action) {
      case Strings.saveImage:
        print('Save Image $postId');
        break;
      case Strings.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiaryRegisterPage(selectDate: selectedDate),
          ),
        );
        break;
      case Strings.delete:
        print('Post ID to delete: $postId');
        showDeleteDialog(postId);
        break;
      default:
        break;
    }
  }

  void _onProfilePressed(int userId, bool isOwn) {
    if (isOwn == true) {
      return;
    }

    print("Profile Pressed");
  }

  void showDeleteDialog(int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          height: ScreenUtil().setHeight(178.0),
          titleText: Strings.postDeleteTitle,
          guideText: Strings.postDeleteContent,
          yesCallback: () => onDeleteYes(context, postId),
          noCallback: () => onDeleteNo(context),
        );
      },
    );
  }

  void onDeleteYes(BuildContext context, int postId) async {
    final response = await _uploadViewModel.delete(postId.toString());

    if (response == 201) {
      if (mounted) {
        Navigator.pop(context);
        showCompleteDialog();
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
      print('삭제 실패: $response');
    }
  }

  void onDeleteNo(BuildContext context) {
    Navigator.pop(context);
  }

  void showCompleteDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const CompleteDialog(title: Strings.postDeleteComplete);
      },
    );
  }

  Widget _buildPostEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(50.0)),
          SvgPicture.asset(Images.postEmpty),
          SizedBox(height: ScreenUtil().setHeight(19.0)),
          Text(
            Strings.postEmptyGuide,
            style: TextStyle(
              color: const Color(UserColors.ui06),
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16.0),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const LoadingWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationAppBar(
        title: Strings.diary,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Consumer<DiaryViewModel>(
          builder: (context, diaryViewModel, child) {
            final diaries = diaryViewModel.getDiariesByDate(selectedDate);
            final myDiary = diaries.isNotEmpty ? diaries.first : null;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfoWidget(),
                  SizedBox(height: ScreenUtil().setHeight(36.0)),
                  _buildMonthChangeWidget(),
                  SizedBox(height: ScreenUtil().setHeight(12.0)),
                  _buildCalendarTypeContainerWidget(),
                  if (!showFeed) ...[
                    SizedBox(height: ScreenUtil().setHeight(18.0)),
                    (viewMonth)
                        ? MonthCalendarWidget(
                            currentDate: currentTime,
                            onDateSelected: onDateSelected,
                            userId: widget.userId,
                          )
                        : WeekCalendarWidget(
                            currentDate: currentTime,
                            onDateSelected: onDateSelected,
                            userId: widget.userId,
                          ),
                    SizedBox(height: ScreenUtil().setHeight(22.0)),
                    _buildPostingText(),
                    SizedBox(height: ScreenUtil().setHeight(19.0)),
                    _buildPostingWidget(),
                    SizedBox(height: ScreenUtil().setHeight(37.0)),
                    _buildDiaryText(),
                    SizedBox(height: ScreenUtil().setHeight(19.0)),
                    _buildDiaryWidget(myDiary),
                  ] else ...[
                    _buildFeedWidget(),
                  ],
                  SizedBox(height: ScreenUtil().setHeight(150.0)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
