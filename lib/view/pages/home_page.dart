import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Test",
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(width: 4.0),
            Icon(Icons.expand_more, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.image), onPressed: null),
          IconButton(icon: Icon(Icons.search), onPressed: null),
        ],
      ),
    );
  }
}
