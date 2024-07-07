import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/job_detail_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/message_widget.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryDetailScreen extends StatefulWidget {
  // final JobHistoryData data;
  final String jobId;

  // const HistoryDetailScreen({super.key, required this.data});
  const HistoryDetailScreen({super.key, required this.jobId});

  @override
  State<HistoryDetailScreen> createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
  JobDetailResponseModel? jobResponseModel;
  late HomeViewModel homeViewModel;
  int commentsLength = 0;
  List<EditJobs> comments = [];

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// remove fcm notification data
      AppPreferenceStorage.deleteKey(AppPreferenceStorage.fcmJobId);
      AppPreferenceStorage.deleteKey(AppPreferenceStorage.fcmType);
      getJobDetail();
    });
    super.initState();
  }

  getJobDetail() {
    // jobResponseModel = null;
    homeViewModel.getJobDetail(widget.jobId).then((value) {
      jobResponseModel = value;
      getCommentsSize();
      setState(() {});
    });
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
          body: jobResponseModel != null ? SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  mainItemRow(AppStringConstants.jobId, '${jobResponseModel?.data?.id}'),
                  mainItemRow(AppStringConstants.customerName,
                      '${jobResponseModel?.data?.customerName}'),
                  mainItemRow(AppStringConstants.serviceTitanNumber,
                      '${jobResponseModel?.data?.serviceTitanNumber}'),
                  mainItemRow(AppStringConstants.dispatchTime,
                      jobResponseModel?.data?.dispatchTime ?? '---'),
                  mainItemRow(AppStringConstants.arrivalTime,
                      jobResponseModel?.data?.arrivalTime ?? '---'),
                  mainItemRow(AppStringConstants.checkoutTime,
                      jobResponseModel?.data?.checkoutTime ?? '---'),
                  mainItemRow(AppStringConstants.totalHours,
                      jobResponseModel?.data?.totalHours ?? '---'),
                  if (jobResponseModel?.data?.jobForm != null &&
                      jobResponseModel!.data!.jobForm!.isNotEmpty) ...[
                    mainItemRow(AppStringConstants.jobFormId,
                        '${jobResponseModel?.data?.jobForm![0].id}'),
                    mainItemRow(AppStringConstants.totalAmount,
                        '${jobResponseModel?.data?.jobForm![0].totalAmount ?? 0}'),
                    mainItemRow(AppStringConstants.commission,
                        '${jobResponseModel?.data?.jobForm![0].comission ?? 0} %'),
                    mainItemRow(
                        AppStringConstants.jobStatus,
                        homeViewModel.jobStatusList[
                            jobResponseModel?.data?.jobForm![0].status.toString()]!),
                    if (jobResponseModel?.data?.jobForm![0].status
                            .toString()
                            .compareTo('6') ==
                        0)
                      mainItemRow(AppStringConstants.commissionAmount,
                          '${jobResponseModel?.data?.jobForm![0].totalAmount ?? 0 * (jobResponseModel?.data?.jobForm![0].comission ?? 0) / 100}'),
                  ],
                  SizedBox(height: 20.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStringConstants.comments,
                        style: TextStyle(
                            color: ColorPalette.appPrimaryColor,
                            fontSize: 20.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 1.0.sw,
                        height: 2,
                        color: ColorPalette.appPrimaryColor,
                        margin: EdgeInsets.only(top: 10.h),
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  for (int i = 0; i < commentsLength; i++) ...[commentItem(i)],
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RoutePathConstants.commentsListScreen,
                          arguments: {"jobData": jobResponseModel})?.then((value) {
                            if(value != null && value) {
                              getJobDetail();
                            }
                      });
                      // homeViewModel.showAllComments.value = true;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorPalette.appPrimaryColor,
                          // border: Border.all(
                          //     color: ColorPalette.appPrimaryColor, width: 1.w),
                          borderRadius: BorderRadius.circular(10.r)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                      margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            commentsLength > 0 ? AppStringConstants.seeAll : AppStringConstants.addComment,
                            style: TextStyle(
                                color: ColorPalette.white,
                                fontSize: 14.sp,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: ColorPalette.white,
                            size: 16.w,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ) : const SizedBox(height: 0, width: 0,),
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

  void getCommentsSize() {
    if(jobResponseModel?.data?.editJobs == null) {
      commentsLength = 0;
      return;
    }
    
    if (jobResponseModel!.data!.editJobs!.length > 4) {
      commentsLength = 4;
    } else {
      commentsLength = jobResponseModel!.data!.editJobs!.length;
    }

    comments.clear();
    /// get last four comments from list
    for (int i = commentsLength; i > 0; i--) {
      comments.add(jobResponseModel!.data!.editJobs!.elementAt((jobResponseModel!.data!.editJobs!.length) - i));
    }
  }

  /// comment widget
  Widget commentItem(int index) {
    EditJobs msgData = comments[index];
    bool isMyMsg = homeViewModel.userId.compareTo("${msgData.userId}") == 0;
    return MessageWidget(msgData: msgData, isMyMsg: isMyMsg);
  }
}
