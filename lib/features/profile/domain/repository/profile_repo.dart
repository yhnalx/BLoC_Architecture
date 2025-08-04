import 'package:todo_bloc/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchuserProfile(String uid);
  Future<void> updateProfile(ProfileUser updatedProfile);
}
