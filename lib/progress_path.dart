import 'package:flutter/material.dart';

class ProgressPath extends StatefulWidget {
  const ProgressPath({Key? key}) : super(key: key);

  @override
  _ProgressPathState createState() => _ProgressPathState();
}

class _ProgressPathState extends State<ProgressPath>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final int totalSteps = 12;
  final int currentStep = 4; // This can be made dynamic based on props

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildProgressPoint(int index, bool isActive) {
    String imageUrl = isActive
        ? "https://dashboard.codeparrot.ai/api/image/Z5Or73hIZI-ZK8k8/frame-10-${index + 1}.png"
        : "https://dashboard.codeparrot.ai/api/image/Z5Or73hIZI-ZK8k8/frame-10-${index + 1}.png"; // Use gray version for inactive

    return Container(
      width: 44,
      height: 44,
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        color: isActive ? null : Colors.grey.withOpacity(0.5),
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.broken_image,
            size: 44,
            color: Colors.grey,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 300,
        minHeight: 150,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Progress points
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: List.generate(totalSteps, (index) {
                    return _buildProgressPoint(
                      index,
                      index <= currentStep,
                    );
                  }),
                ),
              ),

              // Animated character
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    left: _animation.value * (constraints.maxWidth - 60),
                    bottom: 20,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        "https://dashboard.codeparrot.ai/api/image/Z5Or73hIZI-ZK8k8/screensh.png",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.broken_image,
                            size: 60,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
