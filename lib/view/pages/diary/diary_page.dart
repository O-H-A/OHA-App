import 'package:flutter/material.dart';
import 'package:oha/view/pages/diary/calendar_widget.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  DateTime setTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            CalendarWidget(currentDate: setTime),
          ],
        ),
      ),
    );
  }
}
