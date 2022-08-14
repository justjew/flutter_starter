import 'package:flutter/material.dart';

import 'shared/hive_init.dart';
import 'shared/sentry_wrapper.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveInit();
  sentryWrap(() async => runApp(const App()));
}