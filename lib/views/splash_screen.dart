import 'package:employee_clock_in/res/utils/app_sizer.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), (){
      Get.offAllNamed(RoutePathConstants.loginScreen);
    });

    return Scaffold(
      backgroundColor: ColorPalette.appPrimaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizer.commonSidePadding),
          child: Text(
            "Mini Square Technologies",
            // "Service Success Pros",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
