// // import 'package:flutter/material.dart';

// // class ProfileCard extends StatelessWidget {
// //   final String avatarUrl;
// //   final double currentAccount;
// //   final double savings;
// //   final int steps;
// //   final int points;

// //   const ProfileCard({
// //     Key? key,
// //     this.avatarUrl =
// //         'https://dashboard.codeparrot.ai/api/assets/Z43jO3Tr0Kgj1uYG',
// //     this.currentAccount = 23.030,
// //     this.savings = 33.870,
// //     this.steps = 2902,
// //     this.points = 3213,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Stack(
// //           children: [
// //             Positioned(
// //               top: 40,
// //               left: 20,
// //               child: Container(
// //                 constraints: BoxConstraints(minWidth: 400),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.circular(25),
// //                 ),
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(top: 70),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     children: [
// //                       const SizedBox(height: 20),
// //                       // Current Account section
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.account_balance_wallet,
// //                               color: Colors.black, size: 40),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             'Current Account',
// //                             style: TextStyle(
// //                               fontSize: 24,
// //                               fontWeight: FontWeight.w700,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Text(
// //                             '$currentAccount',
// //                             style: TextStyle(
// //                               fontSize: 32,
// //                               fontWeight: FontWeight.w600,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 5),
// //                           Text(
// //                             'KWD',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w700,
// //                               color: Colors.black.withOpacity(0.5),
// //                             ),
// //                           ),
// //                         ],
// //                       ),

// //                       Divider(color: Colors.black.withOpacity(0.18)),

// //                       // Savings section
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.savings, color: Colors.black, size: 40),
// //                           const SizedBox(width: 8),
// //                           Text(
// //                             '$savings',
// //                             style: TextStyle(
// //                               fontSize: 32,
// //                               fontWeight: FontWeight.w600,
// //                               color: Colors.black,
// //                             ),
// //                           ),
// //                           const SizedBox(width: 5),
// //                           Text(
// //                             'KWD',
// //                             style: TextStyle(
// //                               fontSize: 16,
// //                               fontWeight: FontWeight.w700,
// //                               color: Colors.black.withOpacity(0.5),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       Text(
// //                         'Savings',
// //                         style: TextStyle(
// //                           fontSize: 24,
// //                           fontWeight: FontWeight.w700,
// //                           color: Colors.black,
// //                         ),
// //                       ),

// //                       Divider(color: Colors.black.withOpacity(0.18)),

// //                       // Steps and Points section
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           Column(
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Icon(Icons.directions_walk,
// //                                       color: Colors.black, size: 40),
// //                                   const SizedBox(width: 8),
// //                                   Text(
// //                                     '$steps',
// //                                     style: TextStyle(
// //                                       fontSize: 32,
// //                                       fontWeight: FontWeight.w700,
// //                                       color: Colors.black,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Text(
// //                                 'Steps',
// //                                 style: TextStyle(
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: Colors.black,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                           Container(
// //                             width: 1,
// //                             height: 39,
// //                             color: Color(0xFFD1D1D1),
// //                           ),
// //                           Column(
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Icon(Icons.star,
// //                                       color: Colors.black, size: 40),
// //                                   const SizedBox(width: 8),
// //                                   Text(
// //                                     '$points',
// //                                     style: TextStyle(
// //                                       fontSize: 32,
// //                                       fontWeight: FontWeight.w700,
// //                                       color: Colors.black,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                               Text(
// //                                 'Points',
// //                                 style: TextStyle(
// //                                   fontSize: 24,
// //                                   fontWeight: FontWeight.w700,
// //                                   color: Colors.black,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             Positioned(
// //               top: 0,
// //               left: 20,
// //               child: Transform(
// //                 alignment: Alignment.center,
// //                 transform: Matrix4.rotationY(3.14159), // Flip horizontally
// //                 child: CircleAvatar(
// //                   radius: 50,
// //                   backgroundImage: NetworkImage(avatarUrl),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class ProfileCard extends StatelessWidget {
//   final String avatarUrl;
//   final double currentAccount;
//   final double savings;
//   final int steps;
//   final int points;

//   const ProfileCard({
//     Key? key,
//     this.avatarUrl =
//         'https://dashboard.codeparrot.ai/api/assets/Z43jO3Tr0Kgj1uYG',
//     this.currentAccount = 23.030,
//     this.savings = 33.870,
//     this.steps = 2902,
//     this.points = 3213,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Stack(
//           children: [
//             Positioned(
//               top: 80, // Adjusted to give space for the enlarged avatar
//               left: 20,
//               right: 20,
//               child: Container(
//                 constraints: BoxConstraints(minWidth: 400),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 70),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20),

//                       // Current Account section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                               'Current Account',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 '$currentAccount',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.green,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               Text(
//                                 'KWD',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black.withOpacity(0.6),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Image.asset(
//                                 'assets/images/card.png',
//                                 width: 40,
//                                 height: 40,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       Divider(color: Colors.black.withOpacity(0.18)),

//                       // Savings section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                               'Savings',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 '$savings',
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               Text(
//                                 'KWD',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black.withOpacity(0.6),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Image.asset(
//                                 'assets/images/card.png',
//                                 width: 40,
//                                 height: 40,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),

//                       Divider(color: Colors.black.withOpacity(0.18)),

//                       // Steps and Points section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 '$steps',
//                                 style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 'Steps',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Container(
//                             width: 1,
//                             height: 39,
//                             color: Color(0xFFD1D1D1),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 '$points',
//                                 style: TextStyle(
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 'Points',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               left: constraints.maxWidth / 2 - 60, // Center the avatar
//               child: CircleAvatar(
//                 radius: 60, // Enlarged avatar
//                 backgroundImage: NetworkImage(avatarUrl),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
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
              top: 40,
              left: 20,
              child: Container(
                constraints: BoxConstraints(minWidth: 400),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Current Account section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Current Account',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            '$currentAccount',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Large card image
                      Image.asset(
                        'assets/images/card.png',
                        height: 80,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(height: 10),

                      // Savings section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Savings',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            '$savings',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      Divider(color: Colors.black.withOpacity(0.18)),

                      // Steps and Points section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                '$steps',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Steps',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 1,
                            height: 39,
                            color: Color(0xFFD1D1D1),
                          ),
                          Column(
                            children: [
                              Text(
                                '$points',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Points',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
