import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class RegisterApi {
  final Dio dio = GetIt.instance<Dio>();

  Future<Response> registerWithEmail(String email, String password, String name) async {
    try {
      print('BASE URL: ${dio.options.baseUrl}');
      Response response = await dio.post(
        "moneywise/auth/createUser",
        data: {
          "email": email,
          "password": password,
          "userName": name,
        },
        options: Options(
          responseType: ResponseType.plain, // Prevent auto JSON parsing
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        // Handle conflict case explicitly
        print('User already exists (409 Conflict)');
        return e.response!;
      } else {
        rethrow; // Rethrow other Dio errors
      }
    } catch (e) {
      // Handle other unexpected exceptions if needed
      rethrow;
    }
  }
}
