import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';

import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 0.2.sh,
              width: 1.0.sw,
              color: ColorPalette.appPrimaryColor,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Log in to your account",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              width: 1.0.sw,
              margin: EdgeInsets.only(top: 0.18.sh),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.getCommonSizedBox,
                  context.getCommonSizedBox,
                  AppTextField(
                    // controller: emailController,
                    title: "Email Address",
                    hint: "Enter Email Address",
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) => Validators.emailValidator(email!.trim()),
                  ),

                  context.getCommonSizedBox,
                  AppTextField(
                    // controller: emailController,
                    title: "Password",
                    hint: "Enter Password",
                    keyboardType: TextInputType.text,
                    isObscure: true,
                    validator: (email) => Validators.passwordValidator(email!.trim()),
                  ),
                  context.getCommonSizedBox,
                  context.getCommonSizedBox,
                  AppFilledButton(
                      text: "LogIn",
                      onTap: () {
                        Get.offAllNamed(RoutePathConstants.bottomNavScreen);
                      }),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
