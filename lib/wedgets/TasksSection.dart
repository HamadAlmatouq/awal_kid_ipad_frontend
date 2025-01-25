import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../services/client.dart';
import 'Task.dart';
import 'TaskItem.dart';
import 'CompletedTaskItem.dart';

class TasksSection extends StatefulWidget {
  const TasksSection({Key? key}) : super(key: key);

  @override
  _TasksSectionState createState() => _TasksSectionState();
}

class _TasksSectionState extends State<TasksSection> {
  List<Task> tasks = [
    Task(title: 'Water the plants', reward: '4 KWD', duration: 3, timeLeft: 1),
  ];

  List<Task> completedTasks = [
    Task(title: 'Fold the laundry', reward: '5 KWD'),
  ];

  double _convertTimeToDecimal(String time) {
    final parts = time.split(' ');
    final hours = int.parse(parts[0].replaceAll('h', ''));
    final minutes = int.parse(parts[1].replaceAll('m', ''));
    return hours + (minutes / 60);
  }

  String _convertDecimalToTime(double decimal) {
    final hours = decimal.floor();
    final minutes = ((decimal - hours) * 60).round();
    return '${hours}h ${minutes}m';
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _fetchTasks() async {
    try {
      final response = await Client.dio.get('/kid/tasks');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          tasks.addAll(data.map((taskData) {
            final remainingDurationStr = taskData['remainingDuration'];
            final timeLeft = remainingDurationStr != null
                ? _convertTimeToDecimal(remainingDurationStr)
                : 0.0;
            print(
                'Task: ${taskData['title']}, Remaining Duration: $remainingDurationStr, Converted: $timeLeft'); // Debug print
            return Task(
              title: taskData['title'],
              reward: '${taskData['amount'].toDouble()} KWD',
              duration: taskData['duration'].toDouble(),
              timeLeft: timeLeft,
            );
          }).toList());
        });
      } else {
        // Handle error
        print('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Failed to load tasks: $e');
    }
  }

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
