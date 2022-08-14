const String hiveInitText = '''import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> hiveInit({bool registerAdapters = true}) async {
  try {
    await Hive.initFlutter();
    if (registerAdapters) {
      // Hive
      //   ..registerAdapter(ExampleAdapter());
    }

    await Future.wait([
      Hive.openBox('system'),
      Hive.openBox('auth'),
    ]);
  } catch (error) {
    await Hive.close();
    final appDir = await getApplicationDocumentsDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
    hiveInit(registerAdapters: false);
  }
}
''';