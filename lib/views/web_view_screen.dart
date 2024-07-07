import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool loading = true;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if(progress == 100) {
              debugPrint("PP: $progress");
              loading = false;
              setState(() {});
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
           loading = false;
             setState(() {});
          },
          // onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            /*if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }*/
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    /// remove fcm notification data
    AppPreferenceStorage.deleteKey(AppPreferenceStorage.fcmType);
    AppPreferenceStorage.deleteKey(AppPreferenceStorage.fcmLinkUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: ColorPalette.appPrimaryColor,
            leading: BackButton(
                color: Colors.white,
                onPressed: () {
                  Get.back();
                }),
            centerTitle: true,
            title: Text(
              AppStringConstants.notificationDetail,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: loading ?  Center(
            child: SizedBox(
                height: 40.w,
                width: 40.w,
                child: CircularProgressIndicator(
                    color: ColorPalette.appPrimaryColor,
                    backgroundColor: ColorPalette.appSecondaryColor)),
          ) : WebViewWidget(controller: _controller),
        ),
      ),
    );
  }
}
