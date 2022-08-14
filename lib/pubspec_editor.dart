import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_starter_cli/config/config.dart';
import 'package:flutter_starter_cli/exceptions.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class PubspecEditor {
  final Config config;

  Directory get currentDir => Directory.current;
  String get absPath => currentDir.absolute.path;
  File get pubspec => File('$absPath/pubspec.yaml');

  PubspecEditor(this.config);

  Future<void> run() async {
    if (!pubspec.existsSync()) {
      throw ProgressError('pubspec.yaml not found');
    }

    final Map raw = loadYaml(pubspec.readAsStringSync());

    final Map environment = raw['environment'];
    final String sdk = environment['sdk'];
    final Map dependencies = raw['dependencies'];
    final Map devDependencies = raw['dev_dependencies'];

    final List<String> packageNames = [
      'shindenshin',
      'dio',
      'bloc',
      'flutter_bloc',
      'hive_flutter',
      'sentry_flutter',
      'freezed_annotation',
      'json_annotation',
      'intl',
    ];
    print('Getting pub.dev packages');
    final Map pubPackages = await _getPubPackages(packageNames);
    // print('Getting github packages');
    // final Map gitHubPackages = _getGitHubPackages();

    final List<String> devPackageNames = [
      'build_runner',
      'freezed',
      'json_serializable',
      'dart_code_metrics',
      'hive_generator',
      'flutter_launcher_icons',
    ];
    print('Getting pub.dev dev packages');
    final Map devPubPackages = await _getPubPackages(devPackageNames);

    final Map toWrite = {
      'name': config.projectName,
      'description': '',
      'publish_to': 'none',
      'version': config.version,
      'environment': {'sdk': sdk},
      'dependencies': {
        ...dependencies,
        'flutter_localizations': {'sdk': 'flutter'},
        ...pubPackages,
        // ...gitHubPackages,
      },
      'dev_dependencies': {
        ...devDependencies,
        ...devPubPackages,
      },
      'flutter_icons': {
        'android': 'launcher_icon',
        'ios': true,
        'image_path': 'assets/app_icon.png',
      },
      'flutter': {
        'uses-material-design': true,
      },
    };

    final YAMLWriter writer = YAMLWriter();
    final String content = writer.write(toWrite);
    print('Writing to pubspec.yaml');
    pubspec.writeAsStringSync(content);
  }

  Future<Map> _getPubPackages(List<String> packageNames) async {
    final List<Response> responses = await Future.wait<Response>(
        packageNames.map((e) => Dio().get('https://pub.dev/api/packages/$e')));

    final Map result = {};
    for (final response in responses) {
      final Map data = response.data;
      final String name = data['name'];
      final String version = data['latest']['version'];
      result[name] = '^$version';
    }

    return result;
  }

  // Map _getGitHubPackages() {
  //   return {
  //     'shindenshin': {
  //       'git': {
  //         'url': 'git@github.com:justjew/shindenshin.git',
  //       },
  //     },
  //     'font_awesome_flutter': {
  //       'git': {
  //         'url': 'git@github.com:corex-studio/flutter_fa_pro.git',
  //       },
  //     },
  //   };
  // }
}
