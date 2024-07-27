import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oha/view_model/upload_view_model.dart';
import 'package:provider/provider.dart';

import '../app.dart';
import '../statics/strings.dart';
import '../view_model/location_view_model.dart';
import '../view_model/login_view_model.dart';
import '../view_model/weather_view_model.dart';
import '../view_model/my_page_view_model.dart';
import '../view/pages/login_page.dart';

class AppInitializer {
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> initialize(BuildContext context) async {
    await _initializeApp(context);
  }

  static Future<void> _initializeApp(BuildContext context) async {
    final locationViewModel =
        Provider.of<LocationViewModel>(context, listen: false);
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final weatherViewModel =
        Provider.of<WeatherViewModel>(context, listen: false);
    final myPageViewModel =
        Provider.of<MyPageViewModel>(context, listen: false);
    final uploadViewModel =
        Provider.of<UploadViewModel>(context, listen: false);

    try {
      final result = await loginViewModel.refresh();
      await _storage.write(
        key: Strings.accessTokenKey,
        value: loginViewModel.refreshData.data?.data.accessToken,
      );

      if (result == 401) {
        await _storage.deleteAll();
        _navigateToLoginPage(context);
      } else {
        await locationViewModel.fetchAllDistricts();
        await locationViewModel.fetchFrequentDistricts();
        await locationViewModel.getDefaultFrequentDistricts();
        await weatherViewModel.getDefaultWeather();
        await myPageViewModel.myInfo();
        // await uploadViewModel.myPosts();
        _checkLoginStatus(context);
      }
    } catch (error) {
      await _storage.write(key: Strings.loginKey, value: '');
      _navigateToLoginPage(context);
    }
  }

  static void _checkLoginStatus(BuildContext context) async {
    String? loginInfo = await _storage.read(key: Strings.loginKey);
    if (loginInfo == 'true') {
      _navigateToApp(context);
    } else {
      _navigateToLoginPage(context);
    }
  }

  static void _navigateToLoginPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  static void _navigateToApp(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const App()),
      );
    });
  }
}
