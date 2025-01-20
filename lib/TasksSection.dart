import 'package:flutter/material.dart';

class TasksSection extends StatelessWidget {
  final List<Task> tasks;
  final List<Task> completedTasks;

  const TasksSection({
    Key? key,
    this.tasks = const [
      Task(title: 'Brush your hair.', reward: '2 KWD'),
      Task(title: 'Brush your hair.', reward: '2 KWD'),
      Task(title: 'Brush your hair.', reward: '2 KWD'),
    ],
    this.completedTasks = const [
      Task(title: 'Brush your hair.', reward: '2 KWD'),
      Task(title: 'Brush your hair.', reward: '2 KWD'),
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          constraints: BoxConstraints(
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
                      color: Color(0xFFF38E22),
                    ),
                  ),
                  SizedBox(height: 16),
                  ...tasks.map((task) => TaskItem(task: task)),
                  SizedBox(height: 24),
                  Text(
                    'Completed:',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF38E22),
                    ),
                  ),
                  SizedBox(height: 16),
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

  const Task({
    required this.title,
    required this.reward,
  });
}

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({
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
          gradient: LinearGradient(
            colors: [
              Color(0xFFF38E22),
              Color(0xFFF5A147),
              Color(0xFFF6AE60),
              Color(0xFFF49734),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: Text(
            task.reward,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          trailing: Text(
            task.reward,
            style: TextStyle(
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
