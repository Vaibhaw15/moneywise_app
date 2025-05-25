import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/button.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Image.asset('assets/images/logo.png',
              height: 420,
              width: 400,
              fit: BoxFit.fitWidth,
            ),
          ),
          const Spacer(),
          // App name
          const Text(
            'MoneyWise',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle
          const Text(
            'Take control of your finances with ease.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 220),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: CustomButton(
              text: 'Sign Up',
              color: Color(0xFF54D12B),
              onPressed: () {
                context.push('/register');
              },
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: CustomButton(
              text: 'Log In',
              color: Color(0xFF2E3829),
              onPressed: () {
                context.push('/login');
              },
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}