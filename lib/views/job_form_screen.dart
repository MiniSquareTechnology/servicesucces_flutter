import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/custom_widgets/check_box_widget.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/constants/app_user_role.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

late HomeViewModel homeViewModel;

class JobFormScreen extends StatefulWidget {
  final int formType;

  const JobFormScreen({super.key, required this.formType});

  @override
  State<JobFormScreen> createState() => _JobFormScreenState();
}

class _JobFormScreenState extends State<JobFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              AppStringConstants.commissionForm,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: ColorPalette.appPrimaryColor,
                  width: 1.0,
                )
              )
            ),
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: AppFilledButton(
                text: AppStringConstants.save,
                onTap: () {
                  saveBtnClick();
                }),
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
                      title: AppStringConstants.date,
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
                      title: AppStringConstants.customerName,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          Validators.emptyValidator(value!.trim()),
                    ),
                    context.getCommonSizedBox,
                    AppTextField(
                      controller: homeViewModel.serviceTitanNumController,
                      title: AppStringConstants.serviceTitanNumber,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          Validators.emptyValidator(value!.trim()),
                    ),
                    context.getCommonSizedBox,
                    commonFormWidgets(),

                    /// comment account level forms
                    /*widget.formType == 1
                        ? jobFormOneWidgets()
                        : widget.formType == 2
                            ? jobFormTwoWidgets()
                            : jobFormThreeWidgets(),*/
                    context.getCommonSizedBox,
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

  /// common form
  Widget commonFormWidgets() {
    return Obx(() {
      debugPrint(
          "-=-=>  ${homeViewModel.amountCollectedController.value.text.isNotEmpty}");
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextField(
            controller: homeViewModel.amountCollectedController.value,
            title: AppStringConstants.amountCollected,
            hint: "0",
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
            ],
            validator: (value) => Validators.emptyValidator(value!.trim()),
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              if (value.isNotEmpty) {
                homeViewModel.updateShowPercent(true);
                if (isSellingTechnicians() &&
                    homeViewModel.commissionPercentSelectValue
                            .compareTo(AppStringConstants.select) !=
                        0 &&
                    homeViewModel.sellingTechnicianTaskSelectValue
                            .compareTo(AppStringConstants.select) !=
                        0) {
                  getPercent();
                } else if (homeViewModel.commissionPercentSelectValue
                        .compareTo(AppStringConstants.select) !=
                    0) {
                  getPercent();
                }
              } else {
                homeViewModel.updateShowPercent(false);
              }
            },
          ),
          context.getCommonSizedBox,
          if (homeViewModel.showPercent.value) ...[
            Container(
              width: 1.0.sw,
              alignment: Alignment.centerLeft,
              child: Text(AppStringConstants.commissionPercent,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorPalette.appPrimaryColor)),
            ),
            SizedBox(
              height: 6.h,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Container(
                  width: 1.0.sw,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0.r),
                      border: Border.all(
                          color: ColorPalette.appPrimaryColor, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        homeViewModel.commissionPercentSelectValue.value,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: ColorPalette.appPrimaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                        color: ColorPalette.appPrimaryColor,
                      ),
                    ],
                  ),
                ),
                items: [
                  ...MenuItems.getListAccordingUserRole().map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  homeViewModel.commissionPercentSelectValue.value =
                      value?.text ?? '';
                  if (isSellingTechnicians() &&
                      homeViewModel.commissionPercentSelectValue
                          .compareTo(AppStringConstants.select) !=
                          0 &&
                      homeViewModel.sellingTechnicianTaskSelectValue
                          .compareTo(AppStringConstants.select) !=
                          0) {
                    getPercent();
                  } else if (!isSellingTechnicians() && homeViewModel.commissionPercentSelectValue
                      .compareTo(AppStringConstants.select) !=
                      0) {
                    getPercent();
                  }
                  // MenuItems.onChanged(context, value!);
                },
                dropdownStyleData: DropdownStyleData(
                  width: 0.9.sw,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorPalette.appSecondaryColor,
                  ),
                  offset: const Offset(0, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(
                        MenuItems.getListAccordingUserRole().length, 48),
                  ],
                  // padding: const EdgeInsets.only(left: 20, right: 20),
                ),
              ),
            ),
            context.getCommonSizedBox,
          ],
          if (isSellingTechnicians() &&
              homeViewModel.commissionPercentSelectValue.value
                      .compareTo(AppStringConstants.select) !=
                  0) ...[
            Container(
              width: 1.0.sw,
              alignment: Alignment.centerLeft,
              child: Text(AppStringConstants.task,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorPalette.appPrimaryColor)),
            ),
            SizedBox(
              height: 6.h,
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: Container(
                  width: 1.0.sw,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0.r),
                      border: Border.all(
                          color: ColorPalette.appPrimaryColor, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        homeViewModel.sellingTechnicianTaskSelectValue.value,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: ColorPalette.appPrimaryColor,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 30,
                        color: ColorPalette.appPrimaryColor,
                      ),
                    ],
                  ),
                ),
                items: [
                  ...MenuItems.sellingTechniciansTaskList.map(
                    (item) => DropdownMenuItem<MenuItem>(
                      value: item,
                      child: MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  homeViewModel.sellingTechnicianTaskSelectValue.value =
                      value!.text;
                  getPercent();
                },
                dropdownStyleData: DropdownStyleData(
                  width: 0.9.sw,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorPalette.appSecondaryColor,
                  ),
                  offset: const Offset(0, 8),
                ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: [
                    ...List<double>.filled(
                        MenuItems.sellingTechniciansTaskList.length, 48),
                  ],
                  // padding: const EdgeInsets.only(left: 20, right: 20),
                ),
              ),
            ),
            context.getCommonSizedBox,
            if (homeViewModel.sellingTechnicianTaskSelectValue.value
                    .compareTo(AppStringConstants.select) !=
                0)
              commissionField()
          ],
          !isSellingTechnicians() &&
                  homeViewModel.commissionPercentSelectValue.value
                          .compareTo(AppStringConstants.select) !=
                      0
              ? commissionField()
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      );
    });
  }

  Widget commissionField() {
    return AppTextField(
      readOnly: true,
      controller: homeViewModel.commissionController.value,
      title: "${AppStringConstants.commission} %",
      hint: "0",
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
      validator: (value) => Validators.emptyValidator(value!.trim()),
      textInputAction: TextInputAction.done,
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
          title: AppStringConstants.jobTotal,
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
          child: Text(AppStringConstants.jobPercentage,
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

  /// Job Form 2
  Widget jobFormTwoWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextField(
          controller: homeViewModel.amountCollectedController.value,
          title: AppStringConstants.amountCollected,
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
          title: AppStringConstants.amountFinanced,
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
          title: AppStringConstants.jobTotal,
          hint: "0",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          validator: (value) => Validators.emptyValidator(value!.trim()),
          textInputAction: TextInputAction.done,
          onChanged: (String value) {
            if (value.isNotEmpty) {
              homeViewModel.totalPayController.text =
                  "${int.parse(value) * 4 / 100}";
            }
          },
        ),
        context.getCommonSizedBox,
        AppTextField(
          controller: homeViewModel.totalPayController,
          title: AppStringConstants.totalPay,
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
    // if (_formKey.currentState!.validate()) {
    bool res = false;
    // if (widget.formType == 1) {
    res = await homeViewModel.addJobFormRequest();
    // }

    /*if (widget.formType == 2) {
        res = await homeViewModel.addUpdatePlumbingJobFormRequest();
      }

      if (widget.formType == 3) {
        res = await homeViewModel.addUpdateTechnicianJobFormRequest();
      } else {
        res = true;
      }*/

    if (res) {
      Get.back();
    }
    // }
  }

  getPercent() {
    double res = 0;
    res = (num.parse(homeViewModel.commissionPercentSelectValue.value) *
            num.parse(homeViewModel.amountCollectedController.value.text)) /
        100;

    if (isSellingTechnicians()) {
      homeViewModel.commissionController.value.text =
          "${int.parse(homeViewModel.sellingTechnicianTaskSelectValue.value.split("-")[1]) + num.parse(res.toStringAsFixed(2))}";
    } else {
      homeViewModel.commissionController.value.text = res.toStringAsFixed(2);
    }
  }

  bool isSellingTechnicians() {
    return homeViewModel.userRole.value ==
        AppUserRole.userRoleSellingTechnicians;
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
  });

  final String text;
}

abstract class MenuItems {
  /*static const List<MenuItem> firstItems = [iPending, iWarmLead, iNoSale, iNoContact, iCancelled, iSold];

  static const iPending = MenuItem(text: 'Pending');
  static const iWarmLead = MenuItem(text: 'Warm Lead');
  static const iNoSale = MenuItem(text: 'No Sale');
  static const iNoContact = MenuItem(text: 'No Contact');
  static const iCancelled = MenuItem(text: 'Cancelled');
  static const iSold = MenuItem(text: 'Sold');
  static const iAll = MenuItem(text: 'All');*/

  static const List<MenuItem> comfortAdviserList = [
    MenuItem(text: '5'),
    MenuItem(text: '7'),
    MenuItem(text: '8'),
    MenuItem(text: '10')
  ];
  static const List<MenuItem> techniciansList = [
    MenuItem(text: '3'),
    MenuItem(text: '4'),
    MenuItem(text: '5'),
  ];
  static const List<MenuItem> sellingTechniciansList = [
    MenuItem(text: '3'),
    MenuItem(text: '5'),
    MenuItem(text: '7'),
    MenuItem(text: '8'),
    MenuItem(text: '9'),
    MenuItem(text: '10'),
    MenuItem(text: '18')
  ];
  static const List<MenuItem> plumbingList = [
    MenuItem(text: '2.5'),
    MenuItem(text: '3'),
    MenuItem(text: '5'),
    MenuItem(text: '15'),
    MenuItem(text: '18')
  ];
  static const List<MenuItem> installList = [
    MenuItem(text: '2.5'),
    MenuItem(text: '3.25')
  ];

  static const List<MenuItem> sellingTechniciansTaskList = [
    MenuItem(text: 'T1-30'),
    MenuItem(text: 'T2-60'),
    MenuItem(text: 'T3-90')
  ];

  static Widget buildItem(MenuItem item) {
    return Text(
      item.text,
      style: TextStyle(
        fontSize: 15.sp,
        color: ColorPalette.appPrimaryColor,
      ),
    );
  }

  static List<MenuItem> getListAccordingUserRole() {
    switch (homeViewModel.userRole.value) {
      case AppUserRole.userRoleComfortAdviser:
        return comfortAdviserList;
      case AppUserRole.userRoleTechnicians:
        return techniciansList;
      case AppUserRole.userRoleSellingTechnicians:
        return sellingTechniciansList;
      case AppUserRole.userRolePlumbing:
        return plumbingList;
      case AppUserRole.userRoleInstall:
        return installList;
      default:
        return comfortAdviserList;
    }
  }

/* static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.iPending:
      //Do something
        break;
      case MenuItems.iWarmLead:
      //Do something
        break;
      case MenuItems.iNoSale:
      //Do something
        break;
      case MenuItems.iNoContact:
      //Do something
        break;
      case MenuItems.iCancelled:
      //Do something
        break;
      case MenuItems.iSold:
      //Do something
        break;
      case MenuItems.iAll:
      //Do something
        break;
    }
  }*/
}
