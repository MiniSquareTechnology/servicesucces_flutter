import 'package:employee_clock_in/data/binding/app_binding.dart';
import 'package:employee_clock_in/data/services/firebase_notifications.dart';
import 'package:employee_clock_in/res/utils/routes/app_routes.dart';
import 'package:employee_clock_in/res/utils/routes/route_path_constants.dart';
import 'package:employee_clock_in/res/utils/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'service-success-pro',
      options: const FirebaseOptions(
          apiKey: 'AIzaSyAQmnf2__aO2yRomTsIEDPNhffbnoAV218',
          appId: '1:369153067741:ios:6d6bf1df8e77080ccee934',
          messagingSenderId: '369153067741',
          projectId: 'service-success-app'));
  await FirebaseNotifications.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'UK'),
          theme: AppThemeData.appData(context),
          // home: const OnboardScreen(),
          initialBinding: AppBinding(),
          initialRoute: RoutePathConstants.splashScreen,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
