import 'package:shindenshin/shindenshin.dart';

abstract class Config extends BaseConfig {
  Uri get wsUri;
  String get sentryDSN;
}
