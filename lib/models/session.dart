class Session {
  final bool isWork;
  final int minutes; // durasi dalam menit
  final DateTime timestamp;

  Session({
    required this.isWork,
    required this.minutes,
    required this.timestamp,
  });

  @override
  String toString() {
    return '${isWork ? "Work" : "Break"} • ${minutes}m • $timestamp';
  }
}
