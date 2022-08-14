import 'dart:io';

import 'package:flutter_starter_cli/config/config.dart';

class FlutterCreator {
  final Config config;

  Directory get currentDir => Directory.current;
  String get absPath => currentDir.absolute.path;

  FlutterCreator(this.config);

  void create(Config config) {
    final File pubspec = File('$absPath/pubspec.yaml');
    if (!pubspec.existsSync()) {
      print('flutter create --org ${config.org} --project-name ${config.projectName} .');
      Process.runSync(
        'flutter',
        ['create', '--org', config.org, '--project-name', config.projectName, '.'],
      );
      print('Flutter project created');
    }

    final Directory git = Directory('$absPath/.git');
    if (!git.existsSync()) {
      Process.runSync('git', ['init']);
      print('Git repository initialized');
      Process.runSync('git', ['remote', 'add', 'origin', config.github]);
    }
  }
}
