import 'dart:io';

import 'config/config.dart';
import 'flutter_creator.dart';
import 'pubspec_editor.dart';
import 'structure_deployer.dart';

class Runner {
  final Config config;

  Runner(this.config);

  Future<void> init() async {
    FlutterCreator(config).create(config);
    await PubspecEditor(config).run();
    StructureDeployer(config).run();

    print('flutter pub get');
    Process.runSync('flutter', ['pub', 'get']);

    print('flutter pub run build_runner build');
    Process.runSync('flutter', ['pub', 'run', 'build_runner', 'build']);
  }
}
