import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../statics/Colors.dart';
import '../../statics/strings.dart';
import 'infinity_button.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();

  static Future<String?> show(BuildContext context) async {
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(53.0),
                  left: ScreenUtil().setWidth(22.0),
                  right: ScreenUtil().setWidth(22.0)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const DatePicker(),
            ),
          ),
        );
      },
    );
  }
}

class _DatePickerState extends State<DatePicker> {
  final List<String> _dateList = [];
  late FixedExtentScrollController _scrollController;
  int _selectedIndex = 0;
  final DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _generateDateList();
    _selectedIndex = _dateList.indexOf(_formatDate(_today));
    _scrollController =
        FixedExtentScrollController(initialItem: _selectedIndex);
  }

  void _generateDateList() {
    final startDate = DateTime(_today.year - 10, _today.month, _today.day);
    final endDate = DateTime(_today.year + 10, _today.month, _today.day);

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      _dateList.add(_formatDate(currentDate));
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  bool _isToday(String date) {
    final parts = date.split(' ');
    final year = int.parse(parts[0].substring(0, parts[0].length - 1));
    final month = int.parse(parts[1].substring(0, parts[1].length - 1));
    final day = int.parse(parts[2].substring(0, parts[2].length - 1));
    final dateTime = DateTime(year, month, day);
    return dateTime.year == _today.year &&
        dateTime.month == _today.month &&
        dateTime.day == _today.day;
  }

  String _formatDate(DateTime date) {
    return '${date.year}년 ${date.month}월 ${date.day}일';
  }

  void _selectDateAndScroll(int index) {
    setState(() {
      _selectedIndex = index;
      _scrollController.animateToItem(
        _selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: ScreenUtil().setHeight(250.0),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(10.0),
              vertical: ScreenUtil().setHeight(15.0)),
          child: Column(
            children: [
              SizedBox(height: ScreenUtil().setHeight(29.0)),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _scrollController,
                  itemExtent: 35,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= _dateList.length) {
                        return null;
                      }
                      final isSelected = index == _selectedIndex;
                      return GestureDetector(
                        onTap: () => _selectDateAndScroll(index),
                        child: Container(
                          color: isSelected
                              ? const Color(UserColors.ui11)
                              : Colors.transparent,
                          child: Center(
                            child: Text(
                              _dateList[index],
                              style: TextStyle(
                                  fontSize: isSelected
                                      ? ScreenUtil().setSp(20.0)
                                      : ScreenUtil().setSp(16.0),
                                  fontFamily: "Pretendard",
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.black
                                      : const Color(UserColors.ui04)),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _dateList.length,
                  ),
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(29.0)),
              InfinityButton(
                height: ScreenUtil().setHeight(50.0),
                radius: ScreenUtil().radius(8.0),
                backgroundColor: const Color(UserColors.primaryColor),
                text: Strings.complete,
                textSize: ScreenUtil().setSp(16.0),
                textWeight: FontWeight.w600,
                textColor: Colors.white,
                callback: () {
                  final selectedDate = _dateList[_selectedIndex];
                  Navigator.of(context).pop(selectedDate);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
