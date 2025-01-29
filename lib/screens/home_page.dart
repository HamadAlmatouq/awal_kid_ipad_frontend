import 'package:awal_kid_ipad_frontend/Header.dart';
import 'package:awal_kid_ipad_frontend/pages/games.dart';
import 'package:awal_kid_ipad_frontend/wedgets/ProfileCard.dart';
import 'package:awal_kid_ipad_frontend/wedgets/TasksSection.dart';
import 'package:awal_kid_ipad_frontend/NavigationBar.dart' as custom;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../services/client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/goals.dart'; // Import the GoalsPage
import '../providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentTab = 'Home';
  Map<String, dynamic>? userData;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
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
                    'Sign Out',
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
                  child: Text(
                    'Are you sure you want to sign out?',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFF38E22),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            context.pop(); // Close dialog
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);
                            authProvider.logout();
                            context.go('/signin'); // Use GoRouter to navigate
                          },
                          child: Container(
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
                            child: Center(
                              child: Text(
                                'Sign Out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
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
              ],
            ),
          ),
        );
      },
    );
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
        return RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _fetchUserData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Header(
                  greeting: 'Good Morning, ${userData!['Kname'] ?? 'Kid'}!',
                  onNotificationTap: null,
                  onEditTap: null,
                ),
                Container(
                  height: MediaQuery.of(context).size.height -
                      200, // Adjust height to ensure scrollability
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
              ],
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF38E22),
                    Color(0xFFF5A147),
                    Color(0xFFF6AE60),
                    Color(0xFFF49734),
                  ],
                ),
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${userData?['Kname'] ?? 'Kid'}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xFFF38E22)),
              title: Text(
                'Sign out',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF38E22),
                ),
              ),
              onTap: () {
                context.pop(); // Close drawer using GoRouter
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
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
        onTabSelected: (selectedTab) async {
          setState(() {
            _currentTab = selectedTab;
          });
          // Refresh data when switching to home tab
          if (selectedTab == 'Home') {
            await _fetchUserData();
          }
        },
      ),
    );
  }
}
