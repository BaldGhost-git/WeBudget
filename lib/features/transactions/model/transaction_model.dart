import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';

@Freezed(copyWith: true)
class Transaction with _$Transaction {
  final int? trxId;
  final double amount;
  final int budgetId;
  final String description;
  final DateTime trxDate;
  final int userId;
  final DateTime cycleStart;
  final DateTime createdAt;
  final DateTime? modifiedAt;

  Transaction({
    this.trxId,
    required this.amount,
    required this.budgetId,
    required this.description,
    required this.trxDate,
    required this.userId,
    required this.cycleStart,
    required this.createdAt,
    this.modifiedAt,
  });
}
