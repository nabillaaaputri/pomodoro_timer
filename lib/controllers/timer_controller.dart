import 'dart:async';
import 'package:get/get.dart';
import '../models/session.dart';

class TimerController extends GetxController {
  // durasi default
  var workMinutes = 25.obs;
  var breakMinutes = 5.obs;

  // state
  var isWorking = true.obs;
  var isRunning = false.obs;
  var secondsLeft = 0.obs;
  var timeDisplay = "00:00".obs;

  // daftar sesi
  var sessions = <Session>[].obs;

  // progress
  double get progress {
    int totalSeconds = (isWorking.value ? workMinutes.value : breakMinutes.value) * 60;
    return 1 - (secondsLeft.value / totalSeconds);
  }

  // total menit fokus
  int get totalFocusMinutes {
    return sessions
        .where((s) => s.isWork)
        .fold(0, (sum, s) => sum + s.minutes);
  }

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    resetTimer();
  }

  // toggle start/pause
  void toggleTimer() {
    if (isRunning.value) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  // mulai timer
  void startTimer() {
    if (secondsLeft.value <= 0) {
      secondsLeft.value = (isWorking.value ? workMinutes.value : breakMinutes.value) * 60;
    }

    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft.value > 0) {
        secondsLeft.value--;
        updateDisplay();
      } else {
        timer.cancel();
        isRunning.value = false;

        // simpan sesi selesai
        sessions.add(Session(
          isWork: isWorking.value,
          minutes: (isWorking.value ? workMinutes.value : breakMinutes.value),
          timestamp: DateTime.now(),
        ));

        // ganti mode fokus <-> istirahat
        isWorking.value = !isWorking.value;
        resetTimer();
      }
    });
  }

  // pause timer
  void pauseTimer() {
    _timer?.cancel();
    isRunning.value = false;
  }

  // reset timer
  void resetTimer() {
    _timer?.cancel();
    isRunning.value = false;
    secondsLeft.value = (isWorking.value ? workMinutes.value : breakMinutes.value) * 60;
    updateDisplay();
  }

  // update teks tampilan
  void updateDisplay() {
    int minutes = secondsLeft.value ~/ 60;
    int seconds = secondsLeft.value % 60;
    timeDisplay.value = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  // ubah durasi fokus
  void setWorkMinutes(int minutes) {
    workMinutes.value = minutes;
    if (isWorking.value) resetTimer();
  }

  // ubah durasi istirahat
  void setBreakMinutes(int minutes) {
    breakMinutes.value = minutes;
    if (!isWorking.value) resetTimer();
  }
}
