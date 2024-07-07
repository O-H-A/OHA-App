import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/view/widgets/button_image.dart';
import 'package:provider/provider.dart';
import 'package:oha/models/upload/comment_read_model.dart';
import 'package:oha/view_model/upload_view_model.dart';
import '../../network/api_response.dart';
import '../../statics/Colors.dart';
import '../../statics/images.dart';
import '../../statics/strings.dart';
import 'loading_widget.dart';

class CommentSheet extends StatefulWidget {
  final int postId;

  const CommentSheet({super.key, required this.postId});

  @override
  _CommentSheetState createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  int _offset = 0;
  final int _pageSize = 10;
  bool _isLoadingMore = false;
  UploadViewModel _uploadViewModel = UploadViewModel();

  @override
  void initState() {
    super.initState();
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);

    _loadInitialComments();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore) {
        _loadMoreComments();
      }
    });
  }

  Future<void> _loadInitialComments() async {
    await _uploadViewModel.commentRead({
      "postId": widget.postId.toString(),
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
    });
  }

  Future<void> _loadMoreComments() async {
    setState(() {
      _isLoadingMore = true;
    });

    _offset += _pageSize;

    final uploadViewModel =
        Provider.of<UploadViewModel>(context, listen: false);
    await uploadViewModel.commentRead({
      "postId": widget.postId,
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
    });

    setState(() {
      _isLoadingMore = false;
    });
  }

  Future<void> _commentWrite() async {
    if(_textController.text.isEmpty) {
      return;
    }

    Map<String, dynamic> sendData = {
      Strings.poistIdKey: widget.postId,
      Strings.contentKey: _textController.text,
    };

    try {
      await _uploadViewModel.commentWrite(sendData);
      _textController.clear();
      _focusNode.unfocus();
    } catch (error) {
      // _navigateToErrorPage(context);
    } finally {
      setState(() {
        // _isLoadingMore = false;
      });
    }
  }

  Widget _buildSMIndicator() {
    return Center(
      child: Container(
        width: ScreenUtil().setWidth(67.0),
        height: ScreenUtil().setHeight(5.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }

  Widget _buildCommentText() {
    return Text(
      Strings.comment,
      style: TextStyle(
        fontFamily: "Pretendard",
        color: Colors.black,
        fontSize: ScreenUtil().setSp(20.0),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildCommentWidget() {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(94.0),
      child: Row(
        children: [],
      ),
    );
  }

  Widget _buildAddCommentArea() {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(100.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: SvgPicture.asset(Images.commentDefaultProfile),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(9.0)),
                child: Container(
                  height: ScreenUtil().setHeight(50.0),
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(8.0)),
                  decoration: BoxDecoration(
                    color: Color(UserColors.ui11),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _textController,
                    maxLines: null,
                    minLines: 1,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          _focusNode.hasFocus ? '' : Strings.addCommentGuide,
                      hintStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(14.0),
                        fontFamily: "Pretendard",
                        color: const Color(UserColors.ui06),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14.0),
                      fontFamily: "Pretendard",
                      color: const Color(UserColors.ui01),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            ButtonImage(
                imagePath: Images.commentUpload,
                callback: () => _commentWrite()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: ScreenUtil().setHeight(19.0)),
          _buildSMIndicator(),
          SizedBox(height: ScreenUtil().setHeight(19.0)),
          _buildCommentText(),
          SizedBox(height: ScreenUtil().setHeight(10.0)),
          Expanded(
            child: Consumer<UploadViewModel>(
              builder: (context, uploadViewModel, child) {
                switch (uploadViewModel.commentReadData.status) {
                  case Status.loading:
                    return const LoadingWidget();
                  case Status.complete:
                    var comments =
                        uploadViewModel.commentReadData.data?.data ?? [];
                    if (comments.isEmpty) {
                      return Center(
                        child: SvgPicture.asset(Images.commentEmpty),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: comments.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == comments.length) {
                          return const LoadingWidget();
                        }

                        var comment = comments[index];
                        return ListTile(
                          title: Text(comment.userNickname ?? 'Unknown'),
                          subtitle: Text(comment.content ?? 'No content'),
                        );
                      },
                    );
                  case Status.error:
                    return Center(child: Text('Error loading comments'));
                  default:
                    return Container();
                }
              },
            ),
          ),
          _buildAddCommentArea(),
        ],
      ),
    );
  }
}
