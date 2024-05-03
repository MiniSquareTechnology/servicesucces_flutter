import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/app_textfield.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/res/utils/validator/validators.dart';
import 'package:employee_clock_in/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController conformPasswordController = TextEditingController();

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  context.getCommonSizedBox,
                  context.getCommonSizedBox,
                  Obx(() => AppTextField(
                      controller: currentPasswordController,
                      title: "Current Password",
                      hint: "Enter current password",
                      keyboardType: TextInputType.text,
                      isObscure: authViewModel.getOldPasswordObscureValue,
                      validator: (pass) =>
                          Validators.passwordLengthValidator(pass!.trim()),
                      suffix: InkWell(
                        onTap: () {
                          authViewModel.updateOldPasswordObscureValue();
                        },
                        child: Icon(
                            authViewModel.getOldPasswordObscureValue
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp,
                            color: ColorPalette.primaryColor100),
                      ))),
                  context.getCommonSizedBox,
                  Obx(() => AppTextField(
                      controller: newPasswordController,
                      title: "New Password",
                      hint: "Enter new password",
                      keyboardType: TextInputType.text,
                      isObscure: authViewModel.getNewPasswordObscureValue,
                      validator: (pass) =>
                          Validators.passwordLengthValidator(pass!.trim()),
                      suffix: InkWell(
                        onTap: () {
                          authViewModel.updateNewPasswordObscureValue();
                        },
                        child: Icon(
                            authViewModel.getNewPasswordObscureValue
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp,
                            color: ColorPalette.primaryColor100),
                      ))),
                  context.getCommonSizedBox,
                  Obx(() => AppTextField(
                        controller: conformPasswordController,
                        title: "Confirm Password",
                        hint: "Enter confirm password",
                        keyboardType: TextInputType.text,
                        isObscure: authViewModel.getConfirmPasswordObscureValue,
                        validator: (pass) =>
                            Validators.passwordConfirmValidator(newPasswordController.text.trim(), pass!.trim()),
                        suffix: InkWell(
                          onTap: () {
                            authViewModel.updateConfirmPasswordObscureValue();
                          },
                          child: Icon(
                              authViewModel.getConfirmPasswordObscureValue
                                  ? Icons.visibility_off_sharp
                                  : Icons.visibility_sharp,
                              color: ColorPalette.primaryColor100),
                        ),
                      )),
                  context.getCommonSizedBox,
                  context.getCommonSizedBox,
                  AppFilledButton(
                      text: "Update Password",
                      onTap: () {
                        updatePasswordClick();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  updatePasswordClick() async {
    if (_formKey.currentState!.validate()) {
      bool res = await authViewModel.changePassword(
          currentPasswordController.text.trim(),
          newPasswordController.text.trim(),
          conformPasswordController.text.trim());

      if (res) {
        CustomDialogs.showErrorDialog(
            Get.context!, 'Password updated successfully', onTap: () {
          Get.back();
          Get.back();
        });
      }
    }
  }
}
