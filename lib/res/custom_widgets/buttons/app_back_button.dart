import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  const AppBackButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap ??
                  () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
          child: SizedBox(
            width: 48.w,
            height: 48.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 16.w,

                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
