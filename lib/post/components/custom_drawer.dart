import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/post/components/custom_tile.dart';
import 'package:todo_bloc/profile/presentation/profile_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              Divider(color: Theme.of(context).colorScheme.secondary),

              // tiles
              // HOME
              CustomTile(
                title: "H O M E",
                icon: Icons.home,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),

              // PROFILES
              CustomTile(
                title: "P R O F I L E",
                icon: Icons.person,
                onTap: () {
                  Navigator.of(context).pop();

                  // get current user
                  final user = context.read<AuthCubit>().currentUser;
                  String? uid = user!.uid;

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage(uid: uid,)),
                  );
                },
              ),

              // SEARCH
              CustomTile(
                title: "S E A R C H",
                icon: Icons.search,
                onTap: () {},
              ),

              // SETTINGS
              CustomTile(
                title: "S E T T I N G S",
                icon: Icons.settings,
                onTap: () {},
              ),

              Spacer(),
              // LOGOUT
              CustomTile(
                title: "L O G O U T",
                icon: Icons.logout,
                onTap: () => context.read<AuthCubit>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
