import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PopularityTab extends StatefulWidget {
  const PopularityTab({super.key});

  @override
  State<PopularityTab> createState() => _PopularityTabState();
}

class _PopularityTabState extends State<PopularityTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
    );
  }
}