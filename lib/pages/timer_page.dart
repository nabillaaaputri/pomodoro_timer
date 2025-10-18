import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import 'history_page.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerController controller = Get.find<TimerController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        actions: [
          // tombol toggle tema
          IconButton(
            onPressed: () {
              final mode = Theme.of(context).brightness;
              if (mode == Brightness.dark) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
            icon: const Icon(Icons.brightness_6),
          ),
          // tombol history
          IconButton(
            onPressed: () => Get.to(() => const HistoryPage()),
            icon: const Icon(Icons.history),
          ),
        ],
      ),

      // body utama
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView( // 🟢 solusi overflow
          child: Column(
            children: [
              // kartu timer utama
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.pink[50],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // timer widget dengan warna adaptif
                    Obx(() {
                      final isDark = Theme.of(context).brightness == Brightness.dark;
                      final textColor = isDark ? Colors.white : Colors.black;
                      return Column(
                        children: [
                          Text(
                            controller.isWorking.value
                                ? 'Waktu Fokus'
                                : 'Waktu Istirahat',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: controller.isWorking.value
                                  ? Colors.redAccent
                                  : Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.timeDisplay.value,
                            style: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              color: textColor, // adaptif mode
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.isRunning.value
                                      ? Colors.pinkAccent
                                      : Colors.greenAccent,
                                ),
                                onPressed: controller.toggleTimer,
                                icon: Icon(controller.isRunning.value
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                label: Text(
                                  controller.isRunning.value ? 'Pause' : 'Mulai',
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: controller.resetTimer,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reset'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 20),

                    // progress bar animasi
                    Obx(() {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: controller.progress),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, _) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade300,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),
                    Obx(() => Text(
                        'Progress: ${(controller.progress * 100).toStringAsFixed(0)}%')),

                    const SizedBox(height: 12),

                    // input custom durasi
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Durasi Fokus (menit)',
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      '${controller.workMinutes.value}',
                                ),
                                onSubmitted: (v) {
                                  final m = int.tryParse(v);
                                  if (m != null && m > 0) {
                                    controller.setWorkMinutes(m);
                                  }
                                },
                              )),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Obx(() => TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Durasi Istirahat (menit)',
                                  border: const OutlineInputBorder(),
                                  hintText:
                                      '${controller.breakMinutes.value}',
                                ),
                                onSubmitted: (v) {
                                  final m = int.tryParse(v);
                                  if (m != null && m > 0) {
                                    controller.setBreakMinutes(m);
                                  }
                                },
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // statistik total fokus
              Obx(() {
                return Column(
                  children: [
                    Text(
                      'Sesi fokus hari ini: ${controller.sessions.where((s) => s.isWork).length}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Total fokus (menit): ${controller.totalFocusMinutes}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                );
              }),

              const SizedBox(height: 16),

              // teks bantuan
              const Text(
                '💡 Tip: Ubah durasi di atas lalu tekan Enter/Submit untuk menyimpan durasi baru.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
