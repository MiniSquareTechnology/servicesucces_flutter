import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.appPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.48.sh,
              width: 1.0.sw,
            ),
            Text(
              AppStringConstants.appName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              AppStringConstants.developedBy,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              AppStringConstants.miniSquareTechnologies,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void checkLoginStatus() async {
    String? token = await AppPreferenceStorage.getStringValuesSF(
        AppPreferenceStorage.authToken);
    Future.delayed(const Duration(seconds: 2), () {
      if (token == null) {
        Get.offAllNamed(RoutePathConstants.loginScreen);
      } else {
        Get.offAllNamed(RoutePathConstants.bottomNavScreen);
      }
    });
  }
}
