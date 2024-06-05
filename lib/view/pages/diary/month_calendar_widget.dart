import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/Colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:provider/provider.dart';

import '../../../vidw_model/diary_view_model.dart';
import 'diary_register_page.dart';

class MonthCalendarWidget extends StatefulWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;

  const MonthCalendarWidget({
    Key? key,
    required this.currentDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<MonthCalendarWidget> createState() => _MonthCalendarWidgetState();
}

class _MonthCalendarWidgetState extends State<MonthCalendarWidget> {
  DiaryViewModel _diaryViewModel = DiaryViewModel();
  DateTime? firstDayOfMonth;
  int? firstWeekday;
  int? daysInMonth;
  List<int>? daysList;
  Set<int>? recordedDays;
  DateTime? today;
  DateTime? selectedDay;

  List<String> weekDays = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday,
  ];

  @override
  void initState() {
    super.initState();
    _diaryViewModel = Provider.of<DiaryViewModel>(context, listen: false);
    _updateCalendar();
  }

  @override
  void didUpdateWidget(covariant MonthCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentDate != widget.currentDate) {
      _updateCalendar();
    }
  }

  void _updateCalendar() {
    setState(() {
      firstDayOfMonth = DateTime(widget.currentDate.year, widget.currentDate.month, 1);
      firstWeekday = firstDayOfMonth!.weekday;
      daysInMonth = DateTime(widget.currentDate.year, widget.currentDate.month + 1, 0).day;
      daysList = List<int>.generate(daysInMonth!, (index) => index + 1);

      final diaryEntries = _diaryViewModel.diaryEntries;
      recordedDays = diaryEntries
          .where((entry) => DateTime.parse(entry.setDate).month == widget.currentDate.month)
          .map((entry) => DateTime.parse(entry.setDate).day)
          .toSet();

      today = DateTime.now();
      selectedDay = today;
    });
  }

  void _onDaySelected(int day) {
    DateTime selected = DateTime(widget.currentDate.year, widget.currentDate.month, day);
    bool isRecord = recordedDays!.contains(day);

    setState(() {
      selectedDay = selected;
    });
    widget.onDateSelected(selectedDay!);

    if (!isRecord) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DiaryRegisterPage(selectDate: selected),
        ),
      );
    }
  }

  Widget _buildDayWidget(int day, bool recorded, bool isSelected) {
    return GestureDetector(
      onTap: () => _onDaySelected(day),
      child: Column(
        children: [
          recorded ? SvgPicture.asset(Images.recordEnable) : SvgPicture.asset(Images.recordDisable),
          SizedBox(
            height: ScreenUtil().setHeight(4.0),
          ),
          Container(
            width: ScreenUtil().setWidth(20.0),
            height: ScreenUtil().setHeight(20.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.black : Colors.transparent,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : const Color(UserColors.ui01),
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(389.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui11)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(20.0)),
        child: Column(
          children: [
            Row(
              children: weekDays
                  .map(
                    (day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: Color(UserColors.ui01),
                            fontFamily: "Pretendard",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 0.9,
                ),
                itemCount: daysList!.length + firstWeekday! - 1,
                itemBuilder: (context, index) {
                  if (index < firstWeekday! - 1) {
                    return Container();
                  } else {
                    int day = index - firstWeekday! + 2;
                    bool isSelected = (day == selectedDay!.day &&
                        widget.currentDate.month == selectedDay!.month &&
                        widget.currentDate.year == selectedDay!.year);
                    bool recorded = recordedDays!.contains(day);
                    return _buildDayWidget(day, recorded, isSelected);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
