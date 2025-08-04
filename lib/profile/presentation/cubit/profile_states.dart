import 'package:todo_bloc/profile/domain/entities/profile_user.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class Profileloading extends ProfileStates {}

class ProfileLoaded extends ProfileStates {
  final ProfileUser profileUser;

  ProfileLoaded(this.profileUser);
}

class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}
