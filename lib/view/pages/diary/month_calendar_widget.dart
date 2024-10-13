import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:provider/provider.dart';
import '../../../view_model/diary_view_model.dart';
import '../../../view_model/upload_view_model.dart';

class MonthCalendarWidget extends StatefulWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;
  final int? userId;

  const MonthCalendarWidget({
    Key? key,
    required this.currentDate,
    required this.onDateSelected,
    this.userId,
  }) : super(key: key);

  @override
  State<MonthCalendarWidget> createState() => _MonthCalendarWidgetState();
}

class _MonthCalendarWidgetState extends State<MonthCalendarWidget> {
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
    _updateCalendar();
  }

  @override
  void didUpdateWidget(covariant MonthCalendarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCalendar();
  }

  void _updateCalendar() {
    if (selectedDay == null ||
        selectedDay!.month != widget.currentDate.month ||
        selectedDay!.year != widget.currentDate.year) {
      selectedDay =
          DateTime(widget.currentDate.year, widget.currentDate.month, 1);
    }

    setState(() {
      firstDayOfMonth =
          DateTime(widget.currentDate.year, widget.currentDate.month, 1);
      firstWeekday = firstDayOfMonth!.weekday;
      daysInMonth =
          DateTime(widget.currentDate.year, widget.currentDate.month + 1, 0)
              .day;
      daysList = List<int>.generate(daysInMonth!, (index) => index + 1);
      recordedDays = {};

      if (widget.userId != null) {
        final diaryEntries = Provider.of<DiaryViewModel>(context, listen: false)
            .userDiaryEntries;
        final postEntries = Provider.of<UploadViewModel>(context, listen: false)
                .userUploadGetData
                .data
                ?.data ??
            [];

        for (var entry in diaryEntries) {
          final diaryDate = DateTime(
            int.parse(entry.setDate.substring(0, 4)),
            int.parse(entry.setDate.substring(4, 6)),
            int.parse(entry.setDate.substring(6, 8)),
          );
          if (diaryDate.month == widget.currentDate.month &&
              diaryDate.year == widget.currentDate.year) {
            recordedDays!.add(diaryDate.day);
          }
        }

        for (var entry in postEntries) {
          final postDate = DateTime.parse(entry.regDtm);
          if (postDate.month == widget.currentDate.month &&
              postDate.year == widget.currentDate.year) {
            recordedDays!.add(postDate.day);
          }
        }
      } else {
        final diaryEntries =
            Provider.of<DiaryViewModel>(context, listen: false).myDiaryEntries;
        final postEntries = Provider.of<UploadViewModel>(context, listen: false)
                .myUploadGetData
                .data
                ?.data ??
            [];

        for (var entry in diaryEntries) {
          final diaryDate = DateTime(
            int.parse(entry.setDate.substring(0, 4)),
            int.parse(entry.setDate.substring(4, 6)),
            int.parse(entry.setDate.substring(6, 8)),
          );

          if (diaryDate.month == widget.currentDate.month) {
            recordedDays!.add(diaryDate.day);
          }
        }

        for (var entry in postEntries) {
          final postDate = DateTime.parse(entry.regDtm);
          if (postDate.month == widget.currentDate.month) {
            recordedDays!.add(postDate.day);
          }
        }
      }

      today = DateTime.now();
    });
  }

  void _onDaySelected(int day) {
    DateTime selected =
        DateTime(widget.currentDate.year, widget.currentDate.month, day);

    setState(() {
      selectedDay = selected;
    });
    widget.onDateSelected(selectedDay!);
  }

  Widget _buildDayWidget(int day, bool recorded, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(18.0)),
      child: GestureDetector(
        onTap: () => _onDaySelected(day),
        child: Column(
          children: [
            recorded
                ? SvgPicture.asset(Images.recordEnable)
                : SvgPicture.asset(Images.recordDisable),
            SizedBox(height: ScreenUtil().setHeight(10.0)),
            Container(
              width: ScreenUtil().setWidth(18.0),
              height: ScreenUtil().setHeight(18.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.black : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(UserColors.ui01),
                    fontFamily: "Pretendard",
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(397.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(10.0)),
        color: Colors.white,
        border: Border.all(color: const Color(UserColors.ui11)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            offset: const Offset(0, 0),
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(12.0)),
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
                    crossAxisCount: 7, childAspectRatio: 0.7),
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
