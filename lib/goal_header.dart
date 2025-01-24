import 'package:flutter/material.dart';

class GoalHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const GoalHeader({
    Key? key,
    this.title = 'Goals',
    this.subtitle = 'Increase your savings to reach your goals',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Ensure minimum width for content
        final minWidth = 680.0; // Based on text length and padding
        final actualWidth =
            constraints.maxWidth > minWidth ? constraints.maxWidth : minWidth;

        return Container(
          width: actualWidth,
          constraints: BoxConstraints(
            minHeight: 120.0, // Minimum height to fit content
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.0, // Matches Figma lineHeight
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8),
                  height: 1.2, // For readable line height
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
