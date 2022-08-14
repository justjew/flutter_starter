const String sentryWrapperText = '''import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../config/environment.dart';

Future<void> sentryWrap(Future<void> Function() appRunner) {
  final String dsn = Environment().config.sentryDSN;
  return SentryFlutter.init(
    (options) {
      options
        ..dsn = dsn
        ..beforeSend = _beforeSent;
    },
    appRunner: appRunner,
  );
}

void reportError(
  dynamic throwable,
  StackTrace? stackTrace, {
  dynamic hint,
}) {
  if (kDebugMode) {
    debugPrintStack(stackTrace: stackTrace);

    if (throwable is DioError) {
      _printDioError(throwable);
    } else {
      debugPrint(throwable.toString());
    }
    return;
  }

  Sentry.captureException(
    throwable,
    stackTrace: stackTrace,
    hint: hint,
    withScope: (scope) {
      if (throwable is! DioError) {
        return;
      }

      scope
        ..setExtra('uri', throwable.requestOptions.uri)
        ..setExtra('method', throwable.requestOptions.method)
        ..setExtra('query params', throwable.requestOptions.queryParameters)
        ..setExtra('body', throwable.requestOptions.data)
        ..setExtra('status code', throwable.response?.statusCode)
        ..setExtra('response data', throwable.response?.data)
        ..setContexts('test context', 'test context data');
    },
  );
}

void reportMessage(String message, [SentryLevel level = SentryLevel.info]) {
  if (kDebugMode) {
    debugPrint('\$level: \$message');
  }

  Sentry.captureMessage(message, level: level);
}

// ignore: avoid-unused-parameters
SentryEvent? _beforeSent(SentryEvent event, {dynamic hint}) {
  if (_shouldSend(event)) {
    return event;
  }

  return null;
}

bool _shouldSend(SentryEvent event) {
  final dynamic throwable = event.throwable;
  if (throwable is DioError) {
    return throwable.response?.statusCode != HttpStatus.badRequest;
  }

  return true;
}

void _printDioError(DioError error) {
  debugPrint('Request error');
  debugPrint(error.requestOptions.uri.toString());
  if (error.requestOptions.method.toLowerCase() == 'get') {
    debugPrint('Query parameters');
    debugPrint(error.requestOptions.queryParameters.toString());
  } else {
    debugPrint('Request data');
    debugPrint(error.requestOptions.data.toString());
  }

  debugPrint('Response');
  debugPrint('Status code \${error.response?.statusCode ?? 'Unknown'}');
  debugPrint(error.response?.data?.toString() ?? 'No response data');
}
''';