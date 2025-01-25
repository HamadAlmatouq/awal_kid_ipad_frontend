import 'package:awal_kid_ipad_frontend/Header.dart';
import 'package:awal_kid_ipad_frontend/wedgets/ProfileCard.dart';
import 'package:awal_kid_ipad_frontend/wedgets/TasksSection.dart';
import 'package:awal_kid_ipad_frontend/NavigationBar.dart' as custom;
import 'package:flutter/material.dart';

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
        return const Center(
          child: Text(
            'Games Page',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
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
