import 'package:shindenshin/shindenshin.dart';
import 'task.dart';

class TaskApi extends BaseModelApi<Task> {
  @override
  String get url => 'tasks';

  TaskApi(BaseApiClient apiClient, BaseModelParser<Task> parser) : super(apiClient, parser);
}
