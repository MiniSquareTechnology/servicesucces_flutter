import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color_palette.dart';

extension AppDivider on BuildContext {
  Widget get getAppDivider => Container(
        width: 1.0.sw,
        height: 6.h,
        color: ColorPalette.grey20,
      );
}
