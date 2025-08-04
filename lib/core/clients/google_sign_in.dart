import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'google_sign_in.g.dart';

@Riverpod(keepAlive: true)
GoogleSignIn googleAuth(Ref ref) {
  throw UnimplementedError('googleAuthProvider must be overriden');
}
