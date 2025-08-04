import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/data/firebase_auth_repo.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_states.dart';
import 'package:todo_bloc/features/auth/presentation/pages/auth_page.dart';
import 'package:todo_bloc/features/home/presentation/pages/home_page.dart';
import 'package:todo_bloc/features/profile/data/firebase_profile_repo.dart';
import 'package:todo_bloc/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:todo_bloc/features/storage/data/firebase_storage_repo.dart';
import 'package:todo_bloc/themes/light_mode.dart';

class MyApp extends StatelessWidget {
  final authRepo = FirebaseAuthRepo();
  final profileRepo = FirebaseProfileRepo();
  final storageRepo = FirebaseStorageRepo();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // For firebase authentication
        BlocProvider(
          create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
        ),

        // For profile cubit
        BlocProvider(
          create: (context) =>
              ProfileCubit(profileRepo: profileRepo, storageRepo: storageRepo),
        ),
      ],
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
