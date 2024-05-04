import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/custom_widgets/radio_select_widget.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryFiltersScreen extends StatefulWidget {
  const HistoryFiltersScreen({super.key});

  @override
  State<HistoryFiltersScreen> createState() => _HistoryFiltersScreenState();
}

class _HistoryFiltersScreenState extends State<HistoryFiltersScreen> {
  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    // homeViewModel.jobStatusListFilterSelected.clear();
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
              AppStringConstants.historyFilters,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.getCommonSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(() => RadioSelectWidget(
                      label: 'All',
                      selected: homeViewModel.jobStatusListFilterSelected
                          .contains(-1),
                      index: -1,
                      onTap: (index) {
                        homeViewModel.updateJobStatusListFilterListValue(-1);
                      })),
                ),
                Container(
                  width: 1.0.sw,
                  height: 1.0,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  color: ColorPalette.appPrimaryColor,
                ),
                for (int i = 1; i <= homeViewModel.jobStatusList.length; i++)
                  Obx(() => Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: RadioSelectWidget(
                                label: homeViewModel.jobStatusList['$i'] ?? '',
                                selected: homeViewModel
                                    .jobStatusListFilterSelected
                                    .contains(i),
                                index: i,
                                onTap: (index) {
                                  homeViewModel
                                      .updateJobStatusListFilterListValue(
                                          index);
                                }),
                          ),
                          Container(
                            width: 1.0.sw,
                            height: 1.0,
                            margin: EdgeInsets.symmetric(vertical: 5.h),
                            color: i < homeViewModel.jobStatusList.length
                                ? ColorPalette.appPrimaryColor
                                : Colors.transparent,
                          ),
                        ],
                      )),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                Container(
                  width: 1.0.sw,
                  alignment: Alignment.center,
                  child: AppFilledButton(
                      text: AppStringConstants.apply,
                      onTap: () {
                        Get.back(
                            result: homeViewModel
                                    .jobStatusListFilterSelected.isNotEmpty
                                ? homeViewModel.jobStatusListFilterSelected
                                    .elementAt(0)
                                : -1);
                        // saveBtnClick();
                      }),
                ),
                context.getCommonSizedBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
