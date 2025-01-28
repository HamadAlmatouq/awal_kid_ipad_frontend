import 'dart:io';
import 'package:awal_kid_ipad_frontend/models/User.dart';
import 'package:awal_kid_ipad_frontend/services/auth_service.dart';
import 'package:awal_kid_ipad_frontend/services/client.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static const tokenKey = "token";
  User? user;
  String token = "";

  Future<bool> signin({
    required String civilId,
  }) async {
    try {
      final receivedToken = await AuthService.signIn(civilId);
      if (receivedToken != null && receivedToken.isNotEmpty) {
        token = receivedToken;
        await setToken(token);
        print('Token set: $token'); // Debug print
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Sign in error: $e");
      return false;
    }
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    print('Token stored: $token'); // Debug print

    if (token.isNotEmpty &&
        Jwt.getExpiryDate(token) != null &&
        Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      try {
        user = User.fromJson(Jwt.parseJwt(token));
        Client.dio.options.headers = {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        };
        print('User set: ${user?.toJson()}'); // Debug print
      } catch (e) {
        print("Invalid token: $e");
        user = null;
      }
    } else {
      user = null;
    }
  }

  bool isAuth() {
    if (token.isNotEmpty &&
        Jwt.getExpiryDate(token) != null &&
        Jwt.getExpiryDate(token)!.isAfter(DateTime.now())) {
      try {
        user = User.fromJson(Jwt.parseJwt(token));
        Client.dio.options.headers[HttpHeaders.authorizationHeader] =
            "Bearer $token";
        return true;
      } catch (e) {
        print("Invalid token: $e");
        return false;
      }
    }
    return false;
  }

  Future<void> initializeAuth() async {
    await _getToken();
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(tokenKey) ?? "";
    print('Token retrieved: $token'); // Debug print
    notifyListeners();
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tokenKey);
    token = "";

    Client.dio.options.headers.remove(HttpHeaders.authorizationHeader);
    notifyListeners();
  }
}
