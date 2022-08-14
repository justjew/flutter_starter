const String configText = '''import 'package:shindenshin/shindenshin.dart';

abstract class Config extends BaseConfig {
  Uri get wsUri;
  String get sentryDSN;
}
''';

const String environmentText = '''import 'package:shindenshin/shindenshin.dart';

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
''';

const String devConfig = '''import 'package:flutter/foundation.dart';

import 'config.dart';

class DevConfig extends Config {
  @override
  Uri get apiUri {
    String host = '127.0.0.1';

    if (defaultTargetPlatform == TargetPlatform.android) {
      host = '10.0.2.2';
    }

    return Uri(
      scheme: 'http',
      host: host,
      port: 8000,
      path: '/api/v1/',
    );
  }

  @override
  Uri get wsUri => Uri(
        scheme: 'ws',
        host: '127.0.0.1',
        port: 8888,
      );

  @override
  String get sentryDSN => '';
}
''';

const String prodConfig = '''import 'config.dart';

class ProdConfig extends Config {
  @override
  Uri get apiUri => Uri(
    scheme: 'https',
    host: '&apiHost&',
    path: '/api/v1/',
  );

  @override
  Uri get wsUri => Uri(
    scheme: 'wss',
    host: '&apiHost&',
  );

  @override
  String get sentryDSN => '&sentryDSN&';
}
''';
