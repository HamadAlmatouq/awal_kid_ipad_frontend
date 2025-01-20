import 'package:flutter/material.dart';
import 'screens/signin_page.dart'; // Import the WelcomeScreen
import 'screens/qr_scanner_screen.dart'; // Import the QRScannerScreen
import 'screens/home_page.dart'; // Import the HomePage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(), // Set the SignInPage as the home screen
      routes: {
        '/home': (context) => const HomePage(),
        '/qr_scanner': (context) => const QRScannerScreen(),
      },
    );
  }
}
