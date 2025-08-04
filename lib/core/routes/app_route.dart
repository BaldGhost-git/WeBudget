import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/presentations/login_screen.dart';
import 'package:we_budget/features/budgets/presentations/budget_screen.dart';

part 'app_route.g.dart';

enum AppRoute { auth, budget, transactions }

@Riverpod(keepAlive: true)
GoRouter getRoutes(Ref ref) {
  final user = ref.watch(authControllerProvider);
  return GoRouter(
    initialLocation: user == null ? AuthScreen.path : BudgetScreen.path,
    routes: [
      // GoRoute(path: '/', builder: (context, state) => Placeholder()),
      GoRoute(
        name: AppRoute.auth.name,
        path: AuthScreen.path,
        builder: (context, state) => AuthScreen(),
      ),
      GoRoute(
        path: BudgetScreen.path,
        name: AppRoute.budget.name,
        builder: (context, state) => BudgetScreen(),
      ),
    ],
  );
}
