// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetUserModel _$BudgetUserModelFromJson(Map<String, dynamic> json) =>
    BudgetUserModel(
      budgetId: (json['budgetId'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      roleId: (json['roleId'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      modifiedAt: json['modifiedAt'] == null
          ? null
          : DateTime.parse(json['modifiedAt'] as String),
    );

Map<String, dynamic> _$BudgetUserModelToJson(BudgetUserModel instance) =>
    <String, dynamic>{
      'budgetId': instance.budgetId,
      'userId': instance.userId,
      'roleId': instance.roleId,
      'createdAt': instance.createdAt.toIso8601String(),
      if (instance.modifiedAt?.toIso8601String() case final value?)
        'modifiedAt': value,
    };
