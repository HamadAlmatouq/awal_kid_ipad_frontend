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
  List<Task> tasks = [];
  List<Task> completedTasks = [];

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
    _fetchCompletedTasks();
  }

  String _formatReward(double amount) {
    return amount % 1 == 0
        ? '${amount.toInt()} KWD'
        : '${amount.toStringAsFixed(1)} KWD';
  }

  Future<void> _fetchTasks() async {
    try {
      final response = await Client.dio.get('/kid/tasks');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // First fetch completed tasks to use for filtering
        await _fetchCompletedTasks();

        setState(() {
          tasks.clear();
          // Filter out tasks that are either not pending or are in completedTasks
          tasks.addAll(data.where((taskData) {
            bool isPending = taskData['pending'] == true;
            bool isNotCompleted = !completedTasks.any(
                (completedTask) => completedTask.title == taskData['title']);
            return isPending && isNotCompleted;
          }).map((taskData) {
            final remainingDurationStr = taskData['remainingDuration'];
            final timeLeft = remainingDurationStr != null
                ? _convertTimeToDecimal(remainingDurationStr)
                : 0.0;
            return Task(
              title: taskData['title'],
              reward: _formatReward(taskData['amount'].toDouble()),
              duration: taskData['duration'].toDouble(),
              timeLeft: timeLeft,
            );
          }).toList());
        });
      } else {
        print('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to load tasks: $e');
    }
  }

  Future<void> _fetchCompletedTasks() async {
    try {
      final response = await Client.dio.get('/kid/completedtasks');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        setState(() {
          completedTasks = data
              .map((taskData) => Task(
                    title: taskData['title'],
                    reward: _formatReward(taskData['amount'].toDouble()),
                  ))
              .toList();
        });
      }
    } catch (e) {
      print('Failed to load completed tasks: $e');
    }
  }

  void _completeTask(Task task) async {
    await _fetchTasks();
    await _fetchCompletedTasks();
  }

  Widget _buildEmptyState() {
    return Container(
      height: 400, // Increased height for better visibility
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 120, // Increased icon size
              color: const Color(0xFFF38E22).withOpacity(0.5),
            ),
            const SizedBox(height: 24), // Increased spacing
            const Text(
              'No Tasks Available',
              style: TextStyle(
                fontSize: 32, // Increased font size
                fontWeight: FontWeight.w600,
                color: Color(0xFFF38E22),
              ),
            ),
            const SizedBox(height: 16), // Increased spacing
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your parent will assign tasks for you',
                style: TextStyle(
                  fontSize: 24, // Increased font size
                  color: const Color(0xFFF38E22).withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
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
                  if (tasks.isEmpty && completedTasks.isEmpty)
                    _buildEmptyState()
                  else ...[
                    ...tasks.map((task) =>
                        TaskItem(task: task, onComplete: _completeTask)),
                    const SizedBox(height: 24),
                    if (completedTasks.isNotEmpty) ...[
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
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
