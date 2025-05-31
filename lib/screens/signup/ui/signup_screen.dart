import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../util/component/button.dart';
import '../../../util/component/textfield.dart';
import '../bloc/signup_screen_bloc.dart';
import '../event/signup_screen_event.dart';
import '../state/register_screen_state.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (_) => RegisterBloc(),
        child:SafeArea(
          child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: const BackButton(color: Colors.white),
                title: const Text('Register', style: TextStyle(color: Colors.white)),
                centerTitle: true,
                elevation: 0,
              ),
                body: BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
                      );
                    } else if (state is RegisterSuccess) {
                      context.push('/login'); // ✅ Use path or pushNamed('login')

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message + " Please log in to continue.",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      });
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
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
                                controller: nameController,
                                keyboardType: TextInputType.name,
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
                                controller: confirmPasswordController,
                                isPassword: true,
                              ),
                              SizedBox(height: 24),
                              state is RegisterLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : CustomButton(
                                text: 'Register',
                                color: Color(0xFF54D12B),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if(passwordController.text != confirmPasswordController.text){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Passwords do not match", style: TextStyle(color: Colors.white)), backgroundColor: Colors.red),
                                    );
                                    return;

                                  }
                                  context.read<RegisterBloc>().add(
                                    RegisterSubmitted(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
            ),
        )
      ),
    );
  }
}
