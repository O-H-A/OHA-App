import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../statics/Colors.dart';
import '../../../../statics/images.dart';
import '../../../../statics/strings.dart';
import '../../../../vidw_model/location_view_model.dart';
import '../../../../vidw_model/upload_view_model.dart';
import '../../../widgets/feed_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  UploadViewModel _uploadViewModel = UploadViewModel();
  LocationViewModel _locationViewModel = LocationViewModel();

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
            child: ListView.builder(
              itemCount: _uploadViewModel.uploadGetData.data?.data.length,
              itemBuilder: (BuildContext context, int index) {
                return FeedWidget(
                  nickName: _uploadViewModel
                          .uploadGetData.data?.data[index].userNickname ??
                      '',
                  locationInfo: _uploadViewModel
                          .uploadGetData.data?.data[index].locationDetail ??
                      '',
                  likesCount: _uploadViewModel
                          .uploadGetData.data?.data[index].likeCount ??
                      0,
                  description: _uploadViewModel
                          .uploadGetData.data?.data[index].content ??
                      '',
                  hashTag: _uploadViewModel
                          .uploadGetData.data?.data[index].keywords ??
                      [],
                  imageUrl: _uploadViewModel
                      .uploadGetData.data?.data[index].files[0].url ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
