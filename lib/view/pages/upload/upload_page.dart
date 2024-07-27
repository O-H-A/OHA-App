import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oha/view/pages/upload/upload_image_widget.dart';
import 'package:oha/view/pages/upload/upload_write_page.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../statics/Colors.dart';
import '../../../statics/strings.dart';
import '../../widgets/infinity_button.dart';
import 'album.dart';

class UploadPage extends StatefulWidget {
  final bool isDiary;

  const UploadPage({super.key, this.isDiary = false});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<AssetPathEntity>? _paths;
  List<Album> _albums = [];
  late List<AssetEntity> _media;
  int _currentPage = 0;
  late Album _currentAlbum;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void showWritePage() {
    if (widget.isDiary) {
      Navigator.pop(context, _media[_selectedIndex]);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadWritePage(
            selectMedia: _media[_selectedIndex],
          ),
        ),
      );
    }
  }

  Future<void> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      await getAlbum();
    } else {
      await PhotoManager.openSetting();
    }
  }

  Future<void> getAlbum() async {
    _paths = await PhotoManager.getAssetPathList(
      type: RequestType.common,
    );

    _albums = await Future.wait(_paths!.map((e) async {
      final count = await e.assetCountAsync;
      return Album(
        id: e.id,
        name: e.isAll ? Strings.allAlbum : e.name,
        count: count,
      );
    }));

    await getPhotos(_albums[0], albumChange: true);
  }

  Future<void> getPhotos(
    Album album, {
    bool albumChange = false,
  }) async {
    _currentAlbum = album;
    albumChange ? _currentPage = 0 : _currentPage++;

    final loadMedia = await _paths!
        .singleWhere((element) => element.id == album.id)
        .getAssetListPaged(
          page: _currentPage,
          size: album.count,
        );

    setState(() {
      if (albumChange) {
        _media = loadMedia;
      } else {
        _media.addAll(loadMedia);
      }
    });
  }

  void _setSelectedIndex(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: _albums.isNotEmpty
            ? DropdownButton(
                icon: const Icon(Icons.expand_more_rounded),
                underline: Container(),
                value: _currentAlbum,
                items: _albums
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: "Pretendard",
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ))
                    .toList(),
                onChanged: (value) => getPhotos(value!, albumChange: true),
              )
            : const SizedBox(),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(22.0)),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: _paths == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child: UploadImageWidget(
                  media: _media,
                  onSelectedIndexChanged: _setSelectedIndex,
                )),
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(40.0),
                      bottom: ScreenUtil().setHeight(120.0),
                      left: ScreenUtil().setWidth(22.0),
                      right: ScreenUtil().setWidth(22.0)),
                  child: InfinityButton(
                    height: ScreenUtil().setHeight(50.0),
                    radius: 8.0,
                    backgroundColor: const Color(UserColors.primaryColor),
                    text: Strings.next,
                    textSize: 16,
                    textWeight: FontWeight.w600,
                    textColor: Colors.white,
                    callback: showWritePage,
                  ),
                ),
              ],
            ),
    );
  }
}
