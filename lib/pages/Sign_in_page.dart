import 'package:awal_kid_ipad_frontend/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/auth_provider.dart';

class CivilIDSignIn extends StatefulWidget {
  const CivilIDSignIn({super.key});

  @override
  State<CivilIDSignIn> createState() => _CivilIDSignInState();
}

class _CivilIDSignInState extends State<CivilIDSignIn> {
  final _formKey = GlobalKey<FormState>();
  final _civilIdController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final success =
            await authProvider.signin(civilId: _civilIdController.text);

        if (mounted) {
          if (success) {
            final token = authProvider.token;
            print('Login successful with token: $token'); // Debug print

            // Save token to SharedPreferences
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('auth_token', token!);

            context.go("/home");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid Civil ID. Please try again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

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
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontFamily: 'Jua',
                    fontSize: 80, // Increased font size
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 60), // Increased spacing
                Container(
                  width: 500, // Increased width
                  padding: const EdgeInsets.all(30), // Increased padding
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _civilIdController,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24), // Increased font size
                          decoration: InputDecoration(
                            labelText: 'Civil ID',
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 24), // Increased font size
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(12),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Civil ID';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30), // Increased spacing
                        ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60, // Increased padding
                              vertical: 20, // Increased padding
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 30, // Increased size
                                  height: 30, // Increased size
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFF38E22),
                                    strokeWidth: 3, // Increased stroke width
                                  ),
                                )
                              : const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color(0xFFF38E22),
                                    fontSize: 24, // Increased font size
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ],
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
