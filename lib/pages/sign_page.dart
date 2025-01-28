import 'package:awal_kid_ipad_frontend/pages/Sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/qr_scanner_screen.dart';
import '../screens/home_page.dart'; // Import the new home page

class SignPage extends StatelessWidget {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF38E22),
              Color(0xFFF5A147),
              Color(0xFFF6AE60),
              Color(0xFFF49734),
            ],
            stops: [0.0, 0.33, 0.64, 0.97],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Banner
                Image.network(
                  'https://dashboard.codeparrot.ai/api/assets/Z4yVpr9JV5SvYOiQ',
                  width: 700, // Adjusted for landscape
                  height: 180, // Adjusted for landscape
                ),
                const SizedBox(height: 40),
                // Awal Text
                const Text(
                  'awal.',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 140, // Adjusted for landscape
                    color: Colors.white,
                    letterSpacing: -0.23,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Subtitle
                const Text(
                  'Your child\'s future starts here',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 24, // Adjusted for landscape
                    color: Colors.white,
                    letterSpacing: -0.23,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // QR Code Text
                const Text(
                  'To Sign in, scan the QR code!',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 20, // Adjusted for landscape
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Scan QR Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRScannerScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 220, // Adjusted for landscape
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Scan QR code',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20, // Adjusted for landscape
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF38E22),
                          letterSpacing: -0.23,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // OR Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100, // Adjusted for landscape
                      height: 1,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20, // Adjusted for landscape
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 100, // Adjusted for landscape
                      height: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Sign in Text
                GestureDetector(
                  onTap: () {
                    context.go("/signin");
                  },
                  child: const Text(
                    'sign in',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20, // Adjusted for landscape
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
