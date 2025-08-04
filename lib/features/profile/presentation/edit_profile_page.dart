import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/presentation/pages/components/custom_textfield.dart';
import 'package:todo_bloc/features/profile/domain/entities/profile_user.dart';
import 'package:todo_bloc/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:todo_bloc/features/profile/presentation/cubit/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  PlatformFile? imagePickedFile;
  Uint8List? webImage;

  // bio text controller
  final bioTextController = TextEditingController();

  // File picker
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // profile update
  void updateProfile() async {
    final profileCubit = context.read<ProfileCubit>();

    // prepare images
    final String uid = widget.user.uid;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebBytes = kIsWeb ? imagePickedFile?.bytes : null;
    final String? newBio = bioTextController.text.isNotEmpty
        ? bioTextController.text
        : null;

    if (imagePickedFile != null || newBio != null) {
      profileCubit.updateProfile(
        uid: uid,
        newBio: bioTextController.text,
        imageMobilePath: imageMobilePath,
        imageWebBytes: imageWebBytes,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        // Profile loading
        if (state is Profileloading) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(
                    "Uploading...",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          buildEditPage();
        }

        return buildEditPage();
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: () {
              updateProfile();
            },
            icon: Icon(Icons.upload),
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: Column(
        children: [
          //change pfp area
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.hardEdge,
              child: (!kIsWeb && imagePickedFile != null)
                  ? Image.file(File(imagePickedFile!.path!), fit: BoxFit.cover,)
                  : (kIsWeb && webImage != null)
                  ? Image.memory(webImage!)
                  : CachedNetworkImage(
                      imageUrl: widget.user.profileImageUrl,
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
          ),

          const SizedBox(height: 25),

          Center(
            child: MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: Text("Pick Image"),
            ),
          ),

          // change bio area
          Text("Bio", style: TextStyle(color: Theme.of(context).primaryColor)),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            child: CustomTextfield(
              controller: bioTextController,
              hintText: "Edit Bio",
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
