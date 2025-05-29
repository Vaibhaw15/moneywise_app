import 'package:dio/dio.dart';

import 'SharedPreferenceService.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(BaseOptions(
    baseUrl: 'https://moneywise-m08q.onrender.com/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  )) {
    // Optional: Add interceptors
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = SharedPreferenceService.getString("token");
        // Skip Authorization for login path
        if (!options.path.contains('/auth/login') && !options.path.contains('/auth/createUser')) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }


  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  // POST Request
  Future<Response> post(String path, Map<String, dynamic> data) async {
    return await dio.post(path, data: data);
  }

}
