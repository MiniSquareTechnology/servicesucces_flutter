import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/forgot_password_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/buttons/app_filled_button.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String userID;

  const VerifyOtpScreen({super.key, required this.userID});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  late AuthViewModel authViewModel;

  @override
  void initState() {
    authViewModel = Get.find(tag: AppBinding.authViewModelTag);
    super.initState();
  }

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.dispose();
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
              AppStringConstants.verifyOTP,
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
                        AppStringConstants.verifyOtpTitle,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.getCommonSizedBox,
                    context.getCommonSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildOTPField(otpController1, focusNode1, focusNode2, null),
                        _buildOTPField(otpController2, focusNode2, focusNode3, focusNode1),
                        _buildOTPField(otpController3, focusNode3, focusNode4, focusNode2),
                        _buildOTPField(otpController4, focusNode4, null, focusNode3),
                      ],
                    ),
                    context.getCommonSizedBox,
                    context.getCommonSizedBox,
                    AppFilledButton(
                        text: AppStringConstants.verify,
                        onTap: () {
                          verifyBtnClick();
                        }),
                    context.getCommonSizedBox,
                    InkWell(
                      onTap: () {
                        resendOTP();
                      },
                      child: Text(
                        AppStringConstants.reSendOTP,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorPalette.appPrimaryColor,
                            fontSize: 17.sp,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOTPField(TextEditingController controller,
      FocusNode currentFocus, FocusNode? nextFocus, FocusNode? previousFocus) {
    return SizedBox(
      width: 50.w,
      child: TextFormField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          debugPrint("-=-=-> ABC");
          if (value.length == 1) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              currentFocus.unfocus();
            }
          } else {
            if (previousFocus != null) {
              FocusScope.of(context).requestFocus(previousFocus);
            }
          }
        },
      ),
    );
  }

  void verifyBtnClick() async {
    if (otpController1.text.trim().isNotEmpty &&
        otpController2.text.trim().isNotEmpty &&
        otpController3.text.trim().isNotEmpty &&
        otpController4.text.trim().isNotEmpty) {
      String otp = otpController1.text.trim() +
          otpController2.text.trim() +
          otpController3.text.trim() +
          otpController4.text.trim();
      ForgotPasswordResponseModel? model =
          await authViewModel.verifyOtp(widget.userID, otp);
      if (model != null) {
        Get.toNamed(RoutePathConstants.resetPasswordScreen,
            arguments: {"user_id": '${model.data?.id ?? ''}'});
      }
    }
  }

  void resendOTP() {
    authViewModel.resendOtp(widget.userID);
  }
}
