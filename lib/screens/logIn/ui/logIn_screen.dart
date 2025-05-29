import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneywise/screens/logIn/bloc/LogInBloc.dart';
import 'package:moneywise/screens/logIn/event/lognInEvent.dart';
import 'package:moneywise/screens/logIn/state/LogInState.dart';

import '../../../util/component/button.dart';
import '../../../util/component/textfield.dart';




class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: const BackButton(color: Colors.white),
          title: const Text('Log In', style: TextStyle(color: Colors.white)),
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
                  SizedBox(height: 24),

                  // BlocListener<LoginBloc, LoginState>(
                  //   listener: (context, state) {
                  //     if (state is LoginSuccess) {
                  //       context.pushReplacement('/landing');
                  //     }
                  //     if (state is LoginFailure) {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text(state.errorMessage)),
                  //       );
                  //     }
                  //   },
                  //   child: BlocBuilder<LoginBloc, LoginState>(
                  //     builder: (context, state) {
                  //       if (state is LoginLoading) {
                  //         return Center(child: CircularProgressIndicator());
                  //       }
                  //
                  //       return CustomButton(
                  //         text: 'Log In',
                  //         color: Color(0xFF54D12B),
                  //         onPressed: () {
                  //           final username = emailController.text.trim();
                  //           final password = passwordController.text.trim();
                  //
                  //           context.read<LoginBloc>().add(
                  //             LoginButtonPressed(userName: username, password: password),
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ),

                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        context.go('/landing');
                      }
                      if (state is LoginFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return CustomButton(
                        text: 'Log In',
                        color: Color(0xFF54D12B),
                        onPressed: () {
                          final username = emailController.text.trim();
                          final password = passwordController.text.trim();

                          context.read<LoginBloc>().add(
                            LoginButtonPressed(userName: username, password: password),
                          );
                        },
                      );
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
