import 'dart:async';
import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/data/services/check_internet_service.dart';
import 'package:employee_clock_in/data/services/location_service.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/constants/app_string_constants.dart';
import 'package:employee_clock_in/res/utils/extensions/address_from_lat_lon.dart';
import 'package:employee_clock_in/res/utils/extensions/common_sized_box.dart';
import 'package:employee_clock_in/res/utils/local_storage/image_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/color_palette.dart';
import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// flutter build apk --release -v --no-tree-shake-icons
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  TextEditingController customerNameController = TextEditingController();
  TextEditingController serviceTitanNumController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? address;
  String lat = "", long = "";
  late HomeViewModel homeViewModel;
  late Timer _timer;

  @override
  void initState() {
    homeViewModel = Get.find(tag: AppBinding.homeViewModelTag);
    homeViewModel.getUserDetails();
    // homeViewModel.getJobStatus();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrentJobResult();
      // Future.delayed(const Duration(seconds: 30), (){
      //   checkNetConnection();
      // });
    });

    /*_timer = Timer.periodic(const Duration(seconds: 14), (timer) {
      checkNetConnection();
    });*/
    super.initState();
  }

  checkNetConnection() {
    CheckInternetService().checkInternet().then((value) {
      if (value) {
        getCurrentJobResult();
        _timer.cancel();
      }
    });
  }

  getCurrentJobResult() {
    if (homeViewModel.historyList.isEmpty) {
      DateTime now = DateTime.now();
      homeViewModel.getJobHistory(
          DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1)),
          DateFormat('yyyy-MM-dd').format(now),
          true,
          -1); // -1 for all
    }
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
        // debugPrint("Inactive");
        break;
      case AppLifecycleState.paused:
        // debugPrint("Paused");
        break;
      case AppLifecycleState.resumed:
        // debugPrint("Resumed");
        break;
      case AppLifecycleState.detached:
        // debugPrint("detached:-=>  ${homeViewModel.timerText.value}");
        break;
      default:
        // debugPrint("Suspending");
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
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                          AppStringConstants.homeTitle,
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
                SizedBox(height: 30.h),
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

                Obx(() => homeViewModel.showArrival.value
                    ? context.getCommonSizedBox
                    : Container()),
                // Obx(() => homeViewModel.showArrival.value ? context.getCommonSizedBox: Container()),
                Obx(() => homeViewModel.showArrival.value
                    ? Container(
                        width: 1.0.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 14.h),
                        decoration: BoxDecoration(
                            color: ColorPalette.appPrimaryColor,
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStringConstants.arrivalTime,
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
                      )
                    : Container()),

                // context.getCommonSizedBox,
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

                /// comment account level forms
                /* Obx(() => homeViewModel.showArrival.value &&
                        homeViewModel.userRole.value == 5
                    ? InkWell(
                        onTap: () {
                          launchJobFormScreen(1);
                        },
                        child: Container(
                          width: 1.0.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          decoration: BoxDecoration(
                              color: ColorPalette.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Job Form 1",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorPalette.appSecondaryColor,
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()),
                Obx(() => homeViewModel.showArrival.value &&
                        homeViewModel.userRole.value == 6
                    ? InkWell(
                        onTap: () {
                          launchJobFormScreen(2);
                        },
                        child: Container(
                          width: 1.0.sw,
                          margin: EdgeInsets.only(top: 0.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          decoration: BoxDecoration(
                              color: ColorPalette.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Job Form 2",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorPalette.appSecondaryColor,
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()),*/
                Obx(() => homeViewModel.showArrival.value
                    ? SizedBox(height: 10.h)
                    : Container()),
                Obx(() => homeViewModel.showArrival.value
                    ? InkWell(
                        onTap: () {
                          // launchJobFormScreen(3);
                          launchJobFormScreen(0);
                        },
                        child: Container(
                          width: 1.0.sw,
                          margin: EdgeInsets.only(top: 0.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 14.h),
                          decoration: BoxDecoration(
                              color: ColorPalette.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppStringConstants.commissionForm,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ColorPalette.appSecondaryColor,
                              )
                            ],
                          ),
                        ))
                    : Container()),
              ],
            ),
          ),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: Obx(() => homeViewModel.timerText.value.isEmpty
              ? ExpandableFab(
            type: ExpandableFabType.up,
            childrenAnimation: ExpandableFabAnimation.none,
            distance: 70,
            overlayStyle: ExpandableFabOverlayStyle(
              color: Colors.white.withOpacity(0.9),
            ),
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.timer),
              fabSize: ExpandableFabSize.regular,
              foregroundColor: Colors.white,
              backgroundColor: ColorPalette.appPrimaryColor,
              shape: const CircleBorder(),
            ),
            closeButtonBuilder: DefaultFloatingActionButtonBuilder(
              child: const Icon(Icons.close),
              fabSize: ExpandableFabSize.small,
              foregroundColor: Colors.white,
              backgroundColor: ColorPalette.appPrimaryColor,
              shape: const CircleBorder(),
            ),
            children: [
              FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: ColorPalette.appPrimaryColor,
                label: const Text(AppStringConstants.tripHome),
                onPressed: () {},
              ),
              FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: ColorPalette.appPrimaryColor,
                label: const Text(AppStringConstants.standBy),
                onPressed: () {},
              ),
              FloatingActionButton.extended(
                heroTag: null,
                backgroundColor: ColorPalette.appPrimaryColor,
                label: const Text(AppStringConstants.inMeeting),
                onPressed: () {},
              ),
            ],
          )
              : const SizedBox(
            height: 0,
            width: 0,
          )),
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
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.appSecondaryColor),
                )),
          ],
        ),
      );

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
      if (homeViewModel.buttonStatus.value
              .compareTo(AppStringConstants.clickToArrive) ==
          0) {
        LocationService.checkLocationPermissionStatus().then((value) {
          if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever ||
              address == null) {
            /*requestLocationBottomSheet*/ getLocation(() {
              homeViewModel.updateArrival(address ?? '', lat, long);
            });
          } else {
            homeViewModel.updateArrival(address ?? '', lat, long);
          }
        });
      } else {
        CustomDialogs.showYesNoDialog(context, AppStringConstants.punchOutAlert,
            onYesTap: () {
          Get.back();

          LocationService.checkLocationPermissionStatus().then((value) {
            if (value == LocationPermission.denied ||
                value == LocationPermission.deniedForever ||
                address == null) {
              /*requestLocationBottomSheet*/ getLocation(() {
                homeViewModel.setCheckOutTime(address ?? '', lat, long);
              });
            } else {
              homeViewModel.setCheckOutTime(address ?? '', lat, long);
            }
          });
        }, onNoTap: () {
          Get.back();
        });
      }
    } else {
      /*requestLocationBottomSheet*/ getLocation(() {
        CustomDialogs.punchInDialog(Get.context!, customerNameController,
            serviceTitanNumController, _formKey, () {
          AppLogger.logMessage(
              "-=>>< ${customerNameController.text.trim()} -- ${serviceTitanNumController.text.trim()}");
          Get.back();
          homeViewModel.setCheckInTime(customerNameController.text.trim(),
              serviceTitanNumController.text.trim(), address ?? '', lat, long);
        });
      });
    }
  }

