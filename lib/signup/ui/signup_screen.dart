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
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(color: Colors.white),
        title: const Text('Register', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
