import 'package:shindenshin/shindenshin.dart';

import '../config/environment.dart';

Dio getDioClient() {
  final Uri baseUri = Environment().config.apiUri;
  final BaseOptions options = BaseOptions(
    baseUrl: baseUri.toString(),
    headers: {
      'Accept-Language': 'ru-ru',
    },
  );
  return Dio(options);
}
