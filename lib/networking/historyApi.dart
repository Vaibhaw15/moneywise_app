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
      );

      final List data = response.data as List;

      return data.map((e) => HistoryModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching transaction history: $e');
      rethrow;
    }
  }
}
