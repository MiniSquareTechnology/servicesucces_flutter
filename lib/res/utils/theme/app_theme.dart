import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_palette.dart';

class AppThemeData {
  static ThemeData appData(BuildContext context) => ThemeData(
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
            // color: ColorPalette.iconsPrimaryColor,
            ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorPalette.primaryColor100,
        ),
        dividerColor: const Color(0xFFEBECF6),
        checkboxTheme: CheckboxThemeData(
          visualDensity: VisualDensity.compact,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all((ColorPalette.primaryColor100)),
        ),
        appBarTheme: AppBarTheme(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            color: Colors.transparent,
            iconTheme: const IconThemeData(
                //  color: ColorPalette.black90,
                ),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Colors.black),
            centerTitle: true),
        textTheme: TextTheme(
          displaySmall: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
          bodyLarge: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
              ),
          bodyMedium: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
        ),
      );
}
