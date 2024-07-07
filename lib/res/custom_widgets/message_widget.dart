
import 'package:employee_clock_in/models/job_detail_response_model.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final EditJobs msgData;
  final bool isMyMsg;

  const MessageWidget(
      {super.key, required this.msgData, required this.isMyMsg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: !isMyMsg ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            !isMyMsg ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              !isMyMsg
                  ? imageWidget(
                      isMyMsg, EdgeInsets.only(right: 10.h, top: 10.h))
                  : const SizedBox(height: 0, width: 0),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      color: !isMyMsg
                          ? ColorPalette.white
                          : ColorPalette.appPrimaryColor,
                      borderRadius: !isMyMsg
                          ? BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r))
                          : BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              topRight: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r))),
                  margin: EdgeInsets.only(
                    top: 10.h,
                    left: !isMyMsg ? 0 : 0.36.sw,
                    right: !isMyMsg ? 0.36.sw : 0,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Text(
                    msgData.comment ?? '',
                    style: TextStyle(
                        color: isMyMsg
                            ? ColorPalette.white
                            : ColorPalette.appPrimaryColor,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              !isMyMsg
                  ? const SizedBox(height: 0, width: 0)
                  : imageWidget(
                      isMyMsg, EdgeInsets.only(left: 10.h, top: 10.h)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 60.w),
            child: Text(
              DateFormat("dd-MM-yyy").format(
                  DateFormat("yyyy-MM-ddThh:mm:ss").parse(msgData.createdAt!)),
              style: TextStyle(
                  color: ColorPalette.appPrimaryColor,
                  fontSize: 9.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget imageWidget(bool isMyMsg, EdgeInsetsGeometry margin) {
    return Container(
      height: 36.w,
      width: 36.w,
      margin: margin,
      decoration: BoxDecoration(
          color: !isMyMsg ? ColorPalette.white : ColorPalette.appPrimaryColor,
          shape: BoxShape.circle),
      child: Icon(
        Icons.person_2_sharp,
        color: isMyMsg ? ColorPalette.white : ColorPalette.appPrimaryColor,
      ),
    );
  }
}
