import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/features/auth/presentation/pages/components/custom_button.dart';
import 'package:todo_bloc/features/auth/presentation/pages/components/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePage;

  const LoginPage({super.key, required this.togglePage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out email and password")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),

                // welcome back msg
                Text("Welcome back, you're missed!"),
                SizedBox(height: 25),

                // email textfield
                CustomTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 10),

                // password textfield
                CustomTextfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 25),
                // login button
                CustomButton(
                  onTap: () {
                    login();
                  },
                  text: 'Login',
                ),
                SizedBox(height: 25),

                // not a member something
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        " Register now",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
