import 'package:employee_clock_in/models/job_history_response_model.dart';
import 'package:employee_clock_in/views/bottom_nav_screen.dart';
import 'package:employee_clock_in/views/change_password_screen.dart';
import 'package:employee_clock_in/views/comments_list_screen.dart';
import 'package:employee_clock_in/views/forgot_password_screen.dart';
import 'package:employee_clock_in/views/history_detail_screen.dart';
import 'package:employee_clock_in/views/history_filters_screen.dart';
import 'package:employee_clock_in/views/job_form_screen.dart';
import 'package:employee_clock_in/views/login_screen.dart';
import 'package:employee_clock_in/views/reset_password_screen.dart';
import 'package:employee_clock_in/views/splash_screen.dart';
import 'package:employee_clock_in/views/verify_otp_screen.dart';
import 'package:flutter/material.dart';

import 'route_path_constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      RoutePathConstants.splashScreen: (context) => const SplashScreen(),
      RoutePathConstants.loginScreen: (context) => const LoginScreen(),
      RoutePathConstants.bottomNavScreen: (context) => const BottomNavScreen(),
      RoutePathConstants.commentsListScreen: (context) {
        Map params = ModalRoute.of(context)!.settings.arguments as Map;
        return CommentsListScreen(jobData: params['jobData'] as JobHistoryData);
      },
      RoutePathConstants.jobFormScreen: (context) {
        Map params = ModalRoute.of(context)!.settings.arguments as Map;
        return JobFormScreen(
          formType: params['formType'],
        );
      },
      RoutePathConstants.changePasswordScreen: (context) =>
          const ChangePasswordScreen(),
      RoutePathConstants.forgotPasswordScreen: (context) =>
          const ForgotPasswordScreen(),
      RoutePathConstants.verifyOtpScreen: (context) {
        Map params = ModalRoute.of(context)!.settings.arguments as Map;
        return VerifyOtpScreen(userID: params['user_id']);
      },
      RoutePathConstants.resetPasswordScreen: (context) {
        Map params = ModalRoute.of(context)!.settings.arguments as Map;
        return ResetPasswordScreen(userID: params['user_id']);
      },
      RoutePathConstants.historyFiltersScreen: (context) =>
          const HistoryFiltersScreen(),
      RoutePathConstants.historyDetailScreen: (context) {
        Map params = ModalRoute.of(context)!.settings.arguments as Map;
        return HistoryDetailScreen(data: params['data'] as JobHistoryData);
      },
    };
  }
}
