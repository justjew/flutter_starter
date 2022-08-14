import 'config.dart';

class ProdConfig extends Config {
  @override
  Uri get apiUri => Uri(
    scheme: 'https',
    host: 'google.com',
    path: '/api/v1/',
  );

  @override
  Uri get wsUri => Uri(
    scheme: 'wss',
    host: 'google.com',
  );

  @override
  String get sentryDSN => '1234qwer';
}
