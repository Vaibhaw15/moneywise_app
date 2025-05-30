
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../models/categoryModel.dart';

class CategoryApi {
  final Dio dio = GetIt.instance<Dio>();

  Future<List<CategoryModel>> getCategory() async {
    try {
      print('BASE URL: ${dio.options.baseUrl}');
      final response = await dio.get(
        "moneywise/app-category/get",
      );

      final List data = response.data as List;

      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching transaction history: $e');
      rethrow;
    }
  }
}
