import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/data/services/location_service.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/local_storage/image_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
/// flutter build apk --release -v --no-tree-shake-icons
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver{

  TextEditingController customerNameController = TextEditingController();
  TextEditingController serviceTitanNumController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late HomeViewModel homeViewModel;

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    homeViewModel.getUserDetails();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        debugPrint("Inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("Paused");
        break;
      case AppLifecycleState.resumed:
        debugPrint("Resumed");
        break;
      case AppLifecycleState.detached:
        debugPrint("detached");
        break;
      default:
        debugPrint("Suspending");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.getCommonSizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          homeViewModel.userName.value,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        )),
                        Text(
                          "Good morning! Mark your attendance",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.r),
                      child: Image.asset(
                        ImageStorage.loginLogo,
                        height: 45.w,
                        width: 45.w,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                Container(
                  width: 1.0.sw,
                  alignment: Alignment.center,
                  child: Obx(() => homeViewModel.timerText.value.isEmpty
                      ? Column(
                          children: [
                            Text(
                              DateFormat().add_jm().format(DateTime.now()),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28.sp,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500),
                            ),
                            Obx(() => Text(
                                  homeViewModel.currentDate.value,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        )
                      : Text(
                          homeViewModel.timerText.value,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600),
                        )),
                ),
                context.getCommonSizedBox,
                // context.getCommonSizedBox,
                context.getCommonSizedBox,
                Container(
                  width: 1.0.sw,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    // onTapDown: _onTapDown,
                    // onTapUp: _onTapUp,
                    onTap: () {
                      mainBtnClick();
                    },
                    child: _animatedButtonUI,
                  ),
                ),
                context.getCommonSizedBox,

                Obx(() => homeViewModel.showArrival.value ? context.getCommonSizedBox : Container()),
                // Obx(() => homeViewModel.showArrival.value ? context.getCommonSizedBox: Container()),
                Obx(() => homeViewModel.showArrival.value ? Container(
                  width: 1.0.sw,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  decoration: BoxDecoration(
                      color: ColorPalette.appPrimaryColor,
                      borderRadius: BorderRadius.circular(10.r)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Arrival time",
                        style: TextStyle(
                            color: ColorPalette.appSecondaryColor,
                            fontSize: 16.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        homeViewModel.arrivalTimeText.value,
                        style: TextStyle(
                            color: ColorPalette.appSecondaryColor,
                            fontSize: 13.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ): Container()),

                context.getCommonSizedBox,
                context.getCommonSizedBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          timerWidget(
                              homeViewModel.checkInTimer.value, 'Check In'),
                          timerWidget(
                              homeViewModel.checkOutTimer.value, 'Check Out'),
                          timerWidget(
                              homeViewModel.totalHours.value, 'Total Hours'),
                        ],
                      )),
                ),
                context.getCommonSizedBox,
                Obx(() => homeViewModel.showArrival.value ? InkWell(
                  onTap: () {
                    Get.toNamed(RoutePathConstants.jobFormScreen);
                  },
                  child: Container(
                    width: 1.0.sw,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                    decoration: BoxDecoration(
                        color: ColorPalette.appPrimaryColor,
                        borderRadius: BorderRadius.circular(10.r)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Job Form",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.arrow_forward, color: ColorPalette.appSecondaryColor,)
                      ],
                    ),
                  ),
                ) : Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 180.w,
        width: 180.w,
        decoration: BoxDecoration(
          color: ColorPalette.appPrimaryColor,
          borderRadius: BorderRadius.circular(100.0),
          /*boxShadow: [
            BoxShadow(
              color: Colors.amber.shade200,
              blurRadius: 30.0,
              offset: const Offset(0.0, 5.0),
            ),
          ],*/
          /*gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorPalette.green,
            ColorPalette.secondaryColor,
          ],
        )*/
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.touch_app_sharp,
              color: ColorPalette.appSecondaryColor,
              size: 30.w,
            ),
            SizedBox(height: 10.h),
            Obx(() => Text(
                  homeViewModel.buttonStatus.value,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.appSecondaryColor),
                )),
          ],
        ),
      );

/*  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }*/

  Widget timerWidget(String time, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.timer_outlined,
          color: ColorPalette.appPrimaryColor,
          size: 32.w,
        ),
        SizedBox(height: 5.h),
        Text(
          time,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
              fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ],
    );
  }

  void mainBtnClick() {
    if (homeViewModel.checkInStart.value) {
      if(homeViewModel.buttonStatus.value.compareTo("Arrive") == 0) {
        homeViewModel.updateArrival();
      } else {
        CustomDialogs.showYesNoDialog(
            context, "Are you want to Punch Out.",
            onYesTap: () {
              Get.back();
              homeViewModel.setCheckOutTime();
            }, onNoTap: () {
          Get.back();
        });
      }

    } else {
      requestLocationBottomSheet();
    }
  }

  requestLocationBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        )),
        builder: (builderContext) {
          return Container(
            // height: 228.h,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 22.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                context.getCommonSizedBox,
                Icon(Icons.location_on_rounded,
                    color: ColorPalette.appPrimaryColor, size: 50.w),
                context.getCommonSizedBox,
                Text(
                  "Enable your location",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    "This app requires that location service are turned on your "
                    "device and for this app. You must enable them in Settings"
                    " before using this app.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                context.getCommonSizedBox,
                context.getCommonSizedBox,
                InkWell(
                  onTap: () {
                    Get.back();
                    getLocation();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                    decoration: BoxDecoration(
                        color: ColorPalette.appPrimaryColor,
                        borderRadius: BorderRadius.circular(40.r)),
                    child: Text("Allow only while using this app",
                        style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                  ),
                ),
                context.getCommonSizedBox,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Don't allow this app",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                context.getCommonSizedBox,
              ],
            ),
          );
        });
  }

  getLocation() {
    LocationService.determinePosition().then((value) {
      AppLogger.logMessage("--=> ${value.latitude} ${value.longitude}");
      CustomDialogs.punchInDialog(
          context, customerNameController, serviceTitanNumController, _formKey,
          () {
        AppLogger.logMessage(
            "-=>>< ${customerNameController.text.trim()} -- ${serviceTitanNumController.text.trim()}");
        Get.back();
        homeViewModel.setCheckInTime(customerNameController.text.trim(), serviceTitanNumController.text.trim());
      });
      /*StreamSubscription<Position> positionStream =*/
      // Geolocator.getPositionStream(locationSettings: locationSettings)
      //     .listen((Position? position) {
      //   var speedInMps = position?.speed.toStringAsPrecision(2);
      //   debugPrint("<<----- $speedInMps");
      // });
    });
  }

}
