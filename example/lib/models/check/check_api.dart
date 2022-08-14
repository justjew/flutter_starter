import 'package:shindenshin/shindenshin.dart';
import 'check.dart';

class CheckApi extends BaseModelApi<Check> {
  @override
  String get url => 'checks';

  CheckApi(BaseApiClient apiClient, BaseModelParser<Check> parser) : super(apiClient, parser);
}
