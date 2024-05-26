import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/Colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:provider/provider.dart';

import '../../../vidw_model/diary_view_model.dart';

class WeekCalendarWidget extends StatefulWidget {
  final DateTime currentDate;

  const WeekCalendarWidget({Key? key, required this.currentDate})
      : super(key: key);

  @override
  State<WeekCalendarWidget> createState() => _WeekCalendarWidgetState();
}

class _WeekCalendarWidgetState extends State<WeekCalendarWidget> {
  DiaryViewModel? _diaryViewModel;
  DateTime? firstDayOfWeek;
  List<int>? daysList;
  Set<int>? recordedDays;
  DateTime? today;

  List<String> weekDays = [
    Strings.monday,
    Strings.tuesday,
    Strings.wednesday,
    Strings.thursday,
    Strings.friday,
    Strings.saturday,
    Strings.sunday
  ];

  @override
  void initState() {
    super.initState();
    firstDayOfWeek = widget.currentDate.subtract(Duration(days: widget.currentDate.weekday - 1));
    daysList = List<int>.generate(7, (index) {
      DateTime day = firstDayOfWeek!.add(Duration(days: index));
      return day.day;
    });

    today = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _diaryViewModel = Provider.of<DiaryViewModel>(context);

    final diaryEntries = _diaryViewModel!.diaryEntries;
    recordedDays = diaryEntries
        .where((entry) {
          DateTime entryDate = DateTime.parse(entry.setDate);
          return entryDate.isAfter(firstDayOfWeek!.subtract(const Duration(days: 1))) &&
              entryDate.isBefore(firstDayOfWeek!.add(const Duration(days: 7)));
        })
        .map((entry) => DateTime.parse(entry.setDate).day)
        .toSet();
  }

  Widget _buildDayWidget(int day, bool recorded, bool isToday) {
    return Column(
      children: [
        (recorded)
            ? SvgPicture.asset(Images.recordEnable)
            : SvgPicture.asset(Images.recordDisable),
        SizedBox(
          height: ScreenUtil().setHeight(4.0),
        ),
        Container(
          width: ScreenUtil().setWidth(20.0),
          height: ScreenUtil().setHeight(20.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday ? Colors.black : Colors.transparent,
          ),
          child: Center(
            child: Text(
              day.toString(),
              style: TextStyle(
                color: isToday ? Colors.white : const Color(UserColors.ui01),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(129.0),
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
                  .map((day) => Expanded(
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
                      ))
                  .toList(),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, childAspectRatio: 0.9),
                itemCount: 7,
                itemBuilder: (context, index) {
                  int day = daysList![index];
                  bool recorded = recordedDays!.contains(day);
                  bool isToday = (day == today!.day &&
                      widget.currentDate.month == today!.month &&
                      widget.currentDate.year == today!.year);
                  return _buildDayWidget(day, recorded, isToday);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
