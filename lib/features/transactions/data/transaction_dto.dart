import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

part 'transaction_dto.g.dart';

@JsonSerializable()
class TransactionDto {
  @JsonKey(name: "trx_id")
  final int? trxId;
  final double amount;
  @JsonKey(name: "budget_id")
  final int budgetId;
  final String description;
  @JsonKey(name: "trx_date")
  final DateTime trxDate;
  @JsonKey(name: "user_id")
  final int userId;
  @JsonKey(name: "cycle_start")
  final DateTime cycleStart;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "modified_at")
  final DateTime? modifiedAt;

  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);

  TransactionDto({
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

  Map<String, dynamic> toJson() => _$TransactionDtoToJson(this);
}

extension TransactionDtoMapper on TransactionDto {
  Transaction toDomain() => Transaction(
    amount: amount,
    budgetId: budgetId,
    description: description,
    trxDate: trxDate,
    userId: userId,
    cycleStart: cycleStart,
    createdAt: createdAt,
    modifiedAt: modifiedAt,
    trxId: trxId,
  );
  static TransactionDto fromDomain(Transaction trx) => TransactionDto(
    amount: trx.amount,
    budgetId: trx.budgetId,
    description: trx.description,
    trxDate: trx.trxDate,
    userId: trx.userId,
    cycleStart: trx.cycleStart,
    createdAt: trx.createdAt,
    modifiedAt: trx.modifiedAt,
    trxId: trx.trxId,
  );
}
