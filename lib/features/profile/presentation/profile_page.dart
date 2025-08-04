import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/domain/entities/app_user.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:todo_bloc/features/profile/presentation/components/bio_box.dart';
import 'package:todo_bloc/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:todo_bloc/features/profile/presentation/cubit/profile_states.dart';
import 'package:todo_bloc/features/profile/presentation/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  // startup init
  @override
  void initState() {
    super.initState();

    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.profileUser;

          return Scaffold(
            appBar: AppBar(
              foregroundColor: Theme.of(context).colorScheme.primary,
              title: Text(user.name),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () => Navigator.push(context, 
                MaterialPageRoute(builder: (context) => EditProfilePage(user: user,))), 
                icon: Icon(Icons.settings))
              ],
            ),
            body: Center(
              child: Column(
                children: [
                  Text(user.email, style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                  SizedBox(height: 25,),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                            imageUrl: user.profileImageUrl,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),

                            errorWidget: (context, url, error) => Icon(
                              Icons.person,
                              size: 72,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider),
                          ),
                  ),

                  SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Text("Bio", style: TextStyle(color: Theme.of(context).primaryColor),),
                      ],
                    ),
                  ),

                  // Profile Bio
                  SizedBox(height: 10 ,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: BioBox(text: user.bio),

                  ),

                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Text("Posts", style: TextStyle(color: Theme.of(context).primaryColor),),
                      ],
                    ),
                  ),

                  // Profile Posts
                  
                  
                ],
              ),
            ),
          );
        } else if (state is Profileloading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(body: Center(child: Text("No Profile Found...")));
        }
      },
    );
  }
}
