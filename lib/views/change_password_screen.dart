import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/utils/app_sizer.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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
              "Change Password",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                AppTextField(
                  // controller: emailController,
                  title: "Current Password",
                  hint: "Enter current password",
                  keyboardType: TextInputType.text,
                  isObscure: true,
                  validator: (value) => Validators.passwordValidator(value!.trim()),
                ),

                context.getCommonSizedBox,
                AppTextField(
                  // controller: emailController,
                  title: "New Password",
                  hint: "Enter new password",
                  keyboardType: TextInputType.text,
                  isObscure: true,
                  validator: (value) => Validators.passwordValidator(value!.trim()),
                ),
                context.getCommonSizedBox,
                AppTextField(
                  // controller: emailController,
                  title: "Confirm Password",
                  hint: "Enter confirm password",
                  keyboardType: TextInputType.text,
                  isObscure: true,
                  validator: (value) => Validators.passwordConfirmValidator("", value!.trim()),
                ),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                AppFilledButton(
                    text: "Update Password",
                    onTap: () {
                      Get.back();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
