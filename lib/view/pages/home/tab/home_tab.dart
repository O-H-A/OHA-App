import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../../vidw_model/location_view_model.dart';
import '../../../../vidw_model/upload_view_model.dart';
import '../../../widgets/complete_dialog.dart';
import '../../../widgets/feed_widget.dart';
import '../../../widgets/four_more_dialog.dart';
import '../../mypage/delete_dialog.dart';

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
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    super.initState();

    Map<String, dynamic> sendData = {
      "regionCode": _locationViewModel.getDefaultLocationCode,
      "offset": "0",
      "size": "10",
    };

    _uploadViewModel.posts(sendData);
  }

  void _onLikePressed() {}

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
    print('Confirmed delete for post ID: $postId');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          _buildTodaySkyText(),
          SizedBox(height: ScreenUtil().setHeight(12.0)),
          Expanded(
            child: Consumer<UploadViewModel>(
              builder: (context, uploadViewModel, child) {
                var dataList = uploadViewModel.uploadGetData.data?.data ?? [];
                return ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = dataList[index];
                    return FeedWidget(
                      postId: data.postId,
                      nickName: data.userNickname,
                      locationInfo: data.locationDetail,
                      likesCount: data.likeCount,
                      description: data.content,
                      hashTag: data.keywords,
                      imageUrl: data.files[0].url,
                      onLikePressed: _onLikePressed,
                      onMorePressed: () => FourMoreDialog.show(context,
                          (action) => _onMorePressed(data.postId, action)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
