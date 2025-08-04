import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.g.dart';
part 'budget_model.freezed.dart';

@JsonSerializable()
@Freezed(copyWith: true)
class Budget with _$Budget {
  @JsonKey(name: "budget_id")
  final int budgetId;
  final String name;
  final String? description;
  @JsonKey(name: "reset_day")
  final int? resetDay;
  @JsonKey(name: "start_date")
  final DateTime startDate;
  final bool status;
  @JsonKey(name: "total_amount")
  final int totalAmount;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "modified_at")
  final DateTime? modifiedAt;

  Budget({
    required this.budgetId,
    required this.name,
    this.description,
    this.resetDay,
    required this.startDate,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    this.modifiedAt,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);
}
