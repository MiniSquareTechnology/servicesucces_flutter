
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_palette.dart';

class AppTextStyle {

  static TextStyle buttonTextStyle({Color? color}) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: color ?? ColorPalette.primaryColor100);

  static TextStyle extraSmallFilledButtonTextStyle() => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      );
  static TextStyle appBarTheme1() => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
      );
  static TextStyle appBarThemeBold() => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
      );
}
