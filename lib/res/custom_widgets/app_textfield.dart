import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTextField extends StatelessWidget {
  final String? title;
  final String? subtitle, hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix, suffix;
  final bool? isObscure;
  final String? counterText;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final int? maxLines;
  final TextStyle? hintTextStylee, textStylee;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final VoidCallback? onEditingComplete;

  const AppTextField(
      {Key? key,
      this.title,
      this.textInputAction,
      this.autofillHints,
      this.subtitle,
      this.hint,
      this.maxLines,
      this.controller,
      this.inputFormatters,
      this.keyboardType,
      this.suffix,
      this.onTap,
      this.readOnly = false,
      this.counterText,
      this.isObscure = false,
      this.hintTextStylee,
      this.textStylee,
      this.onSaved,
      this.onChanged,
      this.prefix,
      this.onEditingComplete,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorPalette.appPrimaryColor)),
        if (title != null)
          SizedBox(
            height: 6.h,
          ),
        SizedBox(
          //  height: maxLines == null ? 60.h : null,
          child: TextFormField(
            controller: controller,
            validator: validator,
            maxLines: maxLines ?? 1,
            onTap: onTap,
            readOnly: readOnly!,
            onChanged: onChanged,
            autofillHints: autofillHints,
            onEditingComplete: onEditingComplete,
            inputFormatters: inputFormatters,
            style: textStylee ?? textStyle(context),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: isObscure!,
            decoration: InputDecoration(
                filled: true,
                errorMaxLines: 1,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16.h),
                fillColor: Colors.white,
                prefixIconConstraints: prefix == null
                    ? const BoxConstraints(maxWidth: 16, minWidth: 16)
                    : null,
                prefixIcon: prefix == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: SizedBox(
                              height: 21.w,
                              width: 0,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 12),
                            child: SizedBox(
                                height: 21.w, width: 21.w, child: prefix),
                          ),
                        ],
                      ),
                suffixIcon: suffix == null
                    ? null
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: suffix,
                          ),
                        ],
                      ),
                hintStyle: hintTextStylee ?? hintTextStyle(context),
                hintText: hint,
                border: appBorder(),
                disabledBorder: appBorder(),
                enabledBorder: appBorder(),
                errorBorder:
                    appBorder(borderColor: ColorPalette.failureTextColor),
                focusedBorder: appBorder(),
                focusedErrorBorder:
                    appBorder(borderColor: ColorPalette.failureTextColor),
                errorStyle: failureTextStyle(context)),
          ),
        ),
      ],
    );
  }
}

TextStyle hintTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14.sp,
          color: ColorPalette.appPrimaryColor,
        );

TextStyle textStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 15.sp,
          color: ColorPalette.appPrimaryColor,
        );

TextStyle failureTextStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 13.sp,
          color: ColorPalette.failureTextColor,
        );

InputBorder appBorder({Color? borderColor}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0.r),
      borderSide:
          BorderSide(color: borderColor ?? ColorPalette.appPrimaryColor, width: 1),
    );
