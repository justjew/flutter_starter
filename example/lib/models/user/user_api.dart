import 'package:shindenshin/shindenshin.dart';
import 'user.dart';

class UserApi extends BaseModelApi<User> {
  @override
  String get url => 'users';

  UserApi(BaseApiClient apiClient, BaseModelParser<User> parser) : super(apiClient, parser);
}
