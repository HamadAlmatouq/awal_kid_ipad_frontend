import 'package:flutter/material.dart';

class GoalItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double progress;
  final VoidCallback? onTap;

  const GoalItem({
    Key? key,
    this.imageUrl = 'https://via.placeholder.com/150', // Placeholder image URL
    this.title = 'Stanley Cup',
    this.progress = 0.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: 180,
          minHeight: 130,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layer 4 - Base white with 0.25 opacity
            Container(
              width: 180,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            // Layer 3 - Image
            Positioned(
              top: 10,
              child: Image.network(
                imageUrl,
                width: 160,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image,
                    size: 90,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            // Layer 2 - Title
            Positioned(
              bottom: 30,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Layer 1 - Progress bar
            Positioned(
              bottom: 10,
              child: Container(
                width: 160,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
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
