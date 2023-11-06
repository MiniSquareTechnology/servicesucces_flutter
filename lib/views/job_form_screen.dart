import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobFormScreen extends StatefulWidget {
  const JobFormScreen({super.key});

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  late HomeViewModel homeViewModel;
  List<int> jobPercentageList = [5, 7, 8, 10];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    // homeViewModel.jobTotalController.text = "";
    // homeViewModel.jobPercentageValue.value = "Select";
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
              "Job Form",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.getCommonSizedBox,
                    AppTextField(
                      // controller: emailController,
                      title: "Date",
                      hint: DateFormat('MMM d, yyyy - EEEE')
                          .format(DateTime.now()),
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      // validator: (value) =>
                      //     Validators.emptyValidator(value!.trim()),
                    ),
                    context.getCommonSizedBox,
                    AppTextField(
                      controller: homeViewModel.customerNameController,
                      title: "Customer Name",
                      // hint: "John doe",
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          Validators.emptyValidator(value!.trim()),
                    ),
                    context.getCommonSizedBox,
                    AppTextField(
                      controller: homeViewModel.serviceTitanNumController,
                      title: "Service Titan Number",
                      // hint: "220, Main street, Toronto",
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          Validators.emptyValidator(value!.trim()),
                    ),
                    context.getCommonSizedBox,
                    AppTextField(
                      controller: homeViewModel.jobTotalController,
                      title: "Job Total",
                      hint: "0",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                      ],
                      validator: (value) =>
                          Validators.emptyValidator(value!.trim()),
                      textInputAction: TextInputAction.done,
                    ),
                    context.getCommonSizedBox,
                    Container(
                      width: 1.0.sw,
                      margin: EdgeInsets.only(bottom: 10.h),
                      alignment: Alignment.centerLeft,
                      child: Text("Job Percentage",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: ColorPalette.appPrimaryColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp)),
                    ),
                    InkWell(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 14.h, bottom: 14.h, left: 14.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            border: Border.all(
                                width: 1.0,
                                color: ColorPalette.appPrimaryColor)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 0.75.sw,
                              child: Obx(() => Text(
                                  homeViewModel.jobPercentageValue.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: ColorPalette.appPrimaryColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp))),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 0.01.sw,
                                right: 0.01.sw,
                              ),
                              child: Icon(Icons.arrow_downward_sharp,
                                  color: ColorPalette.appPrimaryColor,
                                  size: 20.w),
                            )
                          ],
                        ),
                      ),
                    ),
                    context.getCommonSizedBox,
                    context.getCommonSizedBox,
                    AppFilledButton(
                        text: "Save",
                        onTap: () {
                          saveBtnClick();
                        }),
                    context.getCommonSizedBox,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup<void>(
        context: ctx,
        builder: (_) => SizedBox(
              width: 1.0.sw,
              height: 250.h,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 40.h,
                scrollController: FixedExtentScrollController(initialItem: 0),
                children: jobPercentageList
                    .map((e) => Container(
                          height: 40.h,
                          alignment: Alignment.center,
                          child: Text("$e %",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: ColorPalette.appPrimaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp)),
                        ))
                    .toList(),
                onSelectedItemChanged: (value) {
                  homeViewModel.jobPercentageValue.value =
                      jobPercentageList.elementAt(value).toString();
                },
              ),
            ));
  }

  void saveBtnClick() async {
    if (_formKey.currentState!.validate()) {
      bool res = await homeViewModel.addJobFormRequest();
      if (res) {
        Get.back();
      }
    }
  }
}
