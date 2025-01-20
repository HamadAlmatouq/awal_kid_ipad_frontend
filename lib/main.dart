import 'package:flutter/material.dart';
import 'Header.dart';
import 'ProfileCard.dart';
import 'TasksSection.dart';
import 'NavigationBar.dart' as custom;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF38E22),
        fontFamily: 'Inter',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(
              greeting: 'Good Morning, Maymoona!',
              onNotificationTap: () {},
              onEditTap: () {},
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
                    SizedBox(width: 16),
                    Expanded(
                      flex: 3,
                      child: TasksSection(
                        tasks: [
                          Task(title: 'Brush your hair.', reward: '2 KWD'),
                          Task(title: 'Brush your hair.', reward: '2 KWD'),
                          Task(title: 'Brush your hair.', reward: '2 KWD'),
                        ],
                        completedTasks: [
                          Task(title: 'Brush your hair.', reward: '2 KWD'),
                          Task(title: 'Brush your hair.', reward: '2 KWD'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: custom.NavigationBar(),
    );
  }
}
