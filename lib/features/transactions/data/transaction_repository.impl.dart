import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/transactions/data/transaction_dto.dart';
import 'package:we_budget/features/transactions/data/transaction_repository.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final SupabaseClient client;
  final String table = 'Transactions';

  TransactionRepositoryImpl({required this.client});

  @override
  Future<String> createTransaction(Transaction trx) async {
    await client
        .from(table)
        .insert(TransactionDtoMapper.fromDomain(trx).toJson());
    return "Transaction created";
  }

  @override
  Future<List<Transaction>?> getTransaction(int? trxId) async {
    final List<Map<String, dynamic>> transactions = await client
        .from(table)
        .select()
        .maybeEq('trx_id', trxId);
    if (transactions.isEmpty) return null;
    final List<Transaction> data = transactions
        .map((e) => TransactionDto.fromJson(e).toDomain())
        .toList();
    return data;
  }

  @override
  Future<String?> deleteTransaction(int trxId) async {
    await client.from(table).delete().eq('trx_id', trxId);
    return "Budget deleted";
  }

  @override
  Future<String?> updateTransaction(Transaction trx) async {
    await client
        .from(table)
        .update(TransactionDtoMapper.fromDomain(trx).toJson())
        .eq('trx_id', trx.trxId!);
    return "Transaction updated";
  }
}
