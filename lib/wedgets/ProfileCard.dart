import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String avatarUrl;
  final double currentAccount;
  final double savings;
  final int steps;
  final int points;

  const ProfileCard({
    Key? key,
    this.avatarUrl =
        'https://dashboard.codeparrot.ai/api/assets/Z43jO3Tr0Kgj1uYG',
    this.currentAccount = 23.030,
    this.savings = 33.870,
    this.steps = 2902,
    this.points = 3213,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 60, // Pushed the container further down
              left: 20,
              child: Container(
                constraints: BoxConstraints(minWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Current Account Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Current Account',
                                  style: TextStyle(
                                    fontSize: 20, // Increased font size
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 12), // Increased spacing
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$currentAccount',
                                      style: TextStyle(
                                        fontSize: 34, // Larger font size
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'KWD',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/card.png',
                            width: 180, // Larger card image
                            height: 120, // Larger card image
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Savings Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '$savings',
                                      style: TextStyle(
                                        fontSize: 30, // Slightly larger font
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'KWD',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Savings',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      Divider(color: Colors.black.withOpacity(0.18)),

                      // Steps and Points Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40), // Padding
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Steps Section
                            Column(
                              children: [
                                Text(
                                  '$steps',
                                  style: TextStyle(
                                    fontSize: 30, // Larger font size
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8), // Added spacing
                                Text(
                                  'Steps',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),

                            // Add large spacing between Steps and Points
                            const SizedBox(width: 50), // Increased spacing

                            // Vertical Divider
                            Container(
                              width: 1,
                              height: 60, // Taller divider
                              color: Color(0xFFD1D1D1),
                            ),

                            // Add more spacing after divider
                            const SizedBox(width: 50),

                            // Points Section
                            Column(
                              children: [
                                Text(
                                  '$points',
                                  style: TextStyle(
                                    fontSize: 30, // Larger font size
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8), // Added spacing
                                Text(
                                  'Points',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Profile Icon
            Positioned(
              top: 0,
              left: 20,
              child: CircleAvatar(
                radius: 55, // Adjusted for the larger profile picture
                backgroundColor: Colors.white, // White circular frame
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
