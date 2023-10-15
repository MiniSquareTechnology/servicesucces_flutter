import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

class AppLogger {
  const AppLogger._();
  static logMessage(dynamic value) {
    // print(value.toString());
    if (kDebugMode) {
      dev.log(value.toString());
    } else {
      dev.log(value.toString());
    }
  }

  static logError(dynamic value) {
    if (kDebugMode) {
      dev.log(value.toString(),error: value.toString());
    } else {
      dev.log(value.toString());
    }
  }

  static logRelease(dynamic value) {
    //if (kReleaseMode) {
      dev.log(value.toString());
    //}
  }
}
