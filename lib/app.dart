import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/data/firebase_auth_repo.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_states.dart';
import 'package:todo_bloc/features/auth/presentation/pages/auth_page.dart';
import 'package:todo_bloc/post/presentation/pages/home_page.dart';
import 'package:todo_bloc/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthStates>(
          builder: (context, authState) {
            print(authState);

            if (authState is Unauthenticated) {
              return const AuthPage();
            }

            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ),
    );
  }
}
