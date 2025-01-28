class Task {
  final String title;
  final String reward;
  final double? duration;
  double? timeLeft;

  Task({
    required this.title,
    required this.reward,
    this.duration,
    this.timeLeft,
  });
}
