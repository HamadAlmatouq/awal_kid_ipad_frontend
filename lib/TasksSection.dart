import 'dart:async';
import 'package:flutter/material.dart';

class TasksSection extends StatefulWidget {
  const TasksSection({Key? key}) : super(key: key);

  @override
  _TasksSectionState createState() => _TasksSectionState();
}

class CompletedTaskItem extends StatelessWidget {
  final Task task;

  const CompletedTaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                task.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  const Icon(Icons.card_giftcard, color: Colors.black),
                  const SizedBox(width: 4),
                  Text(
                    task.reward,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksSectionState extends State<TasksSection> {
  List<Task> tasks = [
    Task(title: 'Water the plants', reward: '4 KWD', duration: 3, timeLeft: 1),
    Task(
        title: 'Feed the birdies', reward: '2 KWD', duration: 2, timeLeft: 1.5),
    Task(
        title: 'Eat your veggies',
        reward: '5 KWD',
        duration: 1,
        timeLeft: 0.083),
  ];

  List<Task> completedTasks = [
    Task(title: 'Fold the laundry', reward: '5 KWD'),
    Task(title: 'Comb your hair', reward: '2 KWD'),
  ];

  void _completeTask(Task task) {
    setState(() {
      tasks.remove(task);
      completedTasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(minWidth: 507, minHeight: 487),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tasks:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF38E22),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...tasks.map((task) =>
                      TaskItem(task: task, onComplete: _completeTask)),
                  const SizedBox(height: 24),
                  Text(
                    'Completed:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF38E22),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...completedTasks
                      .map((task) => CompletedTaskItem(task: task)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

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

class TaskItem extends StatefulWidget {
  final Task task;
  final Function(Task) onComplete;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onComplete,
  }) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (widget.task.timeLeft != null && widget.task.timeLeft! > 0) {
        setState(() {
          widget.task.timeLeft =
              widget.task.timeLeft! - (1 / 3600); // Decrease by 1 second
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(double? timeLeft) {
    if (timeLeft == null || timeLeft <= 0) return 'No time left';
    int totalSeconds = (timeLeft * 3600).toInt();
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours}h ${minutes}m ${seconds}s left';
  }

  void _showTaskDialog(BuildContext context) {
    Timer? dialogTimer;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, StateSetter setStateDialog) {
            dialogTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
              if (mounted &&
                  widget.task.timeLeft != null &&
                  widget.task.timeLeft! > 0) {
                setState(() {
                  widget.task.timeLeft = widget.task.timeLeft! - (1 / 3600);
                });
                setStateDialog(() {}); // Updates the dialog state
              } else {
                timer.cancel();
              }
            });

            return CustomTaskDialog(
              title: widget.task.title,
              reward: widget.task.reward,
              timeLeft: _formatTime(widget.task.timeLeft),
              progress:
                  widget.task.duration != null && widget.task.timeLeft != null
                      ? 1 - (widget.task.timeLeft! / widget.task.duration!)
                      : 0,
              onDone: () {
                Navigator.of(context).pop();
                widget.onComplete(widget.task);
              },
            );
          },
        );
      },
    ).then((_) {
      if (dialogTimer?.isActive ?? false) {
        dialogTimer?.cancel(); // Ensures the timer stops after dialog is closed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (widget.task.duration != null && widget.task.timeLeft != null) {
      progress = 1 - (widget.task.timeLeft! / widget.task.duration!);
    }

    return GestureDetector(
      onTap: () => _showTaskDialog(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFF38E22),
                    Color(0xFFF5A147),
                    Color(0xFFF6AE60),
                    Color(0xFFF49734),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.card_giftcard, color: Colors.white),
                        const SizedBox(width: 4),
                        Text(
                          widget.task.reward,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: FractionallySizedBox(
                  widthFactor: progress.clamp(0, 1),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(12),
                        bottomRight: Radius.circular(progress == 1 ? 12 : 0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTaskDialog extends StatelessWidget {
  final String title;
  final String reward;
  final String timeLeft;
  final double progress;
  final VoidCallback onDone;

  const CustomTaskDialog({
    Key? key,
    required this.title,
    required this.reward,
    required this.timeLeft,
    required this.progress,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width * 0.9,
          //   constraints: const BoxConstraints(maxWidth: 500),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.orange, // Border color
                width: 8, // Adjust this for boldness
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF38E22),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(color: const Color(0xFFF5A147).withOpacity(0.4)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFF38E22)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.card_giftcard,
                              color: Color(0xFFF38E22)),
                          const SizedBox(width: 8),
                          Text(
                            reward,
                            style: const TextStyle(
                              fontSize: 28,
                              color: Color(0xFFF38E22),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Color(0xFFF38E22)),
                          const SizedBox(width: 8),
                          Text(
                            timeLeft,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color(0xFFF38E22),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                    onTap: onDone,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF38E22),
                            Color(0xFFF5A147),
                            Color(0xFFF6AE60),
                            Color(0xFFF49734),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.celebration,
                            color: Colors.white,
                            size: 36, // Icon size for kid-friendly appearance
                          ),
                          SizedBox(width: 8), // Space between icon and text
                          Text(
                            'Done',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white, // Match the Done button color
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: Colors.orange,
                  size: 48, // Larger size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
