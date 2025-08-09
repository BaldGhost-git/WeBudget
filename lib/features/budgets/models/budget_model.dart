import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.g.dart';
part 'budget_model.freezed.dart';

@JsonSerializable()
@Freezed(copyWith: true)
class Budget with _$Budget {
  @JsonKey(name: "budget_id", includeIfNull: false)
  final int? budgetId;
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
    this.budgetId,
    required this.name,
    this.description,
    this.resetDay = 30,
    required this.startDate,
    this.status = true,
    required this.totalAmount,
    required this.createdAt,
    this.modifiedAt,
  });

  factory Budget.fromJson(Map<String, dynamic> json) => _$BudgetFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetToJson(this);

  int get daysBeforeReset => DateTime.now()
      .add(Duration(days: resetDay!))
      .difference(DateTime.now())
      .inDays;

  DateTime get resetDate => DateTime.now().add(Duration(days: resetDay!));
}
