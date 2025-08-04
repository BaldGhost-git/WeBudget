// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  userId: (json['user_id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  modifiedAt: json['modified_at'] == null
      ? null
      : DateTime.parse(json['modified_at'] as String),
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'user_id': instance.userId,
  'name': instance.name,
  'email': instance.email,
  'created_at': instance.createdAt.toIso8601String(),
  'modified_at': instance.modifiedAt?.toIso8601String(),
};
