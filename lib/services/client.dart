import 'package:dio/dio.dart';
import 'token_storage.dart';

class Client {
  static final String _baseUrl = 'http://localhost:8000';
  static final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));

  static void initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }
}
