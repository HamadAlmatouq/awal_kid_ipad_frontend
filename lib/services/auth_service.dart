import 'package:dio/dio.dart';
import 'client.dart';

class AuthService {
  static Future<String?> signIn(String civilId) async {
    try {
      final response = await Client.dio.post(
        '/kid/signin',
        data: {
          'civilID': civilId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        print('Token received: ${response.data['token']}'); // Debug print
        return response.data['token'];
      }
      return null;
    } on DioException catch (e) {
      print('Sign in error: ${e.message}');
      return null;
    }
  }
}
