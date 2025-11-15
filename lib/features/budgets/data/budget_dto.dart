import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

part 'budget_dto.g.dart';

@JsonSerializable()
class BudgetDto {
  @JsonKey(name: "budget_id", includeIfNull: false)
  final int? budgetId;
  final String name;
  final String? description;
  @JsonKey(name: "reset_day")
  final int? resetDay;
  @JsonKey(name: "start_date")
  final DateTime startDate;
  final bool status;
  @JsonKey(name: "is_daily_spend")
  final bool isDailySpend;
  @JsonKey(name: "total_amount")
  final double totalAmount;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "modified_at")
  final DateTime? modifiedAt;

  BudgetDto({
    this.budgetId,
    required this.name,
    this.description,
    this.resetDay = 30,
    required this.startDate,
    this.status = true,
    required this.isDailySpend,
    required this.totalAmount,
    required this.createdAt,
    this.modifiedAt,
  });

  factory BudgetDto.fromJson(Map<String, dynamic> json) =>
      _$BudgetDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetDtoToJson(this);
}

extension BudgetDtoMapper on BudgetDto {
  Budget toDomain() => Budget(
    name: name,
    description: description,
    budgetId: budgetId,
    modifiedAt: modifiedAt,
    resetDay: resetDay,
    status: status,
    startDate: startDate,
    isDailySpend: isDailySpend,
    totalAmount: totalAmount,
    createdAt: createdAt,
  );
  static BudgetDto fromDomain(Budget budget) => BudgetDto(
    name: budget.name,
    startDate: budget.startDate,
    isDailySpend: budget.isDailySpend,
    totalAmount: budget.totalAmount,
    createdAt: budget.createdAt,
    budgetId: budget.budgetId,
    description: budget.description,
    modifiedAt: budget.modifiedAt,
    resetDay: budget.resetDay,
    status: budget.status,
  );
}
