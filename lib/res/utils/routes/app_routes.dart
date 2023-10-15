import 'package:employee_clock_in/views/bottom_nav_screen.dart';
import 'package:employee_clock_in/views/change_password_screen.dart';
import 'package:employee_clock_in/views/login_screen.dart';
import 'package:employee_clock_in/views/splash_screen.dart';
import 'package:flutter/material.dart';

import 'route_path_constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutePathConstants.splashScreen: (context) => const SplashScreen(),
      RoutePathConstants.loginScreen: (context) => const LoginScreen(),
      RoutePathConstants.bottomNavScreen: (context) => const BottomNavScreen(),
      RoutePathConstants.changePasswordScreen: (context) =>
          const ChangePasswordScreen(),
    };
  }
}
