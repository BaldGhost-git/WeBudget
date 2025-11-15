// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    TransactionDto(
      trxId: (json['trx_id'] as num?)?.toInt(),
      amount: (json['amount'] as num).toDouble(),
      budgetId: (json['budget_id'] as num).toInt(),
      description: json['description'] as String,
      trxDate: DateTime.parse(json['trx_date'] as String),
      userId: (json['user_id'] as num).toInt(),
      cycleStart: DateTime.parse(json['cycle_start'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      modifiedAt: json['modified_at'] == null
          ? null
          : DateTime.parse(json['modified_at'] as String),
    );

Map<String, dynamic> _$TransactionDtoToJson(TransactionDto instance) =>
    <String, dynamic>{
      if (instance.trxId case final value?) 'trx_id': value,
      'amount': instance.amount,
      'budget_id': instance.budgetId,
      'description': instance.description,
      'trx_date': instance.trxDate.toIso8601String(),
      'user_id': instance.userId,
      'cycle_start': instance.cycleStart.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      if (instance.modifiedAt?.toIso8601String() case final value?)
        'modified_at': value,
    };
