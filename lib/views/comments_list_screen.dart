import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/models/add_comment_response_model.dart';
import 'package:employee_clock_in/models/job_detail_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/message_widget.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommentsListScreen extends StatefulWidget {
  final JobDetailResponseModel jobData;

  const CommentsListScreen({super.key, required this.jobData});

  @override
  State<CommentsListScreen> createState() => _CommentsListScreenState();
}

class _CommentsListScreenState extends State<CommentsListScreen> {
  final TextEditingController _textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late HomeViewModel homeViewModel;
  bool backUpdate = false;
  List<EditJobs> comments = [];

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    comments = widget.jobData.data!.editJobs!.reversed.toList();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scrollListToBottom();
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: backUpdate);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: ColorPalette.appPrimaryColor,
          leading: BackButton(
              color: Colors.white,
              onPressed: () {
                Get.back(result: backUpdate);
              }),
          centerTitle: true,
          title: Text(
            AppStringConstants.admin,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500),
          ),
          /*actions: [
            InkWell(
              onTap: () {
                homeViewModel.getJobHistory(startDate, endDate, checkExistJob, status);
              },
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Icon(Icons.refresh, size: 24.w, color: Colors.white,),
              ),
            )
          ],*/
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 6.w),
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  EditJobs msgData =
                  comments.elementAt(index);
                  bool isMyMsg =
                      homeViewModel.userId.compareTo("${msgData.userId}") == 0;
                  return MessageWidget(msgData: msgData, isMyMsg: isMyMsg);
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
                          hintText:
                              "${AppStringConstants.enter} ${AppStringConstants.comment}",
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
                        sendButtonClick();
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
      ),
    );
  }

  scrollListToBottom() {
    Future.delayed(const Duration(milliseconds: 200), (){
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      // scrollController.animateTo(scrollController.position.maxScrollExtent,
      //     duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    });
  }

  sendButtonClick() async {
    homeViewModel
        .addJobComment(
            widget.jobData.data!.id!.toString(), _textController.text)
        .then((value) {
      if (value != null) {
        backUpdate = true;
        AddCommentResponseModel msgData = value;
        EditJobs ed = EditJobs(
            id: msgData.data!.id,
            userId: msgData.data!.userId,
            jobId: int.parse(msgData.data!.jobId!),
            comment: msgData.data!.comment,
            createdAt: msgData.data!.createdAt,
            updatedAt: msgData.data!.updatedAt);
        widget.jobData.data!.editJobs!.add(ed);
        comments.add(ed);
      }
      _textController.text = '';
      if (mounted) {
        setState(() {});
      }
    });
  }
}
