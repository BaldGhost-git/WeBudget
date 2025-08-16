import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/transactions/controller/transaction_controller.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

part 'home_controller.g.dart';

@riverpod
Future<(List<Budget>?, List<Transaction>?)> homeRecord(Ref ref) async {
  final budgetAsync = ref.watch(budgetListProvider);
  final txAsync = ref.watch(transactionListProvider);

  if (budgetAsync.isLoading || txAsync.isLoading) {
    throw const AsyncLoading();
  }
  if (budgetAsync.hasError) throw budgetAsync.error!;
  if (txAsync.hasError) throw txAsync.error!;

  return (budgetAsync.value, txAsync.value);
}
