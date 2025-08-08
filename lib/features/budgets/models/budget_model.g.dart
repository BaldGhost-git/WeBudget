// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Budget _$BudgetFromJson(Map<String, dynamic> json) => Budget(
  budgetId: (json['budget_id'] as num?)?.toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  resetDay: (json['reset_day'] as num?)?.toInt() ?? 30,
  startDate: DateTime.parse(json['start_date'] as String),
  status: json['status'] as bool? ?? true,
  totalAmount: (json['total_amount'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  modifiedAt: json['modified_at'] == null
      ? null
      : DateTime.parse(json['modified_at'] as String),
);

Map<String, dynamic> _$BudgetToJson(Budget instance) => <String, dynamic>{
  if (instance.budgetId case final value?) 'budget_id': value,
  'name': instance.name,
  'description': instance.description,
  'reset_day': instance.resetDay,
  'start_date': instance.startDate.toIso8601String(),
  'status': instance.status,
  'total_amount': instance.totalAmount,
  'created_at': instance.createdAt.toIso8601String(),
  'modified_at': instance.modifiedAt?.toIso8601String(),
};
