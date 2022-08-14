import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shindenshin/shindenshin.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User extends BaseModel with _$User {
  const factory User({
    required dynamic id,
    required String name,
    required int age,
    @Default(false) bool isActive,

  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}
