import 'package:employee_clock_in/res/utils/app_sizer.dart';
import 'package:flutter/material.dart';

extension CommonSizedBox on BuildContext {
  Widget get getCommonSizedBox => SizedBox(
        height: AppSizer.commonSizedBoxHeight,
      );
}
