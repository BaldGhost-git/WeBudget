import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/presentations/login_screen.dart';
import 'package:we_budget/features/budgets/presentations/upsert_budget_screen.dart';
import 'package:we_budget/features/budgets/presentations/budget_detail.dart';
import 'package:we_budget/features/home/presentations/home_screen.dart';
import 'package:we_budget/features/settings/presentations/settings_screen.dart';
import 'package:we_budget/features/transactions/presentations/transactions_create_screen.dart';

part 'app_route.g.dart';

enum AppRoute {
  auth,
  home,
  budget,
  createBudget,
  transactions,
  createTransactions,
  settings,
}

@Riverpod(keepAlive: true)
GoRouter getRoutes(Ref ref) {
  final user = ref.watch(authControllerProvider);
  return GoRouter(
    initialLocation: user == null ? AuthScreen.path : HomeScreen.path,
    routes: [
      GoRoute(
        name: AppRoute.auth.name,
        path: AuthScreen.path,
        builder: (context, state) => AuthScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        name: AppRoute.home.name,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: UpsertBudgetScreen.path,
        name: AppRoute.createBudget.name,
        builder: (context, state) {
          final extras = state.extra! as Map<String, dynamic>;
          return UpsertBudgetScreen(
            extras['formKey'],
            onSubmit: extras['onSubmit'],
            budget: extras['budget'],
          );
        },
      ),
      GoRoute(
        path: "${BudgetDetail.path}/:budgetId",
        name: AppRoute.budget.name,
        builder: (context, state) => BudgetDetail(
          budgetId: int.parse(state.pathParameters["budgetId"]!),
        ),
      ),
      GoRoute(
        path: SettingsScreen.path,
        name: AppRoute.settings.name,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: CreateTransactionScreen.path,
        name: AppRoute.createTransactions.name,
        builder: (context, state) => CreateTransactionScreen(),
      ),
    ],
  );
}
