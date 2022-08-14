import 'package:shindenshin/shindenshin.dart';
import 'user.dart';

class UserParser extends BaseModelParser<User> {
  @override
  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}
