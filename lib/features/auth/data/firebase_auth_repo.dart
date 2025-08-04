import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_bloc/features/auth/domain/entities/app_user.dart';
import 'package:todo_bloc/features/auth/domain/repository/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Login
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      return user;
    } catch (e) {
      throw Exception('Login Failed $e');
    }
  }

  // Register
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    // To attempt account creation
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // User creation
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // Save to firebase
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      return user;
    } catch (e) {
      throw Exception('Login Failed $e');
    }
  }

  // Current user
  @override
  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }

  // Logout
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
