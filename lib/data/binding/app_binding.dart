import 'package:employee_clock_in/view_models/home_view_model.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  static String homeViewModelTag = "homeViewModelTag";

  @override
  void dependencies() {
    Get.put(HomeViewModel(), tag: homeViewModelTag);
  }

}