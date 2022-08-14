import 'package:shindenshin/shindenshin.dart';
import "repos/auth_repo.dart";
import "repos/tasks_repo.dart";

class Store extends BaseStore {
  Store(BaseApiClient apiClient) : super(apiClient, [
    AuthRepo.new,
    TasksRepo.new,

  ]);
}