import 'package:we_budget/features/auth/models/user_model.dart';

abstract class AuthService<T> {
  T? get currentUser;
  Stream<T?> get userChanges;
  Future<void> signInWithEmail(String email, String password);
  Future<void> signInWithOAuth(AuthProvider provider);
  Future<void> signOut();
}

enum AuthProvider { google }
