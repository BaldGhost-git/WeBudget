// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BudgetDto _$BudgetDtoFromJson(Map<String, dynamic> json) => BudgetDto(
  budgetId: (json['budget_id'] as num?)?.toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  resetDay: (json['reset_day'] as num?)?.toInt() ?? 30,
  startDate: DateTime.parse(json['start_date'] as String),
  status: json['status'] as bool? ?? true,
  isDailySpend: json['is_daily_spend'] as bool,
  totalAmount: (json['total_amount'] as num).toDouble(),
  createdAt: DateTime.parse(json['created_at'] as String),
  modifiedAt: json['modified_at'] == null
      ? null
      : DateTime.parse(json['modified_at'] as String),
);

Map<String, dynamic> _$BudgetDtoToJson(BudgetDto instance) => <String, dynamic>{
  if (instance.budgetId case final value?) 'budget_id': value,
  'name': instance.name,
  if (instance.description case final value?) 'description': value,
  if (instance.resetDay case final value?) 'reset_day': value,
  'start_date': instance.startDate.toIso8601String(),
  'status': instance.status,
  'is_daily_spend': instance.isDailySpend,
  'total_amount': instance.totalAmount,
  'created_at': instance.createdAt.toIso8601String(),
  if (instance.modifiedAt?.toIso8601String() case final value?)
    'modified_at': value,
};
