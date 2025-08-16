import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/auth/controllers/user_controller.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/transactions/data/transaction_repository.dart';
import 'package:we_budget/features/transactions/data/transaction_repository.impl.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

part 'transaction_controller.g.dart';

@riverpod
class TransactionList extends _$TransactionList {
  @override
  Future<List<Transaction>?> build() async {
    return refreshBudgets();
  }

  Future<List<Transaction>?> refreshBudgets({int? budgetId}) async {
    state = AsyncValue.loading();
    final result = await AsyncValue.guard(
      () => ref.read(transactionRepositoryProvider).getTransaction(budgetId),
    );
    state = result;
    return result.value;
  }
}

@riverpod
class TransactionController extends _$TransactionController {
  @override
  Future<String?> build() async {}

  Future<void> createTransaction(Map<String, dynamic> data) async {
    state = AsyncValue.loading();
    final user = await ref.read(userControllerProvider.future);
    final budgetList = await ref.read(budgetListProvider.future);
    final budgetId = data['budget_id'] as int;
    final budget = budgetList!.singleWhere(
      (element) => element.budgetId == budgetId,
    );
    final newTransaction = Transaction(
      amount: int.parse((data['amount'] as String).replaceAll('.', '')),
      budgetId: budgetId,
      description: data['description'] as String,
      trxDate: data['trx_date'] as DateTime,
      userId: user!.userId,
      cycleStart: budget.startDate,
      createdAt: DateTime.now(),
    );
    state = await AsyncValue.guard(
      () => ref
          .read(transactionRepositoryProvider)
          .createTransaction(newTransaction.toJson()),
    );
    if (state is AsyncData) {
      ref.invalidate(transactionListProvider);
    }
  }

  Future<void> updateBudget(Transaction newTransaction) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(transactionRepositoryProvider)
          .updateTransaction(newTransaction.toJson()),
    );
    if (state is AsyncData) {
      ref.invalidate(transactionListProvider);
    }
  }

  Future<void> deleteBudget(int trxId) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(transactionRepositoryProvider).deleteTransaction(trxId),
    );
    if (state is AsyncData) {
      ref.invalidate(transactionListProvider);
    }
  }
}

@riverpod
Future<Transaction> budgetById(Ref ref, int id) {
  final repo = ref.read(transactionRepositoryProvider);
  final budget = repo.getTransaction(id).then((data) => data!.first);
  return budget;
}

final pageProvider = StateProvider<int>((ref) => 0);

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  final client = ref.watch(supabaseInstanceProvider);
  return TransactionRepositoryImpl(client: client);
}
