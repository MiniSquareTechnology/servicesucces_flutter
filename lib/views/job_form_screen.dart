import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/custom_widgets/check_box_widget.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class JobFormScreen extends StatefulWidget {
  final int formType;

  const JobFormScreen({super.key, required this.formType});

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  late HomeViewModel homeViewModel;

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
                    widget.formType == 1
                        ? jobFormOneWidgets()
                        : widget.formType == 2
                            ? jobFormTwoWidgets()
                            : jobFormThreeWidgets(),
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

  /// Job Form 1
  Widget jobFormOneWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextField(
          controller: homeViewModel.jobTotalController,
          title: "Job Total",
          hint: "0",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
        ),
        context.getCommonSizedBox,
        Container(
          width: 1.0.sw,
          margin: EdgeInsets.only(bottom: 10.h),
          alignment: Alignment.centerLeft,
          child: Text("Job Percentage",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorPalette.appPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp)),
        ),
        InkWell(
          onTap: () {
            showJobPercentBottomDialog();
          },
          child: Container(
            padding: EdgeInsets.only(top: 14.h, bottom: 14.h, left: 14.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                    width: 1.0, color: ColorPalette.appPrimaryColor)),
            child: Row(
              children: [
                SizedBox(
                  width: 0.75.sw,
                  child: Obx(() => Text(
                      "${homeViewModel.jobPercentageValue.value} ${homeViewModel.jobPercentageValue.value.isNum ? "%" : ""}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                      color: ColorPalette.appPrimaryColor, size: 20.w),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showJobPercentBottomDialog() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: homeViewModel.jobPercentageList
                .map((e) => jobPercentDialogItem("$e"))
                .toList(),
          ),
        );
      },
    );
  }

  Widget jobPercentDialogItem(String title) {
    return InkWell(
      onTap: () {
        homeViewModel.jobPercentageValue.value = title;
        Get.back();
      },
      child: Container(
        width: 1.0.sw,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
        child: Text("$title %",
            style: TextStyle(
                color: ColorPalette.appPrimaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  /// Job Form 2
  Widget jobFormTwoWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextField(
          controller: homeViewModel.amountCollectedController,
          title: "Amount Collected",
          hint: "0",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
        ),
        context.getCommonSizedBox,
        AppTextField(
          controller: homeViewModel.amountFinancedController,
          title: "Amount Financed",
          hint: "0",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
        ),
        context.getCommonSizedBox,
        for (int i = 0; i < homeViewModel.form2CheckList.length; i++)
          Obx(() => CheckBoxWidget(
              label: homeViewModel.form2CheckList[i],
              selected: homeViewModel.plumbingCheckListSelected.contains(i),
              index: i,
              onTap: (index) {
                homeViewModel.updateForm2ListValue(index);
              }))
      ],
    );
  }

  /// Job Form 3
  Widget jobFormThreeWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextField(
          controller: homeViewModel.jobTotalController,
          title: "Job Total",
          hint: "0",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
          onChanged: (String value) {
            if(value.isNotEmpty) {
              homeViewModel.totalPayController.text = "${int.parse(value) * 4 / 100}";
            }
          },
        ),
        context.getCommonSizedBox,
        AppTextField(
          controller: homeViewModel.totalPayController,
          title: "Total Pay",
          hint: "0",
          readOnly: true,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
        ),
        context.getCommonSizedBox,
        for (int i = 0; i < homeViewModel.form3CheckList.length; i++)
          Obx(() => CheckBoxWidget(
              label: homeViewModel.form3CheckList[i],
              selected: homeViewModel.form3ListSelected.contains(i),
              index: i,
              onTap: (index) {
                homeViewModel.updateForm3ListValue(index);
              }))
      ],
    );
  }

  void saveBtnClick() async {
    if (_formKey.currentState!.validate()) {
      bool res;
      if (widget.formType == 1) {
        res = await homeViewModel.addJobFormRequest();
      }

      if (widget.formType == 2) {
        res = await homeViewModel.addUpdatePlumbingJobFormRequest();
      }

      if (widget.formType == 3) {
        res = await homeViewModel.addUpdateTechnicianJobFormRequest();
      }

      else {
        res = true;
      }

      if (res) {
        Get.back();
      }
    }
  }
}
