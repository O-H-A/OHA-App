import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/models/upload/upload_get_model.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/view/pages/login_page.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../vidw_model/location_view_model.dart';
import '../../vidw_model/upload_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LocationViewModel _locationViewModel = LocationViewModel();
  UploadViewModel _uploadGetModel = UploadViewModel();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    _uploadGetModel = Provider.of<UploadViewModel>(context, listen: false);
    _locationViewModel.fetchAllDistricts();
    _locationViewModel.fetchFrequentDistricts();
    _locationViewModel.getDefaultFrequentDistricts();
    _uploadGetModel.posts();
    super.initState();

    Future.delayed(const Duration(seconds: 3), _checkLoginStatus);
  }

  void _checkLoginStatus() async {
    String? loginInfo = await _storage.read(key: 'login');
    if (!mounted) return;

    if (loginInfo == 'true') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset(
        Images.splashBg,
        fit: BoxFit.cover,
      ),
    );
  }
}
