import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../statics/images.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  int _currentIndex = 0;
  Timer? _timer;

  final List<String> _loadingImages = [
    Images.loading_1,
    Images.loading_2,
    Images.loading_3,
    Images.loading_4,
    Images.loading_5,
    Images.loading_6,
    Images.loading_7,
    Images.loading_8,
  ];

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _loadingImages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        _loadingImages[_currentIndex],
        width: ScreenUtil().setWidth(51.0),
        height: ScreenUtil().setHeight(51.0),
      ),
    );
  }
}
