const String repoText = '''import 'package:shindenshin/shindenshin.dart';

class &upperName&Repo extends BaseRepo {
  &upperName&Repo(super.store);
}''';

const String storeText = '''import 'package:shindenshin/shindenshin.dart';
&repoImports&
class Store extends BaseStore {
  Store(BaseApiClient apiClient) : super(apiClient, [
&repoConstructors&
  ]);
}''';
