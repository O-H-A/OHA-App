import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oha/view/pages/home_page.dart';
import 'package:oha/view/pages/mypage/delete_dialog.dart';
import 'package:provider/provider.dart';

import '../../../app.dart';
import '../../../statics/Colors.dart';
import '../../../statics/images.dart';
import '../../../statics/strings.dart';
import '../../../view_model/my_page_view_model.dart';
import '../../widgets/back_complete_app_bar.dart';
import '../../widgets/complete_dialog.dart';
import '../location/location_change_dialog.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _getProfileImage;
  final _textController = TextEditingController();
  MyPageViewModel _myPageViewModel = MyPageViewModel();

  @override
  void initState() {
    super.initState();

    _myPageViewModel = Provider.of<MyPageViewModel>(context, listen: false);
  }

  Future getProfileImage(ImageSource imageSource) async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: imageSource, imageQuality: 30);

    if (pickedFile != null) {
      setState(() {
        _getProfileImage = XFile(pickedFile.path);
      });
    }
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        getProfileImage(ImageSource.gallery);
      },
      child: _getProfileImage != null
          ? Container(
              width: ScreenUtil().setWidth(100.0),
              height: ScreenUtil().setHeight(100.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.file(File(_getProfileImage!.path)),
              ),
            )
          : (_myPageViewModel.myInfoData.data?.data.profileUrl?.isEmpty ?? true)
              ? SvgPicture.asset(Images.defaultProfile)
              : Container(
                  width: ScreenUtil().setWidth(100.0),
                  height: ScreenUtil().setHeight(100.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.network(
                      _myPageViewModel.myInfoData.data?.data.profileUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
    );
  }

  Widget _buildNickNameText() {
    return const Text(
      Strings.nickName,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w600,
          fontSize: 16),
    );
  }

  Widget _buildEditAreaWidget() {
    return SizedBox(
      height: ScreenUtil().setHeight(70.0),
      child: TextField(
        maxLines: null,
        minLines: null,
        controller: _textController,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          color: Color(UserColors.ui01),
          fontFamily: "Pretendard",
          fontWeight: FontWeight.w500,
          fontSize: 14,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(UserColors.ui11),
          hintText: Strings.nickNameEditHint,
          hintStyle: const TextStyle(
            color: Color(UserColors.ui06),
            fontFamily: "Pretendard",
            fontWeight: FontWeight.w500,
            fontSize: 14,
            decoration: TextDecoration.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_.]')),
        ],
      ),
    );
  }

  Widget _buildCurrentNickNameWidget() {
    return Row(
      children: [
       Text(
          Strings.currentNickName,
          style: TextStyle(
              color: const Color(UserColors.ui06),
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtil().setSp(12.0)),//
        ),
        Text(
          _myPageViewModel.myInfoData.data?.data.name ?? '',
          style: TextStyle(
              color: const Color(UserColors.ui06),
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w500,
              fontSize: ScreenUtil().setSp(12.0)),
        ),
      ],
    );
  }

  Widget _buildGuideContent() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              Strings.middlePoint + Strings.nickNameEditGuide1,
              style: TextStyle(
                  color: Color(UserColors.ui06),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(8.0)),
        Row(
          children: const [
            Text(
              Strings.middlePoint + Strings.nickNameEditGuide2,
              style: TextStyle(
                  color: Color(UserColors.ui06),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(8.0)),
        Row(
          children: const [
            Flexible(
              child: Text(
                Strings.middlePoint + Strings.nickNameEditGuide3,
                style: TextStyle(
                    color: Color(UserColors.ui06),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void nickNameChangeComplete() async {
    Map<String, dynamic> sendData = {"name": _textController.text};

    try {
      await _myPageViewModel.changeNickName(sendData);
      showCompleteDialog();
    } catch (error) {}
  }

  void showCompleteDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return const CompleteDialog(title: Strings.editCompleText);
      },
    );

    Navigator.pop(context);
  }

  void showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(
          height: ScreenUtil().setHeight(198.0),
          titleText: Strings.deleteChangeHistory,
          guideText: Strings.deleteChangeHistoryGuide,
          yesCallback: () => onChangeHistoryDeleteYes(context),
          noCallback: () => onChangeHistoryDeleteNo(context),
        );
      },
    );
  }

  void onChangeHistoryDeleteYes(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const App()),
      (Route<dynamic> route) => false,
    );
  }

  void onChangeHistoryDeleteNo(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackCompleteAppBar(
        title: Strings.profile,
        doneCallback: nickNameChangeComplete,
        backCallback: showDeleteDialog,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenUtil().setHeight(47.0)),
            Center(child: _buildProfileImage()),
            SizedBox(height: ScreenUtil().setHeight(22.0)),
            _buildNickNameText(),
            SizedBox(height: ScreenUtil().setHeight(12.0)),
            _buildEditAreaWidget(),
            SizedBox(height: ScreenUtil().setHeight(8.0)),
            _buildCurrentNickNameWidget(),
            SizedBox(height: ScreenUtil().setHeight(26.0)),
            _buildGuideContent(),
          ],
        ),
      ),
    );
  }
}
