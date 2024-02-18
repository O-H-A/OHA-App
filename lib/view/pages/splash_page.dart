import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/images.dart';
import 'package:provider/provider.dart';

import '../../app.dart';
import '../../vidw_model/location_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
 LocationViewModel _locationViewModel = LocationViewModel();

  @override
  void initState() {
    _locationViewModel = Provider.of<LocationViewModel>(context, listen: false);
    _locationViewModel.fetchAllDistricts();
    _locationViewModel.fetchFrequentDistricts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 3)).then((_) async {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const App()),
      );
    });
    return Scaffold(
      body: SvgPicture.asset(
        Images.splashBg,
        fit: BoxFit.cover,
      ),
    );
  }
}
