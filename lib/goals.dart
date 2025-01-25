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
  List<bool> isReached = []; // Tracks whether each dot has been reached
  int currentGoal = 15; // Number of completed dots
  double userSavings = 33.87; // Current savings
  final double maxSavings = 55.0; // Target savings

  @override
  void initState() {
    super.initState();

    // Initialize the isReached list with all values set to false
    isReached = List.generate(totalDots, (index) => false);

    // Animation controller setup
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: totalDots.toDouble()).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          // Update reached dots dynamically as the avatar moves
          for (int i = 0; i < totalDots; i++) {
            if (_animation.value >= i) {
              isReached[i] = true; // Mark dot as reached
            }
          }
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
                          width: 150, // Smaller size
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
                          radius: 6, // Dot size
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
                          40; // Adjusted upward

                      return Positioned(
                        left: xOffset,
                        top: yOffset,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60, // Avatar size
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
