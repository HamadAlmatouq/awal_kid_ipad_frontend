import 'package:flutter/material.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _characterController;
  late Animation<double> _characterAnimation;
  double _savings = 33.870;
  final double _targetAmount = 55.0;
  final int _currentStep = 4;
  final int _totalSteps = 12;

  @override
  void initState() {
    super.initState();
    _characterController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _characterAnimation =
        Tween<double>(begin: 0, end: 1).animate(_characterController);
    _characterController.forward();
  }

  @override
  void dispose() {
    _characterController.dispose();
    super.dispose();
  }

  void _addToSavings() {
    setState(() {
      _savings += 1.0; // Add 1 KWD for demo purposes
    });
  }

  Widget _buildProgressPoint(int index, bool isActive) {
    return Container(
      width: 44,
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Image.asset(
        'assets/images/avatar.png',
        fit: BoxFit.contain,
        color: isActive ? null : Colors.grey.withOpacity(0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFDE5A),
            Color(0xFFF5A147),
            Color(0xFFF6AE60),
            Color(0xFFF49734),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Goals',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Increase your savings to reach your goals',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              // Main Content Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Goal Item
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.25),
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'assets/images/avatar.png',
                            width: 135,
                            height: 94,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'stanly cup',
                          style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFFF5A147),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Savings Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Savings',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            _savings.toStringAsFixed(3),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'KWD',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white.withOpacity(0.65),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _addToSavings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFFF5A44D),
                          minimumSize: const Size(178, 39),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '+ Add To Savings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Unlock Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'To unlock, your savings should\nexceed this amount:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$_targetAmount KWD',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            '?',
                            style: TextStyle(
                              fontSize: 96,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // Progress Path
              Container(
                height: 200,
                child: Stack(
                  children: [
                    // Progress points
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(_totalSteps, (index) {
                          return _buildProgressPoint(
                              index, index <= _currentStep);
                        }),
                      ),
                    ),

                    // Animated character
                    AnimatedBuilder(
                      animation: _characterAnimation,
                      builder: (context, child) {
                        return Positioned(
                          left: _characterAnimation.value *
                              (MediaQuery.of(context).size.width - 100),
                          bottom: 20,
                          child: Container(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              'assets/images/avatar.png',
                              fit: BoxFit.contain,
                            ),
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
      ),
    );
  }
}
