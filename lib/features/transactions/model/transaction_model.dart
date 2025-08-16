import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.g.dart';
part 'transaction_model.freezed.dart';

@JsonSerializable()
@Freezed(copyWith: true)
class Transaction with _$Transaction {
  @JsonKey(name: "trx_id")
  final int? trxId;
  final int amount;
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

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

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

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
