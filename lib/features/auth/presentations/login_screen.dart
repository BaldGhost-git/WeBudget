import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
    final controller = ref.read(authControllerProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WeBudget', style: theme.textTheme.displayMedium),
            Gap(8),
            Text(
              'Why track it alone, when you can track it together?',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            Gap(16),
            FilledButton(
              onPressed: controller.signInWithGoogle,
              child: Text('Sign in with Google'),
            ),
          ],
        ),
      ),
    );
  }
}
