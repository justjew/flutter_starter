import 'dart:io';

import 'package:flutter_starter_cli/config/config.dart';
import 'package:flutter_starter_cli/templates/analysis_options.dart';
import 'package:flutter_starter_cli/templates/date_manager.dart';
import 'package:flutter_starter_cli/templates/hive.dart';
import 'package:flutter_starter_cli/templates/main.dart';
import 'package:flutter_starter_cli/templates/models.dart';
import 'package:flutter_starter_cli/templates/pages.dart';
import 'package:flutter_starter_cli/templates/sentry.dart';
import 'package:flutter_starter_cli/templates/store.dart';
import 'package:recase/recase.dart';

import 'templates/configs.dart';

class StructureDeployer {
  final Config config;

  Directory get currentDir => Directory.current;
  String get absPath => currentDir.absolute.path;

  StructureDeployer(this.config);

  void run() {
    _createDirectories();
    print('Directories created');

    _createModels();
    print('Models created');

    _createRepos();
    print('Store created');

    _createPages();
    print('Pages created');

    _createConfigs();
    print('Configs created');

    _createHiveInitFile();
    print('Hive initializer created');

    _createSentryWrapperFile();
    print('Sentry wrapper file created');

    _createDateManagerFile();
    print('DateManager created');

    _createAnalysisOptions();
    print('Analysis options created');

    _createBootstrap();
    print('Entry point created');
  }

  void _createDirectories() {
    final Map<String, dynamic> structure = {
      'assets': null,
      'sksl_cache': null,
      'dev': null,
      'lib': {
        'bootstrap': null,
        'config': null,
        'models': null,
        'shared': null,
        'store': {
          'repos': null,
        },
        'pages': null,
        'widgets': null,
      },
    };

    for (final entry in structure.entries) {
      _createSingleDir('', entry);
    }
    File('$absPath/test/widget_test.dart').deleteSync();
  }

  void _createSingleDir(String currentPath, MapEntry<String, dynamic> entry) {
    String path = currentPath;
    path = '$path/${entry.key}';
    if (entry.value == null) {
      Directory('$absPath/$path').createSync(recursive: true);
    } else if (entry.value is Map) {
      for (final innerEntry in entry.value.entries) {
        _createSingleDir(path, innerEntry);
      }
    }
  }

  void _createModels() {
    String exportContent = '';
    for (final model in config.models) {
      final ReCase reCase = ReCase(model.name);
      final String snakeName = reCase.snakeCase;
      _createSingleModel(model, reCase);
      exportContent = '${exportContent}export \'$snakeName/${snakeName}_export.dart\';\n';
    }
    File('$absPath/lib/models/models.dart').writeAsStringSync(exportContent);
  }

  void _createSingleModel(ModelConfig model, ReCase reCase) {
    final String snakeName = reCase.snakeCase;
    String path = '$absPath/lib/models/$snakeName';
    Directory(path).createSync(recursive: true);

    path = '$path/$snakeName';
    final String modelContent = _fillTemplate(
      modelText,
      reCase: reCase,
      fields: {
        '&fields&': model.getFieldsAsString(),
        '&relatedImports&': model.getRelatedImports(),
      },
    );
    File('$path.dart').writeAsStringSync(modelContent);

    final String apiContent = _fillTemplate(apiText, reCase: reCase);
    File('${path}_api.dart').writeAsStringSync(apiContent);

    final String parserContent = _fillTemplate(parserText, reCase: reCase);
    File('${path}_parser.dart').writeAsStringSync(parserContent);

    final String exportContent = _fillTemplate(exportText, reCase: reCase);
    File('${path}_export.dart').writeAsStringSync(exportContent);
  }

  String _fillTemplate(
    String source, {
    ReCase? reCase,
    Map<String, String>? fields,
  }) {
    String result = source;
    if (reCase != null) {
      result = result
          .replaceAll('&lowerName&', reCase.camelCase)
          .replaceAll('&upperName&', reCase.pascalCase)
          .replaceAll('&snakeName&', reCase.snakeCase);
    }
    if (fields != null) {
      for (final entry in fields.entries) {
        result = result.replaceAll(entry.key, entry.value);
      }
    }
    return result;
  }

  void _createRepos() {
    for (final repo in config.repos) {
      _createSingleRepo(repo);
    }
    _createRepoExport();
    _createStore();
  }

  void _createSingleRepo(String repoName) {
    final ReCase reCase = ReCase(repoName);
    final String snakeName = repoName.snakeCase;

    final String content = _fillTemplate(repoText, reCase: reCase);
    final File file = File('$absPath/lib/store/repos/${snakeName}_repo.dart');
    file.writeAsStringSync(content);
  }

  void _createRepoExport() {
    String content = '';
    final List<String> sortedRepos = config.repos.toList()..sort();
    for (final repo in sortedRepos) {
      final String snakeName = ReCase(repo).snakeCase;
      content = '${content}export \'repos/${snakeName}_repo.dart\';\n';
    }
    File('$absPath/lib/store/repos.dart').writeAsStringSync(content);
  }

  void _createStore() {
    String importsContent = '';
    String repoConstructorsContent = '';

    for (final repo in config.repos) {
      final ReCase reCase = ReCase(repo);
      final String snakeName = reCase.snakeCase;
      final String upperName = reCase.pascalCase;

      importsContent = '${importsContent}import \'repos/${snakeName}_repo.dart\';\n';
      repoConstructorsContent = '$repoConstructorsContent    ${upperName}Repo.new,\n';
    }

    final String content = _fillTemplate(storeText, fields: {
      '&repoImports&': importsContent,
      '&repoConstructors&': repoConstructorsContent,
    });
    File('$absPath/lib/store/store.dart').writeAsStringSync(content);
  }

  void _createPages() {
    String exportContent = '';
    for (final page in config.pages) {
      final ReCase reCase = ReCase(page);
      _createSinglePage(reCase);
      final String snakeName = reCase.snakeCase;
      exportContent = '${exportContent}export \'$snakeName/${snakeName}_page.dart\';\n';
    }
    File('$absPath/lib/pages/pages.dart').writeAsStringSync(exportContent);
  }

  void _createSinglePage(ReCase pageReCase) {
    final String snakeName = pageReCase.snakeCase;

    final String rootPath = '$absPath/lib/pages/$snakeName';
    Directory('$rootPath/cubit').createSync(recursive: true);
    Directory('$rootPath/views').createSync(recursive: true);

    final String pageContent = _fillTemplate(pageText, reCase: pageReCase);
    final String viewContent = _fillTemplate(viewText, reCase: pageReCase);

    File('$rootPath/${snakeName}_page.dart').writeAsStringSync(pageContent);
    File('$rootPath/views/${snakeName}_view.dart').writeAsStringSync(viewContent);
  }

  void _createConfigs() {
    final String rootPath = '$absPath/lib/config';

    final String configContent = configText;
    final String environmentContent = environmentText;
    final String devContent = devConfig;
    final String prodContent = _fillTemplate(prodConfig, fields: {
      '&apiHost&': config.apiHost,
      '&sentryDSN&': config.sentryDSN,
    });

    File('$rootPath/config.dart').writeAsStringSync(configContent);
    File('$rootPath/environment.dart').writeAsStringSync(environmentContent);
    File('$rootPath/dev_config.dart').writeAsStringSync(devContent);
    File('$rootPath/prod_config.dart').writeAsStringSync(prodContent);
  }

  void _createHiveInitFile() {
    File('$absPath/lib/shared/hive_init.dart').writeAsStringSync(hiveInitText);
  }

  void _createSentryWrapperFile() {
    File('$absPath/lib/shared/sentry_wrapper.dart').writeAsStringSync(sentryWrapperText);
  }

  void _createDateManagerFile() {
    File('$absPath/lib/shared/date_manager.dart').writeAsStringSync(dateManagerText);
  }

  void _createAnalysisOptions() {
    File('$absPath/analysis_options.yaml').writeAsStringSync(analysisOptionsText);
  }

  void _createBootstrap() {
    File('$absPath/lib/main.dart').writeAsStringSync(mainText);
    File('$absPath/lib/bootstrap/dio_client.dart').writeAsStringSync(dioClientText);
    File('$absPath/lib/bootstrap/bootstrap.dart').writeAsStringSync(bootstrapText);
    File('$absPath/lib/bootstrap/navigator_builder.dart').writeAsStringSync(navigatorBuilderText);
    File('$absPath/lib/bootstrap/navigator_cubit.dart').writeAsStringSync(navigatorCubitText);
    File('$absPath/lib/bootstrap/store_provider.dart').writeAsStringSync(storeProviderText);
  }
}
