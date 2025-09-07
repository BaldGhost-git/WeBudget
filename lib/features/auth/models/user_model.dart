import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@JsonSerializable()
@Freezed(copyWith: true)
class AppUser with _$AppUser {
  @JsonKey(name: "user_id")
  final int userId;
  final String name;
  final String email;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "modified_at")
  final DateTime? modifiedAt;

  AppUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.createdAt,
    this.modifiedAt,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
