import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shindenshin/shindenshin.dart';

part 'check.freezed.dart';
part 'check.g.dart';

@freezed
class Check extends BaseModel with _$Check {
  const factory Check({
    required dynamic id,
    required String name,
    required bool isChecked,

  }) = _Check;

  factory Check.fromJson(Map<String, Object?> json) => _$CheckFromJson(json);
}
