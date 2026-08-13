import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final incomingGachadexFileServiceProvider =
    Provider<IncomingGachadexFileService>((ref) {
      final service = IncomingGachadexFileService();
      ref.onDispose(service.dispose);
      return service;
    });

final class IncomingGachadexFileService {
  IncomingGachadexFileService() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static const _channel = MethodChannel('gachadex/import_files');

  final _paths = StreamController<String>.broadcast();

  Stream<String> get paths => _paths.stream;

  Future<String?> takeInitialPath() async {
    try {
      final path = await _channel.invokeMethod<String>(
        'getInitialGachadexFile',
      );
      if (path == null || path.isEmpty) {
        return null;
      }
      return path;
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    }
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method != 'openGachadexFile') {
      return;
    }
    final arguments = call.arguments;
    if (arguments is String && arguments.isNotEmpty) {
      _paths.add(arguments);
    }
  }

  void dispose() {
    _channel.setMethodCallHandler(null);
    unawaited(_paths.close());
  }
}
