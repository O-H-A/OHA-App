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
import '../../vidw_model/login_view_model.dart';
import '../../vidw_model/upload_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LocationViewModel _locationViewModel = LocationViewModel();
  LoginViewModel _loginViewModel = LoginViewModel();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    _loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    _loginViewModel.refresh();
    _locationViewModel.fetchAllDistricts();
    _locationViewModel.fetchFrequentDistricts();
    _locationViewModel.getDefaultFrequentDistricts();
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
