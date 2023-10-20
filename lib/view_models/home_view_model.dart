import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeViewModel extends GetxController {
  Rx<bool> showArrival = false.obs;
  Rx<bool> checkInStart = false.obs;
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

  void setCheckInTime() {
    punchIn = DateTime.now();
    checkInTimer.value = DateFormat().add_jm().format(DateTime.now());
    _start();
    checkInStart.value = true;
    buttonStatus.value = "Arrive";
    totalHours.value = "--:--";
    checkOutTimer.value = "--:--";
  }

  void updateArrival() {
    buttonStatus.value = "Done";
    showArrival.value = true;
  }

  void setCheckOutTime() {
    punchOut = DateTime.now();
    checkOutTimer.value = DateFormat().add_jm().format(DateTime.now());
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


}