/*  requestLocationBottomSheet(VoidCallback voidCallback) {
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
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
                Icon(Icons.light_mode_outlined,
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
                    "Turn on location services to start Clock In this Application with your location.",
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
                    getLocation(voidCallback);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                    decoration: BoxDecoration(
                        color: ColorPalette.appPrimaryColor,
                        borderRadius: BorderRadius.circular(40.r)),
                    child: Text("Next",
                        style: TextStyle(fontSize: 14.sp, color: Colors.white)),
                  ),
                ),
                context.getCommonSizedBox,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
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
  }*/

  getLocation(VoidCallback voidCallback) {
    customerNameController.text = "";
    serviceTitanNumController.text = "";
    LocationService.determinePosition().then((value) async {
      AppLogger.logMessage("--=> ${value.latitude} ${value.longitude}");

      lat = value.latitude.toString(); // '30.7115';//
      long = value.longitude.toString(); // '76.706'; //
      address = await value.getAddressFromCoordinates();
      voidCallback();
      /*StreamSubscription<Position> positionStream =*/
      // Geolocator.getPositionStream(locationSettings: locationSettings)
      //     .listen((Position? position) {
      //   var speedInMps = position?.speed.toStringAsPrecision(2);
      //   debugPrint("<<----- $speedInMps");
      // });
    });
  }

  launchJobFormScreen(int formType) {
    Get.toNamed(RoutePathConstants.jobFormScreen,
        arguments: {"formType": formType});
  }

}




