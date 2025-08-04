import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("H O M E"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
