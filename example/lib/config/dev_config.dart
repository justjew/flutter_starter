import 'package:flutter/foundation.dart';

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
