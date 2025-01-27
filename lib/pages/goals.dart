import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:confetti/confetti.dart';
import '../services/client.dart';
import 'dart:convert'; // Add this import at the top
import 'dart:typed_data'; // Add this import

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
  double amount = 0.0; // Target savings amount from goals
  List<bool> isReached = []; // Tracks whether each dot has been reached
  int avatarCurrentDot = 0; // Tracks the current dot of the avatar
  bool goalReached = false; // Prevents multiple triggers
  bool showBanner = false; // Controls the visibility of the celebration banner
  bool showSecretGoal = false; // Controls the visibility of the secret goal
  String? goalImage; // Add this to class variables at the top
  Uint8List? _cachedImage; // Add this variable

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
        _checkGoalReached(); // Check if goal is reached after fetching data
      }
    } catch (e) {
      print('Error fetching savings: $e');
    }
  }

  Future<void> _fetchGoals() async {
    try {
      final response = await Client.dio.get('/kid/goals');
      if (response.statusCode == 200 && response.data != null) {
        final goals = List<Map<String, dynamic>>.from(response.data);
        print('Goals data: $goals'); // Debug print

        if (goals.isNotEmpty) {
          Map<String, dynamic>? nextGoal;
          for (var goal in goals) {
            final goalAmount =
                double.tryParse(goal['amount'].toString()) ?? 0.0;
            if (goalAmount > savings) {
              nextGoal = goal;
              break;
            }
          }

          setState(() {
            if (nextGoal != null) {
              amount = double.tryParse(nextGoal['amount'].toString()) ?? 0.0;
              goalImage = nextGoal['image']?.toString();
              print('Next goal - amount: $amount, image: $goalImage');
            } else {
              final lastGoal = goals.last;
              amount = double.tryParse(lastGoal['amount'].toString()) ?? 0.0;
              goalImage = lastGoal['image']?.toString();
              print('Last goal - amount: $amount, image: $goalImage');
            }
          });
        }
      }
    } catch (e) {
      print('Error fetching goals: $e');
      setState(() {
        amount = 0.0;
        goalImage = null;
      });
    }
  }

  void _initializeAnimation() {
    if (totalDots <= 0 || amount <= 0)
      return; // Ensure totalDots and amount are not zero or negative

    // Initialize dots as unreached
    isReached = List.generate(totalDots, (index) => false);

    // Calculate progress on page load
    double progress = savings / amount;
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
          if (savings >= amount && !goalReached) {
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
    if (mounted) {
      setState(() {
        showBanner = true;
        showSecretGoal = true;
        print(
            'Showing celebration, savings: $savings, goal: $amount'); // Debug print
      });

      _confettiController.play();

      // Hide the banner after delay
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() {
            showBanner = false;
          });
        }
      });
    }
  }

  void _checkGoalReached() {
    if (!goalReached && savings >= amount && amount > 0) {
      print('Goal reached! Savings: $savings, Goal: $amount'); // Debug print
      goalReached = true;
      _showCelebration();
    }
  }

  Future<void> _handleCelebration() async {
    try {
      if (!goalReached && mounted) {
        // Update state first
        setState(() {
          goalReached = true;
          showSecretGoal = true;
        });

        // Play confetti after state update
        await Future.microtask(() => _confettiController.play());

        // Show banner after small delay
        await Future.delayed(const Duration(milliseconds: 100));
        if (mounted) {
          setState(() {
            showBanner = true;
          });
        }

        // Hide banner after delay
        await Future.delayed(const Duration(seconds: 3));
        if (mounted) {
          setState(() {
            showBanner = false;
          });
        }
      }
    } catch (e) {
      print('Error in celebration: $e');
    }
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
                    Navigator.pop(context); // Close dialog first

                    final response = await Client.dio.post(
                      '/kid/convertBalanceToSavings',
                      data: {
                        'amount': int.parse(amountText),
                      },
                    );

                    if (response.statusCode == 200 && mounted) {
                      // Update local state
                      final newSavings = savings + int.parse(amountText);
                      setState(() {
                        savings = newSavings;
                      });

                      // Handle animation separately
                      if (amount > 0) {
                        await Future.microtask(() {
                          double progress = newSavings / amount;
                          int newTargetDot = (progress * totalDots).floor();

                          _animation = Tween<double>(
                            begin: avatarCurrentDot.toDouble(),
                            end: newTargetDot.toDouble(),
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.easeInOut,
                          ));

                          _animationController.forward(from: 0);
                        });
                      }

                      // Check goal completion after animation starts
                      if (newSavings >= amount) {
                        await _handleCelebration();
                      }

                      // Refresh data at the end
                      await _fetchSavings();
                    }
                  } catch (e) {
                    print('Error converting balance: $e');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to convert balance: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Uint8List? _getDecodedImage() {
    if (_cachedImage != null) return _cachedImage;
    if (goalImage == null) return null;

    try {
      _cachedImage = base64Decode(goalImage!);
      return _cachedImage;
    } catch (e) {
      print('Error decoding image: $e');
      return null;
    }
  }

  @override
  void didUpdateWidget(GoalsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (goalImage != null) {
      _cachedImage = null;
    }
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
                              '${amount.toStringAsFixed(0)} KWD',
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
                                    ? (goalImage != null
                                        ? FutureBuilder<Uint8List?>(
                                            future: Future(
                                                () => _getDecodedImage()),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                      ConnectionState.waiting ||
                                                  snapshot.data == null) {
                                                return Container(
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[400],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '?',
                                                      style: TextStyle(
                                                        fontSize: 50,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.memory(
                                                  snapshot.data!,
                                                  width: 150,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                          )
                                        : const Icon(
                                            Icons.image_not_supported,
                                            size: 50,
                                            color: Colors.white,
                                          ))
                                    : const Text(
                                        '?',
                                        style: TextStyle(
                                          fontSize: 50,
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
