import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../util/component/button.dart';
import '../../util/component/textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    SizedBox(width: 100), // spacing between arrow and text
                    Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                CustomTextField(
                  labelText: 'Name',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  labelText: 'Confirm Password',
                  controller: passwordController,
                  isPassword: true,
                ),
                SizedBox(height: 24),
                CustomButton(
                  text: 'Register',
                  color: Color(0xFF54D12B),
                  onPressed: () {
                    // Handle login logic
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
