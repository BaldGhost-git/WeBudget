import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/transactions/data/transaction_repository.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final SupabaseClient client;
  final String table = 'Transactions';

  TransactionRepositoryImpl({required this.client});

  @override
  Future<String> createTransaction(Map<String, dynamic> json) async {
    await client.from(table).insert(json);
    return "Transaction created";
  }

  @override
  Future<List<Transaction>?> getTransaction(int? trxId) async {
    final List<Map<String, dynamic>> budgets = await client
        .from(table)
        .select()
        .maybeEq('trx_id', trxId);
    if (budgets.isEmpty) return null;
    final List<Transaction> data = budgets
        .map((e) => Transaction.fromJson(e))
        .toList();
    return data;
  }

  @override
  Future<String?> deleteTransaction(int trxId) async {
    await client.from(table).delete().eq('trx_id', trxId);
    return "Budget deleted";
  }

  @override
  Future<String?> updateTransaction(Map<String, dynamic> json) async {
    await client.from(table).update(json).eq('trx_id', json["trx_id"]);
    return "Transaction updated";
  }
}
