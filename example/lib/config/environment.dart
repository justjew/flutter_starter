import 'package:shindenshin/shindenshin.dart';

import 'config.dart';
import 'dev_config.dart';
import 'prod_config.dart';

class Environment extends BaseEnvironment<Config> {
  @override
  Config getConfig(String environment) {
    switch (environment.toUpperCase()) {
      case BaseEnvironment.prod:
        return ProdConfig();
      default:
        return DevConfig();
    }
  }
}
