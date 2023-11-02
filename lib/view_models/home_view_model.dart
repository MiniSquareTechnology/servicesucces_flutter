import 'dart:async';
import 'package:employee_clock_in/data/repository/home_repository.dart';
import 'package:employee_clock_in/models/add_job_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/error/app_error.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  Rx<bool> showArrival = false.obs;
  Rx<bool> checkInStart = false.obs;
  Rx<String> arrivalTimeText = "".obs;
  Rx<String> userName = "".obs;
  Rx<String> currentDate = "".obs;
  Rx<String> totalHours = "--:--".obs;
  Rx<String> checkInTimer = "--:--".obs;
  Rx<String> checkOutTimer = "--:--".obs;
  Rx<String> buttonStatus = "Dispatch".obs;
  DateTime? punchIn;
  DateTime? punchOut;

  // Initialize an instance of Stopwatch
  final Stopwatch _stopwatch = Stopwatch();

  // Timer
  late Timer _timer;

  // The result which will be displayed on the screen
  final Rx<String> timerText = ''.obs;

  @override
  void update([List<Object>? ids, bool condition = true]) {}

  @override
  void onClose() {}

  @override
  void onReady() {}

  @override
  void onInit() {
    super.onInit();
    currentDate.value = DateFormat('MMM d, yyyy - EEEE').format(DateTime.now());
  }

  void getUserDetails() async {
    userName.value = await AppPreferenceStorage.getStringValuesSF(
            AppPreferenceStorage.userName) ??
        "Hey William!";
  }

  void setCheckInTime(String customerName, String serviceTitanNumber) {
    punchIn = DateTime.now();
    checkInTimer.value = DateFormat().add_jm().format(DateTime.now());
    _start();
    checkInStart.value = true;
    buttonStatus.value = "Arrive";
    totalHours.value = "--:--";
    checkOutTimer.value = "--:--";
    ///
    addJobRequest(customerName, serviceTitanNumber);
  }

  void updateArrival() {
    DateTime now = DateTime.now();
    arrivalTimeText.value =
        "${DateFormat().add_jms().format(now)} ${DateFormat().add_yMMMMEEEEd().format(now)}";
    buttonStatus.value = "Done";
    showArrival.value = true;
    Map<String, String> params = {
      "arrival_time": DateFormat('yyyy-MM-dd HH:mm:ss').format(now)
    };
    ///
    updateJobRequest(params);
  }

  void setCheckOutTime() {
    DateTime now = DateTime.now();
    punchOut = now;
    checkOutTimer.value = DateFormat().add_jm().format(now);
    _reset();
    buttonStatus.value = "Dispatch";
    checkInStart.value = false;
    showArrival.value = false;
    // totalHours.value =
    //     Duration(minutes: punchOut!.difference(punchIn!).inMinutes)
    //         .getHoursAndMinutes;
    Duration totalTimeDuration = punchOut!.difference(punchIn!);
    totalHours.value =
        '${totalTimeDuration.inHours.toString().padLeft(2, '0')}:${totalTimeDuration.inMinutes.toString().padLeft(2, '0')}:${(totalTimeDuration.inSeconds % 60).toString().padLeft(2, '0')}';
    ///
    Map<String, String> params = {
      "checkout_time": DateFormat('yyyy-MM-dd HH:mm:ss').format(now),
      "total_hours" : totalHours.value
    };
    updateJobRequest(params);
  }

  // This function will be called when the user presses the Start button
  void _start() {
    // Timer.periodic() will call the callback function every 100 milliseconds
    _timer = Timer.periodic(const Duration(milliseconds: 30), (Timer t) {
      // Update the UI
      // result in hh:mm:ss format
      timerText.value =
          '${_stopwatch.elapsed.inHours.toString().padLeft(2, '0')}:${_stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
    });
    // Start the stopwatch
    _stopwatch.start();
  }

  // This function will be called when the user presses the Stop button
  void _stop() {
    _timer.cancel();
    _stopwatch.stop();
  }

  // This function will be called when the user presses the Reset button
  void _reset() {
    _stop();
    _stopwatch.reset();
  }

  Future<bool> addJobRequest(
      String customerName, String serviceTitanNumber) async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "Loading...");
      Map<String, String> params = {
        "customer_name": customerName,
        "service_titan_number": serviceTitanNumber,
        "dispatch_time":
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      };
      AddJobResponseModel addJobResponseModel =
          await homeRepository.addJobApi(params);
      Get.back();
      if (addJobResponseModel.statusCode! == 200) {
        AppPreferenceStorage.setStringValuesSF(AppPreferenceStorage.jobId,
            addJobResponseModel.data!.id!.toString());
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      AppLogger.logMessage("------>>>> ${exception.code}");
      showErrorDialog(exception.message);
      return false;
    }
  }

  Future<bool> updateJobRequest(Map<String, String> params) async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "Loading...");
      String jobId = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.jobId) ??
          "";
      AddJobResponseModel addJobResponseModel =
          await homeRepository.updateJobApi(jobId, params);
      Get.back();
      if (addJobResponseModel.statusCode! == 200) {
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      AppLogger.logMessage("------>>>> ${exception.code}");
      showErrorDialog(exception.message);
      return false;
    }
  }

  void showErrorDialog(String msg) {
    CustomDialogs().showErrorDialog(Get.context!, msg, onTap: () {
      Get.back();
    });
  }
}
