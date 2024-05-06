import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentsListScreen extends StatefulWidget {
  const CommentsListScreen({super.key});

  @override
  State<CommentsListScreen> createState() => _CommentsListScreenState();
}

class _CommentsListScreenState extends State<CommentsListScreen> {
  final List<String> _messages = [
    "Test Comment here",
    "Hello william",
  ];

  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted(String text) {
    _messages.add(text);
    _textController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.appPrimaryColor,
        leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Get.back();
            }),
        centerTitle: true,
        title: Text(
          AppStringConstants.comments,
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(20.h),
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Align(
                  alignment: (index % 2) != 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: (index % 2) != 0
                            ? ColorPalette.appPrimaryColor.withOpacity(0.8)
                            : ColorPalette.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10.r)),
                    margin: EdgeInsets.only(
                      top: 10.h,
                      left: (index % 2) != 0 ? 0 : 0.4.sw,
                      right: (index % 2) != 0 ? 0.4.sw : 0,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    child: Text(
                      _messages[index],
                      style: TextStyle(
                          color: ColorPalette.white,
                          fontSize: 12.sp,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1.h),
          Container(
            width: 1.0.sw,
            height: 0.08.sh,
            color: ColorPalette.appPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 0.8.sw,
                    child: TextFormField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "${AppStringConstants.enter} ${AppStringConstants.comment}",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    )),
                IconButton(
                    onPressed: () {
                      _handleSubmitted(_textController.text);
                    },
                    icon: Icon(
                      Icons.send,
                      size: 26.w,
                      color: ColorPalette.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
