

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class LogInApi{

  final Dio dio = GetIt.instance<Dio>();

  Future<Response>  login(String email, String password) async {
    try {
      print('BASE URL: ${dio.options.baseUrl}');
      Response response = await dio.post(
        "moneywise/auth/login", // ✅ relative to baseUrl
        data: {
          "email": email,
          "password": password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}