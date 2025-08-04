// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
  email: json['email'] as String,
  modifiedAt: json['modifiedAt'] == null
      ? null
      : DateTime.parse(json['modifiedAt'] as String),
);

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
  'email': instance.email,
  'modifiedAt': instance.modifiedAt?.toIso8601String(),
};
