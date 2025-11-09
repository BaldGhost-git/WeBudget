import 'package:we_budget/features/transactions/model/transaction_model.dart';

abstract class TransactionRepository {
  Future<String?> createTransaction(Transaction trx);
  Future<String?> deleteTransaction(int trxId);
  Future<String?> updateTransaction(Transaction trx);
  Future<List<Transaction>?> getTransaction(int? trxId);
}
