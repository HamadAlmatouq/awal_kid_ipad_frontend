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
        final token = response.data['token'];
        print('Token received: $token'); // Debug print
        return token;
      }
      return null;
    } on DioError catch (e) {
      print('Sign in error: ${e.message}');
      return null;
    }
  }
}
