import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NowWeatherTab extends StatefulWidget {
  const NowWeatherTab({super.key});

  @override
  State<NowWeatherTab> createState() => _NowWeatherTabState();
}

class _NowWeatherTabState extends State<NowWeatherTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
    );
  }
}