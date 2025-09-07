import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_user_model.g.dart';

@JsonSerializable()
class BudgetUserModel {
  final int budgetId;
  final int userId;
  final int roleId;
  final DateTime createdAt;
  final DateTime? modifiedAt;

  BudgetUserModel({
    required this.budgetId,
    required this.userId,
    required this.roleId,
    required this.createdAt,
    this.modifiedAt,
  });

  factory BudgetUserModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BudgetUserModelToJson(this);
}
