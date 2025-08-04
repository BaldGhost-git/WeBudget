import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const String path = '/auth';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final String? userId = ref.watch(authControllerProvider)?.email;
    final controller = ref.read(authControllerProvider.notifier);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userId ?? 'Not signed in'),
            ElevatedButton(
              onPressed: userId == null
                  ? controller.signInWithGoogle
                  : controller.signOut,
              child: Text(userId == null ? 'Sign in with Google' : 'Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
