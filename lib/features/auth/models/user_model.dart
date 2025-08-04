import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@JsonSerializable()
@Freezed(copyWith: true)
class AppUser with _$AppUser {
  final String email;
  final DateTime? modifiedAt;

  AppUser({required this.email, this.modifiedAt});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
