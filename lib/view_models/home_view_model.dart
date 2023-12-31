import 'dart:async';
import 'package:employee_clock_in/data/repository/home_repository.dart';
import 'package:employee_clock_in/models/add_job_response_model.dart';
import 'package:employee_clock_in/models/job_history_response_model.dart';
import 'package:employee_clock_in/res/custom_widgets/custom_dialogs.dart';
import 'package:employee_clock_in/res/utils/error/app_error.dart';
import 'package:employee_clock_in/res/utils/local_storage/app_preference_storage.dart';
import 'package:employee_clock_in/res/utils/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  Rx<bool> showArrival = false.obs;
  Rx<bool> checkInStart = false.obs;
  Rx<String> arrivalTimeText = "".obs;
  RxInt userRole = 0.obs;
  Rx<String> userName = "".obs;
  Rx<String> currentDate = "".obs;
  Rx<String> totalHours = "--:--".obs;
  Rx<String> checkInTimer = "--:--".obs;
  Rx<String> checkOutTimer = "--:--".obs;
  Rx<String> buttonStatus = "Click to \nDispatch".obs;
  DateTime? punchIn;
  DateTime? punchOut;

  /// job form fields
  TextEditingController customerNameController = TextEditingController();
  TextEditingController serviceTitanNumController = TextEditingController();
  TextEditingController jobTotalController = TextEditingController();
  TextEditingController totalPayController = TextEditingController();
  TextEditingController amountCollectedController = TextEditingController();
  TextEditingController amountFinancedController = TextEditingController();
  Rx<String> jobPercentageValue = "Select".obs;

  // Initialize an instance of Stopwatch
  final Stopwatch _stopwatch = Stopwatch();

  // Timer
  late Timer _timer;

  // The result which will be displayed on the screen
  final Rx<String> timerText = ''.obs;

  // History List
  var historyList = <JobHistoryData>[].obs;
  Map<String, String> jobStatusList = <String, String>{
    "1": "Pending",
    "2": "Warm Lead",
    "3": "No Sale",
    "4": "No Contact",
    "5": "Cancelled",
    "6": "Sold"
  };

  List<int> jobPercentageList = [5, 7, 8, 10];
  List<String> form2CheckList = [
    // "Amount Financed",
    "I Sold it",
    "I Did it",
    "I Set the Lead"
  ];
  List<String> form3CheckList = [
    "VIP Sold",
    "I Sold it",
  ];
  RxList<int> plumbingCheckListSelected = <int>[].obs;
  RxList<int> form3ListSelected = <int>[].obs;

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
    userRole.value = await AppPreferenceStorage.getIntValuesSF(
            AppPreferenceStorage.userRole) ??
        0;
  }

  void getJobFormData() async {
    customerNameController.text = await AppPreferenceStorage.getStringValuesSF(
            AppPreferenceStorage.customerName) ??
        '';
    serviceTitanNumController.text =
        await AppPreferenceStorage.getStringValuesSF(
                AppPreferenceStorage.serviceTitanNumber) ??
            '';
  }

  void getJobStatus() async {
    bool status = await AppPreferenceStorage.getBoolValuesSF(
            AppPreferenceStorage.isJobRunning) ??
        false;
    if (status) {
      String jobText = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.jobStatus) ??
          "";
      buttonStatus.value = jobText;

      String checkInTime = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.checkInTime) ??
          "";
      String? abc = await AppPreferenceStorage.getStringValuesSF(
          AppPreferenceStorage.totalTime);
      AppLogger.logMessage("-=-=>>  $checkInTime ,, $abc");
      // checkInTimer.value = DateFormat().add_jm().format();
    }
  }

  void setCheckInTime(String customerName, String serviceTitanNumber) {
    punchIn = DateTime.now();
    checkInTimer.value = DateFormat().add_jm().format(punchIn!);
    _start();
    checkInStart.value = true;
    buttonStatus.value = "Click to \nArrive";
    totalHours.value = "--:--";
    checkOutTimer.value = "--:--";

    ///
    addJobRequest(customerName, serviceTitanNumber);

    // todo when kill after job start
    /*AppPreferenceStorage.setBoolValuesSF(
        AppPreferenceStorage.isJobRunning, true);
    AppPreferenceStorage.setStringValuesSF(
        AppPreferenceStorage.jobStatus, "Arrive");
    AppPreferenceStorage.setStringValuesSF(AppPreferenceStorage.checkInTime,
        DateFormat('yyyy-MM-dd HH:mm:ss').format(punchIn!));
    AppPreferenceStorage.setStringValuesSF(AppPreferenceStorage.totalTime,
        "homeViewModel.timerText.value");*/
  }

  void updateArrival() {
    DateTime now = DateTime.now();
    arrivalTimeText.value =
        "${DateFormat().add_jms().format(now)} ${DateFormat().add_yMMMMEEEEd().format(now)}";
    buttonStatus.value = "Click to \nDone";
    showArrival.value = true;
    Map<String, String> params = {
      "arrival_time": DateFormat('yyyy-MM-dd HH:mm:ss').format(now)
    };

    ///
    updateJobRequest(params);
    getJobFormData();
  }

  void setCheckOutTime() {
    DateTime now = DateTime.now();
    punchOut = now;
    checkOutTimer.value = DateFormat().add_jm().format(now);
    _reset();
    buttonStatus.value = "Click to \nDispatch";
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
      "total_hours": totalHours.value
    };
    updateJobRequest(params);

    /// clear timer text
    timerText.value = "";

    /// clear job form values
    jobTotalController.text = "";
    totalPayController.text = "";
    amountCollectedController.text = "";
    amountFinancedController.text = "";
    jobPercentageValue.value = "Select";
    plumbingCheckListSelected.clear();
    form3ListSelected.clear();
    AppPreferenceStorage.deleteKey(AppPreferenceStorage.jobFormUpdateId);
    AppPreferenceStorage.deleteKey(
        AppPreferenceStorage.plumbingJobFormUpdateId);
  }

  // This function will be called when the user presses the Start button
  void _start() {
    // Timer.periodic() will call the callback function every 100 milliseconds
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer t) {
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

  void updateForm2ListValue(int index) {
    if (plumbingCheckListSelected.contains(index)) {
      plumbingCheckListSelected.remove(index);
    } else {
      plumbingCheckListSelected.add(index);
    }
  }

  void updateForm3ListValue(int index) {
    if (form3ListSelected.contains(index)) {
      form3ListSelected.remove(index);
    } else {
      form3ListSelected.add(index);
    }
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
        AppPreferenceStorage.setStringValuesSF(
            AppPreferenceStorage.customerName, customerName);
        AppPreferenceStorage.setStringValuesSF(
            AppPreferenceStorage.serviceTitanNumber, serviceTitanNumber);
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

  Future<bool> addJobFormRequest() async {
    try {
      if (jobPercentageValue.value.compareTo("Select") == 0) {
        showErrorDialog("Please Job Percentage");
        return false;
      }

      CustomDialogs.showLoadingDialog(Get.context!, "Loading...");
      String jobId = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.jobId) ??
          "";
      bool isUpdateForm = await AppPreferenceStorage.containKey(
          AppPreferenceStorage.jobFormUpdateId);

      Map<String, String> params = <String, String>{
        "service_titan_number": serviceTitanNumController.text,
        "total_amount": jobTotalController.text.trim(),
        "comission": jobPercentageValue.value,
        "job_id": jobId,
      };

      if (isUpdateForm) {
        String jobFormUpdateId = await AppPreferenceStorage.getStringValuesSF(
                AppPreferenceStorage.jobFormUpdateId) ??
            '';
        params.addAll(<String, String>{
          "id": jobFormUpdateId,
        });
      }

      AddJobResponseModel addJobResponseModel =
          await homeRepository.addJobFormApi(params);
      Get.back();

      if (addJobResponseModel.statusCode! == 200) {
        AppPreferenceStorage.setStringValuesSF(
            AppPreferenceStorage.jobFormUpdateId,
            addJobResponseModel.data!.id!.toString());
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      showErrorDialog(exception.message);
      return false;
    }
  }

  Future<bool> addPlumbingJobFormRequest() async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "Loading...");
      String jobId = await AppPreferenceStorage.getStringValuesSF(
              AppPreferenceStorage.jobId) ??
          "";
      bool isUpdateForm = await AppPreferenceStorage.containKey(
          AppPreferenceStorage.plumbingJobFormUpdateId);

      Map<String, String> params = <String, String>{
        "service_titan_number": serviceTitanNumController.text,
        "amount_collected": amountCollectedController.text.trim(),
        "amount_financed": amountFinancedController.text.trim(),
        "job_id": jobId,
        "i_sold_it": plumbingCheckListSelected.contains(0) ? "1" : "0",
        "i_did_it": plumbingCheckListSelected.contains(1) ? "1" : "0",
        "i_set_the_lead": plumbingCheckListSelected.contains(2) ? "1" : "0",
      };

      if (isUpdateForm) {
        String plumbingJobFormUpdateId =
            await AppPreferenceStorage.getStringValuesSF(
                    AppPreferenceStorage.plumbingJobFormUpdateId) ??
                '';
        params.addAll(<String, String>{
          "id": plumbingJobFormUpdateId,
        });
      }

      AddJobResponseModel addJobResponseModel =
          await homeRepository.addPlumbingJobFormApi(params);
      Get.back();

      if (addJobResponseModel.statusCode! == 200) {
        AppPreferenceStorage.setStringValuesSF(
            AppPreferenceStorage.plumbingJobFormUpdateId,
            addJobResponseModel.data!.id!.toString());
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
      showErrorDialog(exception.message);
      return false;
    }
  }

  Future<bool> getJobHistory(String startDate, String endDate) async {
    try {
      CustomDialogs.showLoadingDialog(Get.context!, "Loading...");
      Map<String, String> params = <String, String>{
        "start_date": startDate,
        "end_date": endDate,
      };

      JobHistoryResponseModel jobHistoryResponseModel =
          await homeRepository.getJobHistoryApi(params);
      Get.back();

      if (jobHistoryResponseModel.statusCode! == 200) {
        historyList.value = jobHistoryResponseModel.data ?? <JobHistoryData>[];
        return true;
      } else {
        return false;
      }
    } on AppError catch (exception) {
      Get.back();
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
