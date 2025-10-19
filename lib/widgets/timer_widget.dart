import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerController controller = Get.find<TimerController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // === Mode Focus / Break ===
        Obx(() => Text(
              controller.isWorking.value ? 'Waktu Fokus' : 'Waktu Istirahat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: controller.isWorking.value ? Colors.redAccent : Colors.green,
              ),
            )),
        const SizedBox(height: 10),

        // === Animasi angka countdown ===
        Obx(() => AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: FadeTransition(opacity: animation, child: child),
              ),
              child: Text(
                controller.timeDisplay.value,
                key: ValueKey(controller.timeDisplay.value),
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            )),

        const SizedBox(height: 20),

        // === Tombol kontrol (Start, Pause, Reset) ===
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: controller.isRunning.value
                    ? controller.pauseTimer
                    : controller.startTimer,
                icon: Icon(
                    controller.isRunning.value ? Icons.pause : Icons.play_arrow),
                label: Text(controller.isRunning.value ? 'Pause' : 'Mulai'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isRunning.value
                      ? Colors.pinkAccent
                      : Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: controller.resetTimer,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade400,
                  foregroundColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
