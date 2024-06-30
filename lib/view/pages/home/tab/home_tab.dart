import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
import '../../mypage/delete_dialog.dart';
import '../../error_page.dart'; // ErrorPage import

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late UploadViewModel _uploadViewModel;
  late LocationViewModel _locationViewModel;

  @override
  void initState() {
    super.initState();
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    Map<String, dynamic> sendData = {
      "regionCode": _locationViewModel.getDefaultLocationCode,
      "offset": "0",
      "size": "10",
    };

    _uploadViewModel.posts(sendData).catchError((error) {
      _navigateToErrorPage(context);
    });
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
    print("Like pressed for postId: $postId");

    Map<String, dynamic> data = {
      "postId": postId,
      "type": isCurrentlyLiked ? "U" : "L"
    };

    final statusCode = await _uploadViewModel.like(data);

    if (statusCode == 200) {
      setState(() {});
    }
  }

  void _onMorePressed(int postId, String action) {
    switch (action) {
      case Strings.saveImage:
        print('Save Image $postId');
        break;
      case Strings.edit:
        print('Edit $postId');
        break;
      case Strings.delete:
        print('Post ID to delete: $postId');
        showDeleteDialog(postId);
        break;
      default:
        break;
    }
  }

  void showDeleteDialog(int postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
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

    if (response == 200) {
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
        var dataList = uploadViewModel.uploadGetData.data?.data ?? [];
        if (dataList.isEmpty) {
          return _buildPostEmptyWidget();
        } else {
          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              var data = dataList[index];
              return FeedWidget(
                postId: data.postId,
                nickName: data.userNickname,
                locationInfo: data.locationDetail,
                likesCount: data.likeCount,
                isLike: data.isLike,
                description: data.content,
                hashTag: data.keywords,
                imageUrl: data.files.isNotEmpty ? data.files[0].url : '',
                onLikePressed: () => _onLikePressed(data.postId, data.isLike),
                onMorePressed: () => FourMoreDialog.show(
                    context, (action) => _onMorePressed(data.postId, action)),
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
        switch (uploadViewModel.uploadGetData.status) {
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
}
