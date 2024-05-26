import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oha/statics/Colors.dart';
import 'package:oha/statics/images.dart';
import 'package:oha/statics/strings.dart';
import 'package:provider/provider.dart';

import '../../../vidw_model/diary_view_model.dart';

class MonthCalendarWidget extends StatefulWidget {
  final DateTime currentDate;

  const MonthCalendarWidget({Key? key, required this.currentDate}) : super(key: key);

  @override
  State<MonthCalendarWidget> createState() => _MonthCalendarWidgetState();
}

class _MonthCalendarWidgetState extends State<MonthCalendarWidget> {
  DiaryViewModel? _diaryViewModel;
  DateTime? firstDayOfMonth;
  int? firstWeekday;
  int? daysInMonth;
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

    firstDayOfMonth = DateTime(widget.currentDate.year, widget.currentDate.month, 1);
    firstWeekday = firstDayOfMonth!.weekday;

    daysInMonth = DateTime(widget.currentDate.year, widget.currentDate.month + 1, 0).day;

    daysList = List<int>.generate(daysInMonth!, (index) => index + 1);

    today = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _diaryViewModel = Provider.of<DiaryViewModel>(context);

    final diaryEntries = _diaryViewModel!.diaryEntries;
    recordedDays = diaryEntries
        .where((entry) => DateTime.parse(entry.setDate).month == widget.currentDate.month)
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
                itemCount: daysList!.length + firstWeekday! - 1,
                itemBuilder: (context, index) {
                  if (index < firstWeekday! - 1) {
                    return Container();
                  } else {
                    int day = index - firstWeekday! + 2;
                    bool isToday = (day == today!.day &&
                        widget.currentDate.month == today!.month &&
                        widget.currentDate.year == today!.year);
                    bool recorded = recordedDays!.contains(day);
                    return _buildDayWidget(day, recorded, isToday);
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
