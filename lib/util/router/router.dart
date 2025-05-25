import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:moneywise/addEditModule/ui/addEditScreen.dart';
import 'package:moneywise/logIn/ui/logIn_screen.dart';
import 'package:moneywise/signup/ui/signup_screen.dart';
import 'package:moneywise/util/screen/splash_screen.dart';

import '../../history/ui/history_screen.dart';
import '../../landing/ui/langing_screen.dart';
import '../screen/login_signup_screen.dart';


class RouterConfiguration {
  static final GoRouter router = GoRouter(
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
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return LogInScreen();
            },
          ),
          GoRoute(
            path: '/register',
            builder: (BuildContext context, GoRouterState state) {
              return SignUpScreen();
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
              return AddEditScreen();
            },
          ),
          GoRoute(
            path: '/historyScreen',
            builder: (BuildContext context, GoRouterState state) {
              return HistoryScreen();
            },
          ),
        ],
      ),
    ],
  );
}