import 'dart:io';

import 'package:recase/recase.dart';

class Config {
  final String projectName;
  final String org;
  final String version;
  final String github;
  final String sentryDSN;
  final String apiHost;
  final List<ModelConfig> models;
  final List<String> repos;
  final List<String> pages;

  Config({
    required this.projectName,
    required this.org,
    required this.version,
    required this.github,
    required this.sentryDSN,
    required this.apiHost,
    required this.models,
    required this.repos,
    required this.pages,
  });

  factory Config.fromMap(Map raw) {
    final List repos = raw['repos'];
    final List pages = raw['pages'];

    return Config(
      projectName: raw['project_name'],
      org: raw['org'],
      version: raw['version'],
      github: raw['github'] ?? '',
      sentryDSN: raw['sentry_dsn'] ?? '',
      apiHost: raw['api_host'] ?? '',
      models: ModelConfig.fromMap(raw['models']),
      repos: repos.cast<String>(),
      pages: pages.cast<String>(),
    );
  }
}

const List<String> strNames = ['s', 'str', 'string'];
const List<String> intNames = ['i', 'int', 'integer'];
const List<String> boolNames = ['b', 'bool', 'boolean'];
const List<String> doubleNames = ['d', 'double'];
const List<String> dynamicNames = ['a', 'any', 'dynamic'];
const List<String> datetimeNames = ['dt', 'date', 'time', 'datetime'];

class ModelConfig {
  final String name;
  final List<ModelField> fields;

  ModelConfig({
    required this.name,
    required this.fields,
  });

  factory ModelConfig.fromMapEntry(MapEntry entry) {
    return ModelConfig(
      name: entry.key,
      fields: ModelField.fromMap(entry.value),
    );
  }

  static List<ModelConfig> fromMap(Map value) {
    return value.entries.map((e) => ModelConfig.fromMapEntry(e)).toList();
  }

  String getFieldsAsString() {
    String result = '';
    for (final field in fields) {
      result = '$result    ${field.asString()}';
    }
    return result;
  }

  String getRelatedImports() {
    String result = '';
    final Iterable<ModelField> relatedFields = fields.where((f) => f.isRelated());
    if (relatedFields.isEmpty) {
      return result;
    }

    for (final field in relatedFields) {
      final String snakeName = ReCase(field.rawType).snakeCase;
      result = '${result}import \'../$snakeName/$snakeName.dart\';\n';
    }
    return result;
  }
}

class ModelField {
  final String name;
  final String type;
  final String rawType;
  final String? defaultValue;

  ModelField({
    required this.name,
    required this.type,
    required this.rawType,
    this.defaultValue,
  });

  factory ModelField.fromMapEntry(MapEntry entry) {
    return ModelField(
      name: ReCase(entry.key).camelCase,
      type: _parseType(entry.value),
      rawType: _parseRawType(entry.value),
      defaultValue: _parseDefaultValue(entry.value),
    );
  }

  static List<ModelField> fromMap(Map value) {
    return value.entries.map((e) => ModelField.fromMapEntry(e)).toList();
  }

  String asString() {
    String result = '$type $name,\n';
    String prefix = 'required';
    if (defaultValue != null) {
      prefix = '@Default($defaultValue)';
    }
    return '$prefix $result';
  }

  bool isRelated() {
    return !strNames.contains(rawType) &&
        !intNames.contains(rawType) &&
        !doubleNames.contains(rawType) &&
        !boolNames.contains(rawType) &&
        !dynamicNames.contains(rawType) &&
        !datetimeNames.contains(rawType);
  }

  static String _parseRawType(String? value) {
    if (value == null || value.isEmpty) {
      return 'dynamic';
    }
    final List<String> split = value.split('=');
    return split[0].toString().toLowerCase().replaceAll(RegExp('\\W'), '');
  }

  static String _parseType(String? value) {
    final String type = _parseRawType(value);
    final bool isList = value?.contains('[]') ?? false;
    final bool isNullable = value?.contains('?') ?? false;

    late String resultType;
    if (strNames.contains(type)) {
      resultType = 'String';
    } else if (intNames.contains(type)) {
      resultType = 'int';
    } else if (boolNames.contains(type)) {
      resultType = 'bool';
    } else if (doubleNames.contains(type)) {
      resultType = 'double';
    } else if (dynamicNames.contains(type)) {
      resultType = 'dynamic';
    } else if (datetimeNames.contains(type)) {
      resultType = 'DateTime';
    } else {
      resultType = ReCase(type).pascalCase;
    }

    if (isNullable) {
      resultType = '$resultType?';
    }
    if (isList) {
      return 'List<$resultType>';
    }
    return resultType;
  }

  static String? _parseDefaultValue(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    final List<String> split = value.split('=');
    if (split.length < 2) {
      return null;
    }
    return split[1];
  }
}
