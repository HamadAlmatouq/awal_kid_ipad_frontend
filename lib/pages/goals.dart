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
  int totalDots = 19; // Reduced from 20 to 19 for better spacing
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
    if (totalDots <= 0 || amount <= 0) return;

    isReached = List.generate(totalDots, (index) => false);

    // Calculate progress and clamp it to maximum of 1.0
    double progress = (savings / amount).clamp(0.0, 1.0);

    // Reduce target dot by 3 to ensure avatar stops further from goal
    int maxDot = totalDots - 3; // Changed from -2 to -3 to stop one dot earlier
    int avatarTargetDot = (progress * maxDot).floor();

    // Ensure target dot doesn't exceed maximum
    avatarTargetDot = avatarTargetDot.clamp(0, maxDot);

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
                        'Add to Savings',
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
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFFF38E22),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter amount to add',
                          hintStyle: TextStyle(
                            color: Color(0xFFF38E22).withOpacity(0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF38E22).withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFF38E22),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () async {
                          final amountText = controller.text.trim();
                          if (amountText.isNotEmpty) {
                            try {
                              Navigator.pop(context);
                              final response = await Client.dio.post(
                                '/kid/convertBalanceToSavings',
                                data: {'amount': int.parse(amountText)},
                              );

                              if (response.statusCode == 200 && mounted) {
                                final newSavings =
                                    savings + int.parse(amountText);
                                setState(() {
                                  savings = newSavings;
                                });

                                if (amount > 0) {
                                  await Future.microtask(() {
                                    double progress =
                                        (newSavings / amount).clamp(0.0, 1.0);
                                    int maxDot = totalDots -
                                        3; // Use same logic as _initializeAnimation
                                    int newTargetDot =
                                        (progress * maxDot).floor();
                                    newTargetDot =
                                        newTargetDot.clamp(0, maxDot);

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

                                if (newSavings >= amount) {
                                  await _handleCelebration();
                                }

                                await _fetchSavings();
                              }
                            } on DioError catch (e) {
                              String errorMessage = 'Failed to convert balance';

                              // Check if the error response contains a message
                              if (e.response?.data != null &&
                                  e.response?.data is Map) {
                                errorMessage =
                                    e.response?.data['message'] ?? errorMessage;
                              }

                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'An error occurred while processing your request'),
                                    backgroundColor: Colors.red,
                                    duration: const Duration(seconds: 3),
                                    behavior: SnackBarBehavior.floating,
                                    margin: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
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
                              'Add',
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
    final previousGoalPosition =
        Offset(150, screenHeight * 0.3); // Increased from 100 to 150
    // Move secret goal position slightly right to create space
    final secretGoalPosition = Offset(screenWidth - 200, screenHeight * 0.3);

    // Adjust dot spacing to leave room before secret goal
    final availableWidth = secretGoalPosition.dx -
        previousGoalPosition.dx -
        200; // Decreased from 250 to 200 to bring dots closer to goal
    final dx = totalDots > 0 ? availableWidth / totalDots : 0.0;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Goal.png'), // Background image
                fit: BoxFit.cover,
                alignment: Alignment.topCenter, // Align the image to the top
              ),
            ),
            margin: const EdgeInsets.only(
                top: 5.0), // Minimal push down by 5 pixels
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 30.0), // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30), // Increased spacing
                Row(
                  children: [
                    const Text(
                      'Goals',
                      style: TextStyle(
                        fontSize: 64, // Increased from 48
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(
                      Icons.flag,
                      color: Colors.white,
                      size: 50, // Increased to match new text size
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Save up and make your dreams come true!',
                  style: TextStyle(
                    fontSize: 36, // Increased from 26
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30), // Increased spacing
                Expanded(
                  child: Stack(
                    children: [
                      // Replace the Achieved goal (left) position with Starting point
                      Positioned(
                        left: previousGoalPosition.dx - 150,
                        top: previousGoalPosition.dy - 125,
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF38E22),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.star,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Starting Point',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dots along the wiggly line
                      if (totalDots > 0)
                        ...List.generate(totalDots, (index) {
                          final xPosition = previousGoalPosition.dx +
                              index * dx +
                              100; // Increased from 60 to 100
                          final yPosition = previousGoalPosition.dy +
                              20 * sin(index * pi / 3);

                          return Positioned(
                            left: xPosition,
                            top: yPosition,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: CircleAvatar(
                                radius: 8, // Increased dot size from 6
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
                              'To unlock,\nreach this amount:',
                              style: TextStyle(
                                fontSize: 24, // Enlarged font size
                                fontWeight: FontWeight.w400,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${amount.toStringAsFixed(0)} KWD',
                              style: const TextStyle(
                                fontSize: 28, // Enlarged font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              width: 200, // Increased from 150
                              height: 200, // Increased from 150
                              decoration: BoxDecoration(
                                color: showSecretGoal
                                    ? Colors
                                        .transparent // Changed from Colors.orange to transparent
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
                                  radius: 80, // Increased from 60
                                  backgroundImage: const AssetImage(
                                      'assets/images/avatar.png'),
                                ),
                                const SizedBox(height: 10), // Increased spacing
                                Text(
                                  'Savings',
                                  style: const TextStyle(
                                    fontSize: 26, // Increased from 20
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${savings.toStringAsFixed(3)} KWD',
                                  style: const TextStyle(
                                    fontSize: 28, // Increased from 22
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _showAddToSavingsDialog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 15),
                                  ),
                                  child: const Text(
                                    '+ Add To Savings',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color(
                                          0xFFF38E22), // Changed to orange
                                    ),
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
                padding: const EdgeInsets.all(24), // Increased from 16
                child: const Text(
                  '🎉 Goal Reached! Congratulations! 🎉',
                  style: TextStyle(
                    fontSize: 32, // Increased from 24
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
