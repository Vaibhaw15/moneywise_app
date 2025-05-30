


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneywise/networking/categoryApi.dart';
import 'package:moneywise/networking/historyApi.dart';
import 'package:moneywise/screens/addEditModule/bloc/addEdit_screen_bloc.dart';
import 'package:moneywise/screens/addEditModule/event/addEdit_screen_event.dart';
import 'package:moneywise/screens/addEditModule/ui/addEditScreen.dart';
import 'package:moneywise/screens/history/bloc/history_screen_bloc.dart';
import 'package:moneywise/screens/history/event/history_screen_event.dart';
import 'package:moneywise/screens/history/ui/history_screen.dart';
import 'package:moneywise/screens/landing/ui/langing_screen.dart';
import 'package:moneywise/screens/logIn/bloc/LogInBloc.dart';
import 'package:moneywise/screens/logIn/ui/logIn_screen.dart';
import 'package:moneywise/screens/signup/bloc/signup_screen_bloc.dart';
import 'package:moneywise/screens/signup/ui/signup_screen.dart';
import 'package:moneywise/util/screen/login_signup_screen.dart';
import 'package:moneywise/util/screen/splash_screen.dart';

class RouterConfiguration {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: [
          GoRoute(
            path: '/loginSignup',
            builder: (BuildContext context, GoRouterState state) {
              return const LoginSignupScreen();
            },
          ),
          GoRoute(
            path: '/register',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                  create: (_) => RegisterBloc(),
                  child: SignUpScreen());
            },
          ),
          GoRoute(
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                  create: (_) => LoginBloc(),
                  child: LogInScreen());
            },
          ),
          GoRoute(
            path: '/landing',
            builder: (BuildContext context, GoRouterState state) {
              return LandingScreen();
            },
          ),
          GoRoute(
            path: '/addEditScreen',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (_) => AddEditBloc(CategoryApi())..add(AddEditEventLoadCategories()),
                child: const AddEditScreen(),
              );
            },
          ),
          GoRoute(
            path: '/historyScreen',
            builder: (BuildContext context, GoRouterState state) {
              return BlocProvider(
                create: (_) => HistoryBloc(HistoryApi())..add(LoadTransactionHistory()),
                child: const HistoryScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );
}