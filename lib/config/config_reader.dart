import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import '../templates/starter_config.dart';
import 'config.dart';


class ConfigReader {
  final Directory currentDirectory;

  String get absPath => currentDirectory.absolute.path;

  static const String configFileName = 'starter_config.json';

  ConfigReader() : currentDirectory = Directory.current;
  
  Config read() {
    final File configFile = File('$absPath/$configFileName');
    final bool configExists = configFile.existsSync();

    if (!configExists) {
      _createExample();
      throw ConfigNotExist();
    }

    // final Map rawConfig = loadYaml(configFile.readAsStringSync());
    final Map rawConfig = jsonDecode(configFile.readAsStringSync());
    return Config.fromMap(rawConfig);
  }

  void _createExample() {
    final File file = File('$absPath/$configFileName');
    file.writeAsStringSync(starterConfig);
  }
}

class ConfigNotExist implements Exception {}