import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moneywise/models/transactionModel.dart';

class AddEditApi{

  final Dio dio = GetIt.instance<Dio>();

  Future<String> saveTransaction(TransactionModel transaction) async {
    try {
      final response = await dio.post(
        "moneywise/transaction/addEdit",
        data: transaction.toJson(),
        options: Options(
          responseType: ResponseType.plain, // 👈 Accept plain text like "SUCCESS"
        ),
      );

      if (response.statusCode == 201 && response.data == "SUCCESS") {
        print("Transaction saved successfully");
        return response.data;
      } else {
        throw Exception('Failed to save transaction: ${response.data}');
      }

    } on DioException catch (e) {
      print("DioException: ${e.message}");
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
  }


}