import 'package:todo_bloc/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  // we will be using this for login
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  // we will be using this for registration
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  );

  // for logout
  Future<void> logout();

  // to get current user
  Future<AppUser?> getCurrentUser();
}
