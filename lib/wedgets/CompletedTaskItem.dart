import 'package:flutter/material.dart';
import 'Task.dart';

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
