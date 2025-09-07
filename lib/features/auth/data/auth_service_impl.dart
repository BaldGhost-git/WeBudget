import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/features/auth/data/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final SupabaseClient _client;
  final GoogleSignIn _googleSignIn;

  AuthServiceImpl({
    required SupabaseClient client,
    required GoogleSignIn googleSignIn,
  }) : _client = client,
       _googleSignIn = googleSignIn;

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _client.auth.signOut();
  }

  @override
  User? get currentUser {
    if (_client.auth.currentUser == null) return null;
    return _client.auth.currentUser;
  }

  @override
  Future<void> signInWithEmail(String email, String password) {
    // TODO: implement signInWithEmail
    throw UnimplementedError("Email authentication coming soon");
  }

  @override
  Future<void> signInWithOAuth(AuthProvider provider) async {
    if (provider != AuthProvider.google) {
      throw UnimplementedError("This OAuth is unavailable");
    }
    final supaProvider = switch (provider) {
      AuthProvider.google => OAuthProvider.google,
    };
    final googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;

    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    await _client.auth.signInWithIdToken(
      provider: supaProvider,
      idToken: idToken,
    );
  }

  @override
  Stream<User?> get userChanges => _client.auth.onAuthStateChange.map((e) {
    if (e.session?.user == null) return null;
    return e.session?.user;
  });
}
