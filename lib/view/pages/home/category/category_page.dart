import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
import '../../mypage/delete_dialog.dart';
import '../../error_page.dart';
import 'category_grid_widget.dart';

enum ViewType {
  gridView,
  listView,
}

class CategoryPage extends StatefulWidget {
  final int categoryIndex;

  const CategoryPage({Key? key, required this.categoryIndex}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  ViewType viewType = ViewType.gridView;
  late UploadViewModel _uploadViewModel;
  late LocationViewModel _locationViewModel;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  int _offset = 0;
  final int _pageSize = 10;
  List<String> imageS = [];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _uploadViewModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);

    tabController = TabController(
      length: 6,
      vsync: this,
      initialIndex: widget.categoryIndex,
      animationDuration: const Duration(milliseconds: 300),
    );

    _loadInitialData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore) {
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    Map<String, dynamic> sendData = {
      "regionCode": _locationViewModel.getDefaultLocationCode,
      "offset": _offset.toString(),
      "size": _pageSize.toString(),
    };

    try {
      await _uploadViewModel.posts(sendData);
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
    };

    try {
      await _uploadViewModel.posts(sendData, append: true);
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

  Widget _buildTabBarWidget() {
    double tabWidth = ScreenUtil().setWidth(390.0) / 6.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: TabBar(
        labelPadding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(7.0)),
        controller: tabController,
        isScrollable: true,
        onTap: (index) {
          setState(() {
            _offset = 0; // Reset offset when tab changes
            _loadInitialData();
          });
        },
        tabs: <Widget>[
          SizedBox(width: tabWidth, child: const Tab(text: Strings.cloud)),
          SizedBox(width: tabWidth, child: const Tab(text: Strings.moon)),
          SizedBox(width: tabWidth, child: const Tab(text: Strings.rainbow)),
          SizedBox(
              width: tabWidth, child: const Tab(text: Strings.sunsetSunrise)),
          SizedBox(width: tabWidth, child: const Tab(text: Strings.nightSky)),
          SizedBox(width: tabWidth, child: const Tab(text: Strings.sunnySky)),
        ],
        labelColor: const Color(0xFF333333),
        labelStyle: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelColor: const Color(0xFF444444),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Pretendard",
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        overlayColor: const MaterialStatePropertyAll(Colors.white),
        indicatorColor: Colors.black,
        indicatorWeight: 2,
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

  Widget _buildCompleteWidget(List<UploadData> dataList) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: dataList.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == dataList.length) {
          return _buildLoadingWidget();
        }

        var data = dataList[index];
        return FeedWidget(
          postId: data.postId,
          nickName: data.userName,
          locationInfo: data.locationDetail,
          likesCount: data.likeCount,
          commentCount: data.commentCount,
          isLike: data.isLike,
          description: data.content,
          hashTag: data.keywords,
          imageUrl: data.files.isNotEmpty ? data.files[0].url : '',
          onLikePressed: () => _onLikePressed(data.postId, data.isLike),
          onMorePressed: () => FourMoreDialog.show(
              context,
              (action) => _onMorePressed(data.postId, action),
              data.isOwn,
              data.files.isNotEmpty ? data.files[0].url : ''),
        );
      },
    );
  }

  Widget _buildGridCompleteWidget(List<UploadData> dataList) {
    List<String> imageList =
        dataList.map((UploadData data) => data.thumbnailUrl).toList();
    return CategoryGridWidget(imageList: imageList, dataList: dataList);
  }

  Widget _buildBody() {
    return Consumer<UploadViewModel>(
      builder: (context, uploadViewModel, child) {
        var dataList = uploadViewModel.uploadGetData.data?.data ?? [];
        var filteredList = dataList.where((data) {
          var selectedCategory = Strings.categoryMap[tabController.index];
          return data.categoryCode == selectedCategory;
        }).toList();

        switch (uploadViewModel.uploadGetData.status) {
          case Status.loading:
            return _buildLoadingWidget();
          case Status.complete:
            return filteredList.isEmpty
                ? _buildPostEmptyWidget()
                : viewType == ViewType.gridView
                    ? _buildGridCompleteWidget(filteredList)
                    : _buildCompleteWidget(filteredList);
          case Status.error:
          default:
            _navigateToErrorPage(context);
            return Container();
        }
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

    if (statusCode == 201) {
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

  Widget _buildTypeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(22.0)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                viewType = ViewType.gridView;
              });
            },
            child: (viewType == ViewType.gridView)
                ? SvgPicture.asset(Images.viewGridEnable)
                : SvgPicture.asset(Images.viewGridDisable),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                viewType = ViewType.listView;
              });
            },
            child: (viewType == ViewType.listView)
                ? SvgPicture.asset(Images.viewListEnable)
                : SvgPicture.asset(Images.viewListDisable),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: ScreenUtil().statusBarHeight),
          _buildTabBarWidget(),
          SizedBox(height: ScreenUtil().setHeight(34.0)),
          _buildTypeWidget(),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }
}
