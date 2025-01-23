import 'package:awal_kid_ipad_frontend/games.dart';
import 'package:awal_kid_ipad_frontend/pages/civil_id_signin.dart';
import 'package:awal_kid_ipad_frontend/screens/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'NavigationBar.dart' as custom;
import 'Header.dart';
import 'ProfileCard.dart';
import 'TasksSection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/sign',
      routes: [
        GoRoute(
          path: '/signin',
          builder: (context, state) => CivilIDSignIn(),
        ),
        GoRoute(
          path: '/sign',
          builder: (context, state) => SignPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => HomePage(),
        ),
      ],
    );
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF38E22),
        fontFamily: 'Inter',
      ),
      // home: const SignPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _currentTab = 'Home';

  Widget _buildContent() {
    switch (_currentTab) {
      case 'Games':
        return GamesPage();
      // const Center(
      //   child: Text(
      //     'Games Page',
      //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //   ),
      // );
      case 'Goals':
        return const Center(
          child: Text(
            'Goals Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return const Column(
          children: [
            Header(
              greeting: 'Good Morning, Maymoona!',
              onNotificationTap: null,
              onEditTap: null,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
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
                    SizedBox(width: 16),
                    Expanded(
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
      body: SafeArea(
        child: _buildContent(),
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
