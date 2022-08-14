import 'package:shindenshin/shindenshin.dart';
import 'check.dart';

class CheckParser extends BaseModelParser<Check> {
  @override
  Check fromJson(Map<String, Object?> json) {
    return Check.fromJson(json);
  }
}
