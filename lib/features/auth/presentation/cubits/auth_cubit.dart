import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/features/auth/domain/entities/app_user.dart';
import 'package:todo_bloc/features/auth/domain/repository/auth_repo.dart';
import 'package:todo_bloc/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check if user is already auth
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user
  AppUser? get currentUser => _currentUser;

  //login with email
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //regsiter with email
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailPassword(
        name,
        email,
        password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  //logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Unauthenticated());
  }
}
