import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/job_history_response_model.dart';
import 'package:employee_clock_in/res/utils/calendar_data.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/local_storage/image_storage.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

late HomeViewModel homeViewModel;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  // DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateFormat dateFormat = DateFormat("d E");

  // DateFormat dateFormat2 = DateFormat("d");
  // int listLength = -1;
  // List<String> daysTitle = [];
  DateTime now = DateTime.now();
  late DateTime startDateTime;
  late DateTime endDateTime;

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    startDateTime = DateTime(now.year, now.month, 1);
    endDateTime = now;

    _rangeStart = startDateTime;
    _rangeEnd = endDateTime;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getHistory(-1); // -1 for all
    });
    super.initState();
  }

  void getHistory(int status) {
    homeViewModel.getJobHistory(DateFormat('yyyy-MM-dd').format(startDateTime),
        DateFormat('yyyy-MM-dd').format(endDateTime), false, status);
  }

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
              AppStringConstants.attendanceHistory,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Get.toNamed(RoutePathConstants.historyFiltersScreen)
                      ?.then((value) {
                    if (value != null) {
                      getHistory(value);
                    }
                  });
                },
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
                    child: Image.asset(
                      ImageStorage.filterIcon,
                      height: 26.w,
                      width: 30.w,
                      fit: BoxFit.fill,
                    )),
              )
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TableCalendar(
                  firstDay: kFirstDay,
                  lastDay: DateTime.now(),
                  focusedDay: endDateTime,
                  calendarFormat: _calendarFormat,
                  headerVisible: true,
                  rowHeight: 40.h,
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  rangeSelectionMode: _rangeSelectionMode,
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
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    /* if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        startDateTime = selectedDay;
                        getHistory(-1);
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        _rangeStart = null; // Important to clean those
                        _rangeEnd = null;
                        _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      });
                    }*/
                  },
                  onRangeSelected: (start, end, focusedDay) {
                    if (end != null) {
                      startDateTime = start!;
                      endDateTime = end;

                      _rangeStart = startDateTime;
                      _rangeEnd = endDateTime;
                      getHistory(-1);

                      /* listLength = end.difference(start!).inDays;
                      AppLogger.logMessage(
                          "-=>$listLength ${dateFormat.format(start)} , ${dateFormat.format(end)} , $focusedDay");
                      daysTitle.clear();
                      List<DateTime>.generate(listLength + 1, (index) {
                        daysTitle.add(dateFormat
                            .format(start.add(Duration(days: index))));
                        return DateTime.now();
                      });*/
                    } else {
                      // listLength = -1;
                      if (start!.isBefore(startDateTime)) {
                        DateTime temp = startDateTime;
                        endDateTime = temp;
                        startDateTime = start;

                        _rangeStart = startDateTime;
                        _rangeEnd = endDateTime;
                      } else if (start.isBefore(endDateTime)) {
                        startDateTime = start;
                        endDateTime = endDateTime;

                        _rangeStart = startDateTime;
                        _rangeEnd = endDateTime;
                      } else {
                        DateTime temp = endDateTime;
                        startDateTime = temp;
                        endDateTime = start;

                        _rangeStart = startDateTime;
                        _rangeEnd = endDateTime;
                      }

                      getHistory(-1);
                    }

                    _selectedDay = null;
                    // _focusedDay = focusedDay;
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
                    // _focusedDay = focusedDay;
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
                  child: Obx(() => ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: homeViewModel.historyList.length,
                      // itemCount: listLength + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (itemBuilderContext, index) {
                        return historyItemRow(
                            homeViewModel.historyList.elementAt(index));
                      }))),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyItemRow(JobHistoryData data) {
    String? jobStatus;
    if (data.jobForm!.isNotEmpty) {
      jobStatus = data.jobForm!.elementAt(0).status!.toString();
    }

    return InkWell(
      onTap: () {
        Get.toNamed(RoutePathConstants.historyDetailScreen,
            arguments: {"id": '${data.id}'});
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          // border: Border.all(color: borderColor)
        ),
        margin: EdgeInsets.only(top: 8.h),
        child: Row(
          children: [
            Container(
              height: 62.w,
              width: 55.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: jobStatus != null && jobStatus.compareTo("6") == 0
                    ? ColorPalette.inHouseVetBg
                    : ColorPalette.appPrimaryColor,
                // color: dayBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                ),
              ),
              child: Text(
                '${data.id}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                height: 62.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: jobStatus != null && jobStatus.compareTo("6") == 0
                      ? ColorPalette.inHouseVetBg.withOpacity(0.8)
                      : ColorPalette.appPrimaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.customerName ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          data.serviceTitanNumber ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          child: Text(
                            jobStatus == null
                                ? AppStringConstants.noJobForm
                                : homeViewModel.jobStatusList[jobStatus]!,
                            style: TextStyle(
                                color: ColorPalette.appPrimaryColor
                                    .withOpacity(0.8),
                                fontSize: 10.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          data.totalHours ?? '',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
