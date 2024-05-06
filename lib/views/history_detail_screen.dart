import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/job_history_response_model.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
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
    // homeViewModel.showAllComments.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: ColorPalette.appPrimaryColor,
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Get.back();
                }),
            centerTitle: true,
            title: Text(
              AppStringConstants.jobHistoryDetail,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainItemRow(AppStringConstants.jobId, '${widget.data.id}'),
                  mainItemRow(AppStringConstants.customerName,
                      '${widget.data.customerName}'),
                  mainItemRow(AppStringConstants.serviceTitanNumber,
                      '${widget.data.serviceTitanNumber}'),
                  mainItemRow(AppStringConstants.dispatchTime,
                      widget.data.dispatchTime ?? '---'),
                  mainItemRow(AppStringConstants.arrivalTime,
                      widget.data.arrivalTime ?? '---'),
                  mainItemRow(AppStringConstants.checkoutTime,
                      widget.data.checkoutTime ?? '---'),
                  mainItemRow(AppStringConstants.totalHours,
                      widget.data.totalHours ?? '---'),
                  if (widget.data.jobForm != null &&
                      widget.data.jobForm!.isNotEmpty) ...[
                    mainItemRow(AppStringConstants.jobFormId,
                        '${widget.data.jobForm![0].id}'),
                    mainItemRow(AppStringConstants.totalAmount,
                        '${widget.data.jobForm![0].totalAmount ?? 0}'),
                    mainItemRow(AppStringConstants.commission,
                        '${widget.data.jobForm![0].comission ?? 0} %'),
                    mainItemRow(
                        AppStringConstants.jobStatus,
                        homeViewModel.jobStatusList[
                            widget.data.jobForm![0].status.toString()]!),
                    if (widget.data.jobForm![0].status
                            .toString()
                            .compareTo('6') ==
                        0)
                      mainItemRow(AppStringConstants.commissionAmount,
                          '${widget.data.jobForm![0].totalAmount ?? 0 * (widget.data.jobForm![0].comission ?? 0) / 100}'),
                  ],
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStringConstants.comments,
                        style: TextStyle(
                            color: ColorPalette.appPrimaryColor,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RoutePathConstants.commentsListScreen);
                          // homeViewModel.showAllComments.value = true;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: ColorPalette.appPrimaryColor,
                              border: Border.all(
                                  color: ColorPalette.appPrimaryColor,
                                  width: 1.w),
                              borderRadius: BorderRadius.circular(10.r)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 6.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppStringConstants.seeAll,
                                style: TextStyle(
                                    color: ColorPalette.appPrimaryColor,
                                    fontSize: 12.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: ColorPalette.appPrimaryColor,
                                size: 16.w,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  for (int i = 0; i < 3; i++) ...[
                    Align(
                      alignment: (i % 2) != 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: (i % 2) != 0
                                ? ColorPalette.appPrimaryColor.withOpacity(0.8)
                                : ColorPalette.appPrimaryColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        margin: EdgeInsets.only(
                          top: 6.h,
                          left: (i % 2) != 0 ? 0 : 0.4.sw,
                          right: (i % 2) != 0 ? 0.4.sw : 0,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.h),
                        child: Text(
                          "Test comment here regarding Job $i",
                          style: TextStyle(
                              color: ColorPalette.white,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ]
                ],
              ),
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
