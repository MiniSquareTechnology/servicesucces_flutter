import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/utils/app_sizer.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_textfield.dart';

class CustomDialogs {
  static punchInDialog(BuildContext context, VoidCallback onTap) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Container(
            // height: 228.h,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.r))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                context.getCommonSizedBox,
               /* Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Enter job name to Punch In",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorPalette.appPrimaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp)),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.cancel_outlined,
                          color: ColorPalette.appPrimaryColor, size: 30.w),
                    )
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                Container(
                  width: 1.0.sw,
                  color: ColorPalette.appPrimaryColor,
                  height: 1.0,
                ),
                SizedBox(
                  height: 14.h,
                ),*/
                AppTextField(
                  // controller: emailController,
                  title: "Customer Name",
                  hint: "Enter Customer Name",
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      Validators.emptyValidator(value!.trim()),
                ),
                context.getCommonSizedBox,
                AppTextField(
                  // controller: emailController,
                  title: "Service Titan Number",
                  hint: "Enter Service Titan Number",
                  keyboardType: TextInputType.text,
                  validator: (value) =>
                      Validators.emptyValidator(value!.trim()),
                ),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                AppFilledButton(
                    text: "Start",
                    onTap: () {
                      onTap();
                    }),
                context.getCommonSizedBox,
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static showYesNoDialog(
    BuildContext context,
    String title, {
    GestureTapCallback? onYesTap,
    GestureTapCallback? onNoTap,
    String? message,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: EdgeInsets.all(25.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorPalette.appPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp)),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppFilledButton(
                      text: "Yes",
                      width: 120.w,
                      onTap: () => onYesTap!(),
                    ),
                    AppFilledButton(
                      text: "No",
                      width: 120.w,
                      onTap: () => onNoTap!(),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }
        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  static void showLoadingDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        height: 40.w,
                        width: 40.w,
                        child: CircularProgressIndicator(
                            color: ColorPalette.appPrimaryColor,
                            backgroundColor: ColorPalette.appSecondaryColor)),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.primaryColor100),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void showErrorDialog(BuildContext context, String title,
      {GestureTapCallback? onTap, String? message}) {
    ///if error code is more 10000, we will show session expired download
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: EdgeInsets.all(25.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.primaryColor100),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppFilledButton(
                    text: "Okay",
                    width: 200.w,
                    onTap: () => onTap!(),
                  )
                ],
              ),
            ),
          );
        });
  }

}
