import 'package:awal_kid_ipad_frontend/pages/civil_id_signin.dart';
import 'package:awal_kid_ipad_frontend/pages/sign_page.dart';
import 'package:awal_kid_ipad_frontend/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'NavigationBar.dart' as custom;
import 'Header.dart';
import 'wedgets/ProfileCard.dart';
import 'wedgets/TasksSection.dart';

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

