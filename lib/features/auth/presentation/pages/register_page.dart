import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/features/auth/presentation/pages/components/custom_button.dart';
import 'package:todo_bloc/features/auth/presentation/pages/components/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePage;

  const RegisterPage({super.key, required this.togglePage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPw = confirmPasswordController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPw.isNotEmpty) {
      if (password == confirmPw) {
        authCubit.register(name, email, password);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Password do not match!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out all missing fields")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                Text("Let's get you started!"),
                SizedBox(height: 25),

                // name textfield
                CustomTextfield(
                  controller: nameController,
                  hintText: 'Full Name',
                  obscureText: false,
                ),
                SizedBox(height: 10),

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
                SizedBox(height: 10),

                // confirm password textfield
                CustomTextfield(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(height: 25),

                // login button
                CustomButton(
                  onTap: () {
                    register();
                  },
                  text: 'Submit',
                ),
                SizedBox(height: 25),

                // not a member something
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePage,
                      child: Text(
                        " Login now",
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
