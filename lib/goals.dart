import 'package:flutter/material.dart';
import 'dart:math';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int totalDots = 20; // Total number of dots
  double userSavings = 33.87; // Current savings (dummy data)
  final double maxSavings = 55.0; // Target savings (dummy data)
  List<bool> isReached = []; // Tracks whether each dot has been reached
  int avatarCurrentDot = 0; // Tracks the current dot of the avatar

  @override
  void initState() {
    super.initState();

    // Initialize dots as unreached
    isReached = List.generate(totalDots, (index) => false);

    // Calculate progress on page load
    double progress = userSavings / maxSavings;
    int avatarTargetDot = (progress * totalDots).floor();

    // Set up animation to move avatar to calculated target on page load
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Smooth animation duration
    );

    _animation = Tween<double>(begin: 0, end: avatarTargetDot.toDouble())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          // Update dots dynamically as avatar moves
          for (int i = 0; i < totalDots; i++) {
            if (_animation.value >= i) {
              isReached[i] = true;
            }
          }
          avatarCurrentDot = _animation.value.toInt(); // Update current dot
        });
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showAddToSavingsDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add to Savings'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount to add',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double? amount = double.tryParse(controller.text);
                if (amount != null) {
                  setState(() {
                    userSavings += amount;

                    // Recalculate progress
                    double progress = userSavings / maxSavings;
                    int newTargetDot = (progress * totalDots).floor();

                    // Animate from current dot to new target
                    _animation = Tween<double>(
                      begin: avatarCurrentDot.toDouble(),
                      end: newTargetDot.toDouble(),
                    ).animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.easeInOut))
                      ..addListener(() {
                        setState(() {
                          // Update dots dynamically
                          for (int i = 0; i < totalDots; i++) {
                            if (_animation.value >= i) {
                              isReached[i] = true;
                            }
                          }
                          avatarCurrentDot = _animation.value.toInt();
                        });
                      });

                    // Restart animation
                    _animationController.forward(from: 0);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define positions for the previous goal and the secret goal
    final previousGoalPosition = Offset(100, screenHeight * 0.3);
    final secretGoalPosition = Offset(screenWidth - 250, screenHeight * 0.3);

    // Calculate spacing between dots
    final dx = (secretGoalPosition.dx - previousGoalPosition.dx) / totalDots;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Goals',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.flag,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Increase your savings to reach your goals',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  // Achieved goal (left)
                  Positioned(
                    left: previousGoalPosition.dx - 75,
                    top: previousGoalPosition.dy - 125,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/card.png',
                          width: 150,
                          height: 150,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Stanley Cup',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dots along the wiggly line
                  ...List.generate(totalDots, (index) {
                    final xPosition = previousGoalPosition.dx + index * dx + 60;
                    final yPosition =
                        previousGoalPosition.dy + 20 * sin(index * pi / 3);

                    return Positioned(
                      left: xPosition,
                      top: yPosition,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              isReached[index] ? Colors.white : Colors.grey,
                        ),
                      ),
                    );
                  }),
                  // Secret goal (right)
                  Positioned(
                    left: secretGoalPosition.dx - 75,
                    top: secretGoalPosition.dy - 125,
                    child: Column(
                      children: [
                        const Text(
                          'To unlock, your savings should exceed this amount:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${maxSavings.toStringAsFixed(0)} KWD',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              '?',
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Avatar animation
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final index = _animation.value.toInt();
                      final xOffset = previousGoalPosition.dx + index * dx + 60;
                      final yOffset = previousGoalPosition.dy +
                          20 * sin(index * pi / 3) -
                          40;

                      return Positioned(
                        left: xOffset,
                        top: yOffset,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  const AssetImage('assets/images/avatar.png'),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Savings',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _showAddToSavingsDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                              child: const Text('+ Add To Savings'),
                            ),
                          ],
                        ),
                      );
                    },
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
