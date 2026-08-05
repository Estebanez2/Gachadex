import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

abstract final class AppLogger {
  static const _name = 'Gachadex';

  static void debug(String message) {
    if (kDebugMode) {
      _log(message, level: 500);
    }
  }

  static void info(String message) {
    if (!kReleaseMode) {
      _log(message, level: 800);
    }
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    if (!kReleaseMode) {
      _log(message, level: 900, error: error, stackTrace: stackTrace);
    }
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _log(
      message,
      level: 1000,
      error: kDebugMode ? error : null,
      stackTrace: kDebugMode ? stackTrace : null,
    );
  }

  static void _log(
    String message, {
    required int level,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: _name,
      level: level,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
