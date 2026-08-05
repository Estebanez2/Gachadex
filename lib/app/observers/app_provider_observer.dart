import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/logging/app_logger.dart';

final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    if (!kDebugMode) {
      return;
    }

    AppLogger.debug('Provider added: ${_safeProviderName(context)}');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (!kDebugMode) {
      return;
    }

    AppLogger.debug('Provider updated: ${_safeProviderName(context)}');
  }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    if (!kDebugMode) {
      return;
    }

    AppLogger.error(
      'Provider failed: ${_safeProviderName(context)}',
      error: error,
      stackTrace: stackTrace,
    );
  }

  String _safeProviderName(ProviderObserverContext context) {
    final name = context.provider.name;
    if (name == null || name.isEmpty) {
      return context.provider.runtimeType.toString();
    }

    return name;
  }
}
