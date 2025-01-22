// import 'package:flutter/material.dart';
// import 'Header.dart';
// import 'ProfileCard.dart';
// import 'TasksSection.dart';
// import 'NavigationBar.dart' as custom;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xFFF38E22),
//         fontFamily: 'Inter',
//       ),
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Header(
//               greeting: 'Good Morning, Maymoona!',
//               onNotificationTap: () {},
//               onEditTap: () {},
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: ProfileCard(
//                         avatarUrl:
//                             'https://dashboard.codeparrot.ai/api/assets/Z43jO3Tr0Kgj1uYG',
//                         currentAccount: 23.030,
//                         savings: 33.870,
//                         steps: 2902,
//                         points: 3213,
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     Expanded(
//                       flex: 3,
//                       child: TasksSection(
//                         tasks: [
//                           Task(
//                             title: 'Water the plants',
//                             reward: '4 KWD',
//                             duration: 3, // Task duration in hours
//                             timeLeft: 1, // Remaining time in hours
//                           ),
//                           Task(
//                             title: 'Feed the birdies',
//                             reward: '2 KWD',
//                             duration: 2,
//                             timeLeft: 1.5, // 1.5 hours left
//                           ),
//                           Task(
//                             title: 'Eat your veggies',
//                             reward: '5 KWD',
//                             duration: 1, // Task duration in hours
//                             timeLeft: 0.083, // 5 minutes = 5/60 hours
//                           ),
//                         ],
//                         completedTasks: [
//                           Task(
//                             title: 'Fold the laundry',
//                             reward: '5 KWD',
//                           ),
//                           Task(
//                             title: 'Comb your hair',
//                             reward: '2 KWD',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: custom.NavigationBar(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'Header.dart';
import 'ProfileCard.dart';
import 'TasksSection.dart';
import 'NavigationBar.dart' as custom;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF38E22),
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Header(
              greeting: 'Good Morning, Maymoona!',
              onNotificationTap: null,
              onEditTap: null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ProfileCard(
                        avatarUrl:
                            'https://dashboard.codeparrot.ai/api/assets/Z43jO3Tr0Kgj1uYG',
                        currentAccount: 23.030,
                        savings: 33.870,
                        steps: 2902,
                        points: 3213,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      flex: 3,
                      child:
                          TasksSection(), // Remove the parameters since they're defined with default values
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const custom.NavigationBar(),
    );
  }
}
