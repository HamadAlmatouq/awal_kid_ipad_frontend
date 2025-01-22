import 'package:flutter/material.dart';

class TasksSection extends StatelessWidget {
  final List<Task> tasks;
  final List<Task> completedTasks;

  const TasksSection({
    Key? key,
    this.tasks = const [
      Task(
        title: 'Water the plants',
        reward: '4 KWD',
        duration: 3,
        timeLeft: 1,
      ),
      Task(
        title: 'Feed the birdies',
        reward: '2 KWD',
        duration: 2,
        timeLeft: 1.5,
      ),
      Task(
        title: 'Eat your veggies',
        reward: '5 KWD',
        duration: 1,
        timeLeft: 0.083,
      ),
    ],
    this.completedTasks = const [
      Task(title: 'Fold the laundry', reward: '5 KWD'),
      Task(title: 'Comb your hair', reward: '2 KWD'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            minWidth: 507,
            minHeight: 487,
          ),
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
                  ...tasks.map((task) => TaskItem(task: task)),
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
  final double? timeLeft;

  const Task({
    required this.title,
    required this.reward,
    this.duration,
    this.timeLeft,
  });
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  void _showTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTaskDialog(
          title: task.title,
          reward: task.reward,
          timeLeft: task.timeLeft != null
              ? '${(task.timeLeft! * 60).toInt()} minutes left'
              : 'No time left',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (task.duration != null && task.timeLeft != null) {
      progress = 1 - (task.timeLeft! / task.duration!);
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
                      task.title,
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
                          task.reward,
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

class CompletedTaskItem extends StatelessWidget {
  final Task task;

  const CompletedTaskItem({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 53,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          trailing: Text(
            task.reward,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTaskDialog extends StatelessWidget {
  final String title;
  final String reward;
  final String timeLeft;

  const CustomTaskDialog({
    Key? key,
    required this.title,
    required this.reward,
    required this.timeLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
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
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
