import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/core/clients/google_sign_in.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/auth/data/auth_service.dart';
import 'package:we_budget/features/auth/data/auth_service_impl.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  late final AuthService _auth;
  @override
  User? build() {
    _auth = ref.watch(authServiceProvider);
    return _auth.currentUser;
  }

  Future<void> signInWithGoogle() async {
    await _auth.signInWithOAuth(AuthProvider.google);
    state = _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    state = null;
  }
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final googleSignIn = ref.read(googleAuthProvider);
  final client = ref.read(supabaseInstanceProvider);
  return AuthServiceImpl(client: client, googleSignIn: googleSignIn);
}
