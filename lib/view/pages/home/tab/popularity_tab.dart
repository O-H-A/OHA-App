import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../../../models/upload/upload_get_model.dart';
import '../../../../network/api_response.dart';
import '../../../../statics/colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../../view_model/location_view_model.dart';
import '../../../../view_model/upload_view_model.dart';
import '../../../widgets/complete_dialog.dart';
import '../../../widgets/feed_widget.dart';
import '../../../widgets/four_more_dialog.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/delete_dialog.dart';
import '../../error_page.dart';
import '../../upload/upload_write_page.dart';

class PopularityTab extends StatefulWidget {
  const PopularityTab({super.key});

  @override
  State<PopularityTab> createState() => _PopularityTabState();
}

class _PopularityTabState extends State<PopularityTab> {
  late UploadViewModel _uploadViewModel;
  late LocationViewModel _locationViewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _offset = 0;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    _loadInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore) {
        _loadMoreData();
      }
    });
  }

  Future<void> _loadInitialData() async {
    Map<String, dynamic> sendData = {
      "regionCode": _locationViewModel.getDefaultLocationCode,
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
      "popular": "true", // 인기 데이터 플래그 추가
    };

    try {
      await _uploadViewModel.popularPosts(sendData);
    } catch (error) {
      _navigateToErrorPage(context);
    }
  }

  Future<void> _loadMoreData() async {
    setState(() {
      _isLoadingMore = true;
    });

    _offset += _pageSize;

    Map<String, dynamic> sendData = {
      "regionCode": _locationViewModel.getDefaultLocationCode,
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
      "popular": "true", // 인기 데이터 플래그 추가
    };

    try {
      await _uploadViewModel.popularPosts(sendData, append: true);
    } catch (error) {
      _navigateToErrorPage(context);
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _navigateToErrorPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ErrorPage(isNetworkError: false),
      ),
    );
  }

  void _onLikePressed(int postId, bool isCurrentlyLiked) async {
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
        break;
      case Strings.edit:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadWritePage(
              isEdit: true,
              uploadData: data,
            ),
          ),
        );
        break;
      case Strings.delete:
        showYesNoDialog(postId);
        break;
      default:
        break;
    }
  }

  void showYesNoDialog(int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return YesNoDialog(
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

  Widget _buildTodaySkyText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: const Text(
        Strings.todaySky,
        style: TextStyle(
          fontFamily: "Pretendard",
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(UserColors.ui01),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const LoadingWidget();
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

  Widget _buildCompleteWidget() {
    return Consumer<UploadViewModel>(
      builder: (context, uploadViewModel, child) {
        var dataList = uploadViewModel.popularUploadGetData.data?.data ?? [];
        if (dataList.isEmpty) {
          return _buildPostEmptyWidget();
        } else {
          return ListView.builder(
            controller: _scrollController,
            itemCount: dataList.length + (_isLoadingMore ? 1 : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index == dataList.length) {
                return _buildLoadingWidget();
              }

              var data = dataList[index];
              return FeedWidget(
                uploadData: data,
                onLikePressed: () => _onLikePressed(data.postId, data.isLike),
                onMorePressed: () => FourMoreDialog.show(
                    context,
                    (action) => _onMorePressed(data.postId, action, data),
                    data.isOwn,
                    data.files.isNotEmpty ? data.files[0].url : '',
                    data.postId),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return Consumer<UploadViewModel>(
      builder: (context, uploadViewModel, child) {
        switch (uploadViewModel.popularUploadGetData.status) {
          case Status.loading:
            return _buildLoadingWidget();
          case Status.complete:
            return _buildCompleteWidget();
          case Status.error:
          default:
            _navigateToErrorPage(context);
            return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildTodaySkyText(),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
