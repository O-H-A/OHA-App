import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // flutter_svg 패키지 추가
import 'package:provider/provider.dart';
import 'package:oha/models/upload/comment_read_model.dart';
import 'package:oha/view_model/upload_view_model.dart';
import '../../network/api_response.dart';
import '../../statics/images.dart';
import 'loading_widget.dart'; // 로딩 위젯 추가

class CommentSheet extends StatefulWidget {
  final int postId;

  const CommentSheet({super.key, required this.postId});

  @override
  _CommentSheetState createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  final ScrollController _scrollController = ScrollController();
  int _offset = 0;
  final int _pageSize = 10;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
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
    final uploadViewModel =
        Provider.of<UploadViewModel>(context, listen: false);
    await uploadViewModel.commentRead({
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
      padding: EdgeInsets.all(ScreenUtil().setWidth(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(18.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(10.0)),
          Expanded(
            child: Consumer<UploadViewModel>(
              builder: (context, uploadViewModel, child) {
                switch (uploadViewModel.commentReadData.status) {
                  case Status.loading:
                    return const LoadingWidget(); // 로딩 위젯 표시
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
                          return const LoadingWidget(); // 로딩 위젯 표시
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
        ],
      ),
    );
  }
}
