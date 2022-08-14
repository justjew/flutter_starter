import 'package:shindenshin/shindenshin.dart';
import 'task.dart';

class TaskParser extends BaseModelParser<Task> {
  @override
  Task fromJson(Map<String, Object?> json) {
    return Task.fromJson(json);
  }
}
