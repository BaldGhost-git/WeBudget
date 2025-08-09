import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/budgets/data/budget_repository.dart';
import 'package:we_budget/features/budgets/data/budget_repository_impl.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

part 'budget_controller.g.dart';

@riverpod
class BudgetList extends _$BudgetList {
  @override
  Future<List<Budget>?> build() async {
    return refreshBudgets();
  }

  Future<List<Budget>?> refreshBudgets({int? budgetId}) async {
    state = AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => ref.read(budgetRepositoryProvider).readBudget(budgetId),
    );
    state = result;
    return result.value;
  }
}

@riverpod
class BudgetController extends _$BudgetController {
  @override
  Future<String?> build() async {}

  Future<void> createBudget(Budget newBudget) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(budgetRepositoryProvider).createBudget(newBudget.toJson()),
    );
    if (state is AsyncData) {
      ref.invalidate(budgetListProvider);
    }
  }

  Future<void> updateBudget(Budget newBudget) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(budgetRepositoryProvider).updateBudget(newBudget.toJson()),
    );
    if (state is AsyncData) {
      ref.invalidate(budgetListProvider);
    }
  }

  Future<void> deleteBudget(int budgetId) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(budgetRepositoryProvider).deleteBudget(budgetId),
    );
    if (state is AsyncData) {
      ref.invalidate(budgetListProvider);
    }
  }
}

@riverpod
Future<Budget> budgetById(Ref ref, int id) {
  final repo = ref.read(budgetRepositoryProvider);
  final budget = repo.readBudget(id).then((data) => data!.first);
  return budget;
}

final pageProvider = StateProvider<int>((ref) => 0);

@riverpod
BudgetRepository budgetRepository(Ref ref) {
  final client = ref.watch(supabaseInstanceProvider);
  return BudgetRepositoryImpl(client: client);
}
