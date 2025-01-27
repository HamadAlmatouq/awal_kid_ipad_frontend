import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import '../services/client.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late ConfettiController _confettiController; // Confetti animation controller
  int totalDots = 20; // Total number of dots
  double savings = 0.0; // Initialize savings
  double? amount; // Change to nullable double for loading state
  List<bool> isReached = []; // Tracks whether each dot has been reached
  int avatarCurrentDot = 0; // Tracks the current dot of the avatar
  bool goalReached = false; // Prevents multiple triggers
  bool showBanner = false; // Controls the visibility of the celebration banner
  bool showSecretGoal = false; // Controls the visibility of the secret goal

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5), // Smooth animation duration
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _fetchSavings();
    // Initialize ConfettiController
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  Future<void> _fetchSavings() async {
    try {
      final response = await Client.dio.get('/kid/info');
      if (response.statusCode == 200 && response.data != null) {
        setState(() {
          savings = (response.data['savings'] as num).toDouble();
          print('Fetched savings: $savings'); // Debug print
        });
        await _fetchGoals();
        _initializeAnimation();
      }
    } catch (e) {
      print('Error fetching savings: $e');
    }
  }

  Future<void> _fetchGoals() async {
    try {
      final response = await Client.dio.get('/kid/goals');
      if (response.statusCode == 200 && response.data != null) {
        print('Raw response data: ${response.data}'); // Debug print

        // The response.data is already a List, so we can use it directly
        final List<dynamic> goals = List<dynamic>.from(response.data);

        print('Processed goals: $goals'); // Debug print

        if (goals.isNotEmpty) {
          // Find the next goal with amount greater than current savings
          for (var goal in goals) {
            if (goal is Map<String, dynamic> && goal.containsKey('amount')) {
              final goalAmount =
                  double.tryParse(goal['amount'].toString()) ?? 0.0;
              if (goalAmount > savings) {
                setState(() {
                  amount = goalAmount;
                  print('Setting amount to: $goalAmount'); // Debug print
                });
                return;
              }
            }
          }

          // If no goal is greater than savings, use the largest amount
          if (amount == null) {
            final largestGoal = goals.reduce((curr, next) {
              final currAmount =
                  double.tryParse(curr['amount'].toString()) ?? 0.0;
              final nextAmount =
                  double.tryParse(next['amount'].toString()) ?? 0.0;
              return currAmount > nextAmount ? curr : next;
            });
            setState(() {
              amount = double.tryParse(largestGoal['amount'].toString()) ?? 0.0;
              print('Setting to largest amount: $amount'); // Debug print
            });
          }
        }
      }
    } catch (e, stackTrace) {
      print('Error fetching goals: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        amount = 0.0;
      });
    }
  }

  void _initializeAnimation() {
    if (totalDots <= 0 || amount == null || amount! <= 0) return;

    // Initialize dots as unreached
    isReached = List.generate(totalDots, (index) => false);

    // Calculate progress on page load
    double progress = savings / amount!;
    int avatarTargetDot = (progress * totalDots).floor();

    // Set up animation to move avatar to calculated target on page load
    _animation = Tween<double>(begin: 0, end: avatarTargetDot.toDouble())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {
          // Update dots dynamically as avatar moves
          for (int i = 0; i < totalDots; i++) {
            if (_animation.value >= i && i < isReached.length) {
              isReached[i] = true;
            }
          }
          avatarCurrentDot = _animation.value.toInt(); // Update current dot

          // Trigger celebration when goal is reached (only once)
          if (savings >= amount! && !goalReached) {
            goalReached = true; // Mark goal as reached
            _showCelebration();
          }
        });
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose AnimationController first
    _confettiController.dispose(); // Dispose ConfettiController here
    super.dispose(); // Call the superclass dispose method last
  }

  void _showCelebration() {
    setState(() {
      showBanner = true; // Show the banner
      showSecretGoal = true; // Show the secret goal
    });

    _confettiController.play(); // Start confetti animation

    // Hide the banner after 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        showBanner = false; // Hide the banner
      });
    });
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
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final amountText = controller.text.trim();
                if (amountText.isNotEmpty) {
                  try {
                    print('Sending amount: $amountText'); // Debug print
                    final response = await Client.dio.post(
                      '/kid/convertBalanceToSavings',
                      data: {
                        'amount': int.parse(amountText)
                      }, // Convert to integer
                    );

                    print('Response: ${response.data}'); // Debug print

                    if (response.statusCode == 200) {
                      await _fetchSavings(); // Refresh data
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print('Error converting balance to savings: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter an amount'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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
    final dx = totalDots > 0
        ? (secretGoalPosition.dx - previousGoalPosition.dx) / totalDots
        : 0.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
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
                        fontSize: 36, // Enlarged font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Increase your savings to reach your goals',
                  style: TextStyle(
                    fontSize: 20, // Enlarged font size
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
                                fontSize: 20, // Enlarged font size
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dots along the wiggly line
                      if (totalDots > 0)
                        ...List.generate(totalDots, (index) {
                          final xPosition =
                              previousGoalPosition.dx + index * dx + 60;
                          final yPosition = previousGoalPosition.dy +
                              20 * sin(index * pi / 3);

                          return Positioned(
                            left: xPosition,
                            top: yPosition,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor:
                                    isReached.isNotEmpty && isReached[index]
                                        ? Colors.white
                                        : Colors.grey,
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
                              'To unlock,\nyour savings should \nexceed this amount:',
                              style: TextStyle(
                                fontSize: 18, // Enlarged font size
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              amount != null
                                  ? '${amount!.toStringAsFixed(0)} KWD'
                                  : 'Loading...',
                              style: const TextStyle(
                                fontSize: 22, // Enlarged font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: showSecretGoal
                                    ? Colors.orange
                                    : Colors.grey[400],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: showSecretGoal
                                    ? Image.asset(
                                        'assets/images/secret_goal.png',
                                        width: 150,
                                        height: 150,
                                      )
                                    : const Text(
                                        '?',
                                        style: TextStyle(
                                          fontSize: 50, // Enlarged font size
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
                          final xOffset =
                              previousGoalPosition.dx + index * dx + 60;
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
                                  backgroundImage: const AssetImage(
                                      'assets/images/avatar.png'),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Savings',
                                  style: const TextStyle(
                                    fontSize: 20, // Enlarged font size
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${savings.toStringAsFixed(3)} KWD',
                                  style: const TextStyle(
                                    fontSize: 22, // Enlarged font size
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _showAddToSavingsDialog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                  ),
                                  child: const Text(
                                    '+ Add To Savings',
                                    style: TextStyle(
                                        fontSize: 18), // Enlarged font
                                  ),
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
          // Celebration Banner
          if (showBanner)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.orange,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  '🎉 Goal Reached! Congratulations! 🎉',
                  style: TextStyle(
                    fontSize: 24, // Enlarged font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          // Confetti Animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.blue,
                Colors.orange,
                Colors.pink,
                Colors.green
              ],
            ),
          ),
        ],
      ),
    );
  }
}
