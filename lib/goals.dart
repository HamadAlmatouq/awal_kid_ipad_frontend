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
  int currentGoal = 15; // Number of completed dots
  double userSavings = 33.87; // Current savings
  final double maxSavings = 55.0; // Target savings
  final int totalDots = 20; // Total number of dots

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation = Tween<double>(begin: 0, end: currentGoal.toDouble()).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
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
                    if (userSavings >= maxSavings) {
                      currentGoal++;
                      _animationController.forward(from: 0);
                    }
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
    final previousGoalPosition =
        Offset(100, screenHeight * 0.3); // Adjusted upward
    final secretGoalPosition =
        Offset(screenWidth - 250, screenHeight * 0.3); // Brought closer

    // Calculate spacing between dots
    final dx = (secretGoalPosition.dx - previousGoalPosition.dx) / totalDots;
    final dy = (secretGoalPosition.dy - previousGoalPosition.dy) / totalDots;

    // Generate wiggly line dots between the two goals
    final dots = List.generate(totalDots, (index) {
      final isReached = index < currentGoal; // Reached dots logic
      final xPosition = previousGoalPosition.dx +
          index * dx +
          60; // Shifted 60px to the right
      final yPosition = previousGoalPosition.dy +
          20 * sin(index * pi / 3); // Smooth wavy line
      return Positioned(
        left: xPosition,
        top: yPosition,
        child: CircleAvatar(
          radius: 6, // Dot size
          backgroundColor: isReached ? Colors.white : Colors.grey,
        ),
      );
    });

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
                    fontSize: 28, // Slightly smaller
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.flag, // Example icon for "Goals"
                  color: Colors.white,
                  size: 24, // Adjusted size
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Increase your savings to reach your goals',
              style: TextStyle(
                fontSize: 16, // Adjusted font size
                fontWeight: FontWeight.w400,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 20), // Reduced spacing
            Expanded(
              child: Stack(
                children: [
                  // Achieved goal (left)
                  Positioned(
                    left: previousGoalPosition.dx - 75,
                    top: previousGoalPosition.dy - 125, // Adjusted upward
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/card.png',
                          width: 150, // Smaller size
                          height: 150,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Stanley Cup',
                          style: TextStyle(
                            fontSize: 16, // Smaller font size
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Wiggly line dots path
                  ...dots,
                  // Secret goal (right)
                  Positioned(
                    left: secretGoalPosition.dx - 75,
                    top: secretGoalPosition.dy - 125, // Adjusted upward
                    child: Column(
                      children: [
                        const Text(
                          'To unlock, your savings should exceed this amount:',
                          style: TextStyle(
                            fontSize: 16, // Smaller font size
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${maxSavings.toStringAsFixed(0)} KWD',
                          style: const TextStyle(
                            fontSize: 20, // Adjusted size
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 150, // Smaller size
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              '?',
                              style: TextStyle(
                                fontSize: 40, // Smaller font size
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
                      final xOffset = previousGoalPosition.dx +
                          index * dx +
                          60; // Adjusted right
                      final yOffset = previousGoalPosition.dy +
                          20 * sin(index * pi / 3) -
                          40; // Shifted avatar upward by 40px

                      return Positioned(
                        left: xOffset,
                        top: yOffset,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60, // Smaller avatar
                              backgroundImage:
                                  const AssetImage('assets/images/avatar.png'),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Savings',
                              style: const TextStyle(
                                fontSize: 16, // Adjusted font size
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userSavings.toStringAsFixed(3)} KWD',
                              style: const TextStyle(
                                fontSize: 16, // Adjusted size
                                color: Colors.white,
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
