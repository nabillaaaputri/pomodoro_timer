import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../models/session.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimerController controller = Get.find<TimerController>();
    final df = DateFormat('dd MMM yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Sesi')),
      body: Obx(() {
        final List<Session> list = controller.sessions.reversed.toList();
        if (list.isEmpty) {
          return const Center(child: Text('Belum ada riwayat.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final s = list[i];
            return Card(
              color: Colors.pink[50],
              child: ListTile(
                leading: Icon(s.isWork ? Icons.work : Icons.free_breakfast, color: Colors.pinkAccent),
                title: Text(s.isWork ? 'Sesi Fokus' : 'Istirahat'),
                subtitle: Text('${s.minutes} menit • ${df.format(s.timestamp)}'),
              ),
            );
          },
        );
      }),
    );
  }
}
