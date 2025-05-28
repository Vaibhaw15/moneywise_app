import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moneywise/packages/Dio.dart';
import 'package:moneywise/packages/SharedPreferenceService.dart';





final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Register SharedPreferenceService (async init)
  final sharedPrefService = await SharedPreferenceService.getInstance();
  getIt.registerSingleton<SharedPreferenceService>(sharedPrefService);

  final apiClient = ApiClient(); // ✅ create instance
  getIt.registerSingleton<Dio>(apiClient.dio); //

}