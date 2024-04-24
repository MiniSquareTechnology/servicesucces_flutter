import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/local_storage/image_storage.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';

// import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final AuthViewModel authViewModel =
      Get.find(tag: AppBinding.authViewModelTag);
  String userName = "";

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  //              Transform.rotate(angle: - math.pi / 4, child: Image.asset(ImageStorage.loginLogo))
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 1.0.sw,
                  height: 80.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(90.r),
                  child: Image.asset(
                    ImageStorage.loginLogo,
                    height: 150.w,
                    width: 150.w,
                    fit: BoxFit.fill,
                  ),
                ),
                context.getCommonSizedBox,
                Text(
                  userName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                itemRow("Change Password", Icons.password, () {
                  Get.toNamed(RoutePathConstants.changePasswordScreen);
                }),
                context.getCommonSizedBox,
                itemRow("Logout", Icons.logout_rounded, () {
                  logoutBtnClick();
                }),
                const Spacer(),
                Text(
                  "Developed By",
                  style: TextStyle(
                      color: ColorPalette.appPrimaryColor,
                      fontSize: 14.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "Mini Square Technologies",
                  style: TextStyle(
                      color: ColorPalette.appPrimaryColor,
                      fontSize: 12.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemRow(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 1.0.sw,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: ColorPalette.appPrimaryColor,
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: ColorPalette.appSecondaryColor,
              size: 26.w,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                  color: ColorPalette.appSecondaryColor,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Icon(
              Icons.navigate_next_sharp,
              color: ColorPalette.appPrimaryColor,
              size: 30.w,
            ),
          ],
        ),
      ),
    );
  }

  void logoutBtnClick() async {
    CustomDialogs.showYesNoDialog(
        Get.context!, "Are you want to Logout this Account.",
        onYesTap: () async {
      Get.back();

      bool res = await authViewModel.logOutClick();
      if (res) {
        AppPreferenceStorage.clearPreference();
        Get.offAllNamed(RoutePathConstants.loginScreen);
      }
    }, onNoTap: () {
      Get.back();
    });
  }

  void getUserDetails() async {
    userName = await AppPreferenceStorage.getStringValuesSF(
        AppPreferenceStorage.userName) ??
        "Hey William!";
    if(mounted) {
      setState(() {

      });
    }
  }
}
