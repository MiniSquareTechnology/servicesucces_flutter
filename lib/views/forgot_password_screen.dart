import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/forgot_password_response_model.dart';
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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  late AuthViewModel authViewModel;

  @override
  void initState() {
    authViewModel = Get.find(tag: AppBinding.authViewModelTag);
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
              AppStringConstants.forgotPassword,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 0.15.sh,
                width: 1.0.sw,
                color: ColorPalette.appPrimaryColor,
                // alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
                      context.getCommonSizedBox,
                      Text(
                        AppStringConstants.forgotPasswordTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1.0.sw,
                margin: EdgeInsets.only(top: 0.13.sh),
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
                      context.getCommonSizedBox,
                      AppFilledButton(
                          text: AppStringConstants.send,
                          onTap: () {
                            sendBtnClick();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendBtnClick() async {
    if (_formKey.currentState!.validate()) {
      ForgotPasswordResponseModel? model =
          await authViewModel.forgotPassword(emailController.text.trim());
      if (model != null) {
        Get.toNamed(RoutePathConstants.verifyOtpScreen,
            arguments: {"user_id": '${model.data?.id ?? ''}'});
      }
    }
  }
}
