import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';

import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:employee_clock_in/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AuthViewModel authViewModel;

  @override
  void initState() {
    authViewModel = Get.find(tag: AppBinding.authViewModelTag);
    authViewModel.resetValues();
    super.initState();
  }

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
                    AppStringConstants.welcome,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    AppStringConstants.logInTitle,
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
                  )),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.getCommonSizedBox,
                    context.getCommonSizedBox,
                    AppTextField(
                      controller: emailController,
                      title: AppStringConstants.emailAddress,
                      hint:
                          "${AppStringConstants.enter} ${AppStringConstants.emailAddress} ",
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) =>
                          Validators.emailValidator(email!.trim()),
                    ),
                    context.getCommonSizedBox,
                    Obx(() => AppTextField(
                          controller: passwordController,
                          title: AppStringConstants.password,
                          hint:
                              "${AppStringConstants.enter} ${AppStringConstants.password}",
                          keyboardType: TextInputType.text,
                          isObscure: authViewModel.getPasswordObscureValue,
                          validator: (pass) =>
                              Validators.emptyValidator(pass!.trim()),
                          suffix: InkWell(
                            onTap: () {
                              authViewModel.updatePasswordObscureValue();
                            },
                            child: Icon(
                                authViewModel.getPasswordObscureValue
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility_sharp,
                                color: ColorPalette.primaryColor100),
                          ),
                        )),
                    context.getCommonSizedBox,
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutePathConstants.forgotPasswordScreen);
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${AppStringConstants.forgotPassword}?',
                          style: TextStyle(
                              color: ColorPalette.appPrimaryColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    context.getCommonSizedBox,
                    context.getCommonSizedBox,
                    AppFilledButton(
                        text: AppStringConstants.logIn,
                        onTap: () {
                          loginBtnClick();
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  void loginBtnClick() async {
    if (_formKey.currentState!.validate()) {
      bool res = await authViewModel.emailLogin(
          emailController.text.trim(), passwordController.text.trim());

      if (res) {
        Get.offAllNamed(RoutePathConstants.bottomNavScreen);
      }
    }
  }
}
