import 'package:awal_kid_ipad_frontend/games.dart';
import 'package:awal_kid_ipad_frontend/pages/Sign_in_page.dart';
import 'package:awal_kid_ipad_frontend/pages/sign_page.dart';
import 'package:awal_kid_ipad_frontend/screens/home_page.dart';
import 'package:awal_kid_ipad_frontend/services/client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'NavigationBar.dart' as custom;
import 'Header.dart';
import 'wedgets/ProfileCard.dart';
import 'wedgets/TasksSection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences
      .getInstance(); // Ensure shared_preferences is initialized
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider()..initializeAuth(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/signin',
      routes: [
        GoRoute(
          path: '/signin',
          builder: (context, state) => const CivilIDSignIn(),
        ),
        GoRoute(
          path: '/sign',
          builder: (context, state) => const SignPage(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
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
    );
  }
}
