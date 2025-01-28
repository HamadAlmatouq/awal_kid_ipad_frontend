import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/client.dart';
import 'Task.dart';
import 'CustomTaskDialog.dart';

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

  Future<void> _completeTask() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        print('Failed to complete task: No token found');
        return;
      }
      final response = await Client.dio.post(
        '/kid/completeTask',
        data: {
          'title': widget.task.title,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        widget.onComplete(widget.task);
      } else {
        print('Failed to complete task: ${response.statusCode}');
        print('Response data: ${response.data}');
      }
    } catch (e) {
      if (e is DioError && e.response != null) {
        print('Failed to complete task: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
      } else {
        print('Failed to complete task: $e');
      }
    }
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
              onDone: () async {
                Navigator.of(context).pop();
                await _completeTask();
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
