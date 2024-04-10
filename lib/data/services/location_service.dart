
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  static Future<LocationPermission> checkLocationPermissionStatus() async {
    return await Geolocator.checkPermission();
  }

 static Future<Position> determinePosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
  /*  serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }*/

    permission = await Geolocator.checkPermission();
    debugPrint("PERMISSION:- ${permission.name}");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      CustomDialogs.locationDialog(
          Get.context!, "Location permissions are permanently denied. You can allow this from Application Settings.",
          onYesTap: () async {
            Get.back();
            openAppSettings();
          }, onNoTap: () {
        Get.back();
      });

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    CustomDialogs.showLoadingDialog(Get.context!, "Fetching Location...");
    Position position = await Geolocator.getCurrentPosition();
    Get.back();
    return position;
  }

}