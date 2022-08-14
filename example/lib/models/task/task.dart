import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shindenshin/shindenshin.dart';
import '../user/user.dart';
import '../user/user.dart';
import '../user/user.dart';
import '../check/check.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task extends BaseModel with _$Task {
  const factory Task({
    required dynamic id,
    required User? owner,
    required User ownerBy,
    required List<User> owners,
    required List<Check> checks,

  }) = _Task;

  factory Task.fromJson(Map<String, Object?> json) => _$TaskFromJson(json);
}
