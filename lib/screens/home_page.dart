// import 'package:awal_kid_ipad_frontend/Header.dart';
// import 'package:awal_kid_ipad_frontend/pages/games.dart';
// import 'package:awal_kid_ipad_frontend/wedgets/ProfileCard.dart';
// import 'package:awal_kid_ipad_frontend/wedgets/TasksSection.dart';
// import 'package:awal_kid_ipad_frontend/NavigationBar.dart' as custom;
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import '../services/client.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../pages/goals.dart'; // Import the GoalsPage

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String _currentTab = 'Home';
//   Map<String, dynamic>? userData;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserData();
//   }

//   Future<void> _fetchUserData() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('token') ?? '';
//       print('Token: $token'); // Debug print
//       if (token.isNotEmpty) {
//         Client.dio.options.headers['Authorization'] = 'Bearer $token';
//         final response = await Client.dio.get('/kid/info');
//         if (response.statusCode == 200 && response.data != null) {
//           setState(() {
//             userData = response.data;
//           });
//           print('User data fetched: $userData'); // Debug print
//         } else {
//           print('Failed to fetch user data: ${response.statusCode}');
//         }
//       } else {
//         print('Token is empty');
//       }
//     } on DioError catch (e) {
//       print('Error fetching user data: $e');
//     }
//   }

//   Widget _buildContent() {
//     if (userData == null) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     switch (_currentTab) {
//       case 'Games':
//         return GamesPage();
//       case 'Goals':
//         return const GoalsPage(); // Use the actual GoalsPage widget
//       default:
//         return Column(
//           children: [
//             const Header(
//               greeting: 'Good Morning, Maymoona!',
//               onNotificationTap: null,
//               onEditTap: null,
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (userData != null) // Ensure userData is not null
//                       Expanded(
//                         flex: 2,
//                         child: ProfileCard(
//                           avatarUrl:
//                               'assets/images/avatar.png', // Changed from URL to local asset
//                           currentAccount:
//                               (userData!['balance'] as num).toDouble(),
//                           savings: (userData!['savings'] as num).toDouble(),
//                           steps: userData!['steps'] as int,
//                           points: userData!['points'] as int,
//                         ),
//                       ),
//                     const SizedBox(width: 16),
//                     const Expanded(
//                       flex: 3,
//                       child: TasksSection(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: _buildContent(),
//       ),
//       bottomNavigationBar: custom.NavigationBar(
//         onTabSelected: (selectedTab) {
//           setState(() {
//             _currentTab = selectedTab;
//           });
//         },
//       ),
//     );
//   }
// }
import 'package:awal_kid_ipad_frontend/Header.dart';
import 'package:awal_kid_ipad_frontend/pages/games.dart';
import 'package:awal_kid_ipad_frontend/wedgets/ProfileCard.dart';
import 'package:awal_kid_ipad_frontend/wedgets/TasksSection.dart';
import 'package:awal_kid_ipad_frontend/NavigationBar.dart' as custom;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../services/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/goals.dart'; // Import the GoalsPage

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentTab = 'Home';
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      print('Token: $token'); // Debug print
      if (token.isNotEmpty) {
        Client.dio.options.headers['Authorization'] = 'Bearer $token';
        final response = await Client.dio.get('/kid/info');
        if (response.statusCode == 200 && response.data != null) {
          setState(() {
            userData = response.data;
          });
          print('User data fetched: $userData'); // Debug print
        } else {
          print('Failed to fetch user data: ${response.statusCode}');
        }
      } else {
        print('Token is empty');
      }
    } on DioError catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Widget _buildContent() {
    if (userData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    switch (_currentTab) {
      case 'Games':
        return GamesPage();
      case 'Goals':
        return const GoalsPage(); // Use the actual GoalsPage widget
      default:
        return Column(
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
                    if (userData != null) // Ensure userData is not null
                      Expanded(
                        flex: 2,
                        child: ProfileCard(
                          avatarUrl:
                              'assets/images/avatar.png', // Changed from URL to local asset
                          currentAccount:
                              (userData!['balance'] as num).toDouble(),
                          savings: (userData!['savings'] as num).toDouble(),
                          steps: userData!['steps'] as int,
                          points: userData!['points'] as int,
                        ),
                      ),
                    const SizedBox(width: 16),
                    const Expanded(
                      flex: 3,
                      child: TasksSection(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/Home.png'), // Background image
          //       fit: BoxFit.cover, // Make the image cover the entire screen
          //     ),
          //   ),
          // ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Home.png'), // Background image
                fit: BoxFit.cover, // Make the image cover the entire screen
                alignment: Alignment.topCenter, // Push the image downward
              ),
            ),
            padding: const EdgeInsets.only(
                top: 50.0), // Adjust this value as needed to push down
          ),
          // Foreground content
          SafeArea(
            child: Container(
              // color: Colors.black.withOpacity(0.4), // Optional overlay
              child: _buildContent(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: custom.NavigationBar(
        onTabSelected: (selectedTab) {
          setState(() {
            _currentTab = selectedTab;
          });
        },
      ),
    );
  }
}
