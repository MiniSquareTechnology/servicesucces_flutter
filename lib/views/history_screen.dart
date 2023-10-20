import 'package:employee_clock_in/res/utils/app_sizer.dart';
import 'package:employee_clock_in/res/utils/calendar_data.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateFormat dateFormat = DateFormat("d E");

  // DateFormat dateFormat2 = DateFormat("d");
  int listLength = -1;
  List<String> daysTitle = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: ColorPalette.appPrimaryColor,
            leading: Container(),
            centerTitle: true,
            title: Text(
              "Attendance History",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20.w),
                child: TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  headerVisible: true,
                  headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(
                        Icons.navigate_before_sharp,
                        color: Colors.black,
                        size: 30.w,
                      ),
                      rightChevronIcon: Icon(
                        Icons.navigate_next_sharp,
                        color: Colors.black,
                        size: 30.w,
                      )),
                  rowHeight: 40.h,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  rangeSelectionMode: _rangeSelectionMode,
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _rangeStart = null; // Important to clean those
                        _rangeEnd = null;
                        _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      });
                    }
                  },
                  onRangeSelected: (start, end, focusedDay) {
                    if (end != null) {
                      listLength = end.difference(start!).inDays;
                      AppLogger.logMessage(
                          "-=>$listLength ${dateFormat.format(start)} , ${dateFormat.format(end)} , $focusedDay");
                      daysTitle.clear();
                      List<DateTime>.generate(listLength + 1, (index) {
                        daysTitle.add(dateFormat
                            .format(start.add(Duration(days: index))));
                        return DateTime.now();
                      });
                    } else {
                      listLength = -1;
                    }

                    _selectedDay = null;
                    _focusedDay = focusedDay;
                    _rangeStart = start;
                    _rangeEnd = end;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;

                    setState(() {});
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              Container(
                height: 1.h,
                width: 1.0.sw,
                color: ColorPalette.appPrimaryColor,
                margin: EdgeInsets.symmetric(vertical: 10.h),
              ),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w),
                      itemCount: listLength + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (itemBuilderContext, index) {
                        return historyItemRow(
                            daysTitle.elementAt(index).split(" ")[0],
                            daysTitle.elementAt(index).split(" ")[1],
                            '09:10 AM',
                            '06:10 AM',
                            '09:00:00',
                            (index % 2 == 0)
                                ? ColorPalette.appPrimaryColor
                                : ColorPalette.appSecondaryColor);
                      })),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyItemRow(String date, String day, String checkIn,
      String checkOut, String totalHrs, Color dayBgColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        // border: Border.all(color: borderColor)
      ),
      margin: EdgeInsets.only(top: 8.h),
      child: Row(
        children: [
          Container(
            height: 55.w,
            width: 55.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorPalette.appPrimaryColor,
              // color: dayBgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  day,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 55.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: ColorPalette.appPrimaryColor.withOpacity(0.8),
                // color: dayBgColor.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  timerWidget(checkIn, "CheckIn"),
                  timerWidget(checkOut, "CheckOut"),
                  timerWidget(totalHrs, "Total Hrs"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timerWidget(String time, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          time,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ],
    );
  }
}
