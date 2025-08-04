import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/budgets/data/budget_repository.dart';
import 'package:we_budget/features/budgets/data/budget_repository_impl.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

part 'budget_controller.g.dart';

@riverpod
class BudgetController extends _$BudgetController {
  late final BudgetRepository repository;
  @override
  Future<List<Budget>?> build() async {
    repository = ref.read(budgetRepositoryProvider);
    return getBudgets();
  }

  Future<List<Budget>?> getBudgets({int? budgetId}) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => repository.readBudget(budgetId));
    return repository.readBudget(budgetId);
  }
}

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final client = ref.watch(supabaseInstanceProvider);
  return BudgetRepositoryImpl(client: client);
}
