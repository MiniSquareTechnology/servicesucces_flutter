import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CheckBoxWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final int index;
  final Function(int) onTap;

  const CheckBoxWidget(
      {Key? key,
      required this.label,
      required this.selected,
      required this.index,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            onTap(index);
          },
          child: Container(
            padding: const EdgeInsets.all(2.0),
            margin:
                EdgeInsets.only(top: 0.01.sh, right: 0.02.sw, bottom: 0.01.sh),
            decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
                border: Border.all(width: 1.0, color: ColorPalette.appPrimaryColor)),
            child: Container(
              height: 0.054.sw,
              width: 0.054.sw,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                  color: /* selected
                      ? ColorPalette.appPrimaryColor
                      :*/
                      Colors.transparent),
              child: selected
                  ? Icon(Icons.check,
                      color: ColorPalette.appPrimaryColor, size: 20.w)
                  : Container(),
            ),
          ),
        ),
        Container(
          // color: Colors.green,
          width: 0.7.sw,
          margin: EdgeInsets.only(top: 0.01.sh, bottom: 0.01.sh),
          child: Text(label.capitalize ?? "",
              textAlign: TextAlign.start,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorPalette.appPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp)),
        )
      ],
    );
  }
}
