import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/job_history_response_model.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryDetailScreen extends StatefulWidget {
  final JobHistoryData data;

  const HistoryDetailScreen({super.key, required this.data});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPalette.appPrimaryColor,
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Get.back();
                }),
            centerTitle: true,
            title: Text(
              "Job History Detail",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mainItemRow('Job Id', '${widget.data.id}'),
                mainItemRow('Customer Name', '${widget.data.customerName}'),
                mainItemRow('Service Titan Number',
                    '${widget.data.serviceTitanNumber}'),
                mainItemRow('Dispatch Time', '${widget.data.dispatchTime}'),
                mainItemRow('Arrival Time', '${widget.data.arrivalTime}'),
                mainItemRow('Checkout Time', '${widget.data.checkoutTime}'),
                mainItemRow('Total Hours', '${widget.data.totalHours}'),
                if (widget.data.jobForm!.isNotEmpty) ...[
                  mainItemRow('Job Form Id', '${widget.data.jobForm![0].id}'),
                  mainItemRow(
                      'Total Amount', '${widget.data.jobForm![0].totalAmount}'),
                  mainItemRow(
                      'Commission', '${widget.data.jobForm![0].comission} %'),
                  mainItemRow(
                      'Job Status',
                      homeViewModel.jobStatusList[
                          widget.data.jobForm![0].status.toString()]!),
                  if (widget.data.jobForm![0].status
                          .toString()
                          .compareTo('6') ==
                      0)
                    mainItemRow('Commission Amount',
                        '${widget.data.jobForm![0].totalAmount! * widget.data.jobForm![0].comission! / 100}'),
                ],
              ],
            ),
          ),
        )));
  }

  Widget mainItemRow(String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 0.45.sw,
              decoration: BoxDecoration(
                  color: ColorPalette.appPrimaryColor,
                  borderRadius: BorderRadius.circular(0.r)),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: 0.44.sw,
              decoration: BoxDecoration(
                  color: ColorPalette.appPrimaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(0.r)),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Text(
                value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        Container(
          width: 1.0.sw,
          height: 1.0,
          color: ColorPalette.appSecondaryColor,
        ),
      ],
    );
  }
}
