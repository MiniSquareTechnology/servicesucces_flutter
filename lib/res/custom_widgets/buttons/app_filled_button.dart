import 'package:employee_clock_in/res/utils/theme/app_text_style.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppFilledButton extends StatelessWidget {
  final String text;
  final GestureTapCallback? onTap;
  final Widget? icon;
  final double? width, height;

  const AppFilledButton(
      {Key? key,
      required this.text,
      this.onTap,
      this.icon,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (onTap != null) {
              FocusScope.of(context).requestFocus(FocusNode());
              onTap!();
            }
          },
          child: Container(
            height: height ?? 50.h,
            width: width ?? 262.w,
            padding:
                width == null ? EdgeInsets.symmetric(horizontal: 32.w) : null,
            decoration: BoxDecoration(
              color: ColorPalette.appPrimaryColor,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null ? icon! : Container(),
                    icon != null ? SizedBox(width: 0.012.sw) : Container(),
                    Text(text,
                        style: AppTextStyle.buttonTextStyle(color: Colors.white)),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
