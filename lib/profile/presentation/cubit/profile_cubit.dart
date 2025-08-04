import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/profile/domain/repository/profile_repo.dart';
import 'package:todo_bloc/profile/presentation/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  final ProfileRepo profileRepo;

  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  // fetch
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(Profileloading());
      final user = await profileRepo.fetchuserProfile(uid);

      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // update
  Future<void> updateProfile({required String uid, String? newBio}) async {
    emit(Profileloading());

    try {
      final currentUser = await profileRepo.fetchuserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError("Failed to fetch user for profile update"));
        return;
      }

      // pfp update

      // update new profile
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
      );

      // update in repo
      await profileRepo.updateProfile(updatedProfile);

      // re-fetch the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error updating profile: $e"));
    }
  }
}
