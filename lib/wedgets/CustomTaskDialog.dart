import 'package:flutter/material.dart';

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
                      child: const Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
              child: const Icon(Icons.close, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
