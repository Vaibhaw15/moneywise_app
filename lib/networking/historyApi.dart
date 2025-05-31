import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/historyModel.dart';
import '../models/transactionModel.dart';

class HistoryApi {
  final Dio dio = GetIt.instance<Dio>();

  Future<List<HistoryModel>> getTransactionHistory({
    required String userId,
    required String date,
    required String token,
  }) async {
    try {
      print('BASE URL: ${dio.options.baseUrl}');

      final response = await dio.get(
        "moneywise/transaction-history/get",
        queryParameters: {
          "userId": userId,
          "date": date,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
          responseType: ResponseType.plain, // ✅ Get raw text
        ),
      );

      if (response.statusCode == 200) {
        final rawData = response.data;

        final dynamic parsedData = _tryDecodeJson(rawData);

        if (parsedData is List) {
          return parsedData.map((e) => HistoryModel.fromJson(e)).toList();
        } else if (parsedData is String) {
          // Plain text response like: "No transaction history found for userId: 13."
          throw Exception(parsedData);
        } else {
          throw Exception("Unexpected response format.");
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching transaction history: $e');
      rethrow;
    }
  }

  dynamic _tryDecodeJson(String data) {
    try {
      return json.decode(data);
    } catch (_) {
      return "No Data Found"; // plain text fallback
    }
  }
}
