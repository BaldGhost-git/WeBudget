import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/core/constants/env.dart';
import 'package:we_budget/app.dart';
import 'package:we_budget/core/clients/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.SUPABASE_URL, anonKey: Env.SUPABASE_KEY);
  final googleClient = GoogleSignIn.instance;
  await googleClient.initialize(serverClientId: Env.AUTH_CLIENT);

  runApp(
    ProviderScope(
      overrides: [googleAuthProvider.overrideWithValue(googleClient)],
      child: const WeBudgetApp(),
    ),
  );
}
