import 'package:we_budget/features/transactions/model/transaction_model.dart';

abstract class TransactionRepository {
  Future<String?> createTransaction(Map<String, dynamic> json);
  Future<String?> deleteTransaction(int trxId);
  Future<String?> updateTransaction(Map<String, dynamic> json);
  Future<List<Transaction>?> getTransaction(int? trxId);
}
