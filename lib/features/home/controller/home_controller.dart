import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/transactions/controller/transaction_controller.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

part 'home_controller.g.dart';

@riverpod
AsyncValue<(List<Budget>?, List<Transaction>?)> homeRecord(Ref ref) {
  final budgetAsync = ref.watch(budgetListProvider);
  final txAsync = ref.watch(transactionListProvider);

  if (budgetAsync.isLoading || txAsync.isLoading) {
    return const AsyncLoading();
  }

  if (budgetAsync.hasError) {
    return AsyncError(budgetAsync.error!, budgetAsync.stackTrace!);
  }
  if (txAsync.hasError) {
    return AsyncError(txAsync.error!, txAsync.stackTrace!);
  }

  return AsyncData((budgetAsync.value, txAsync.value));
}
