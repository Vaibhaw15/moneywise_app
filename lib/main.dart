

import 'package:flutter/material.dart';
import 'package:moneywise/util/router/router.dart';
import 'package:moneywise/util/service_locator.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouterConfiguration.router
    );
  }
}


