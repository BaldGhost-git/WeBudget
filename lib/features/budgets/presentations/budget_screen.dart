import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/controllers/user_controller.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const String path = "/budget";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Budget Screen"),
            SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(userControllerProvider);
                return user.when(
                  data: (data) {
                    if (data == null) return Text("No user, this is an error");
                    return Text(data.toString());
                  },
                  error: (error, stackTrace) => Text("Error happen, $error"),
                  loading: () => CircularProgressIndicator(),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) => ElevatedButton(
                onPressed: ref.read(authControllerProvider.notifier).signOut,
                child: Text('Sign out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
