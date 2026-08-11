import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../identifiers/entity_id.dart';

final class NotificationIdGenerator {
  const NotificationIdGenerator();

  int packAvailable({
    required InstalledCollectionId installedCollectionId,
    required PackTypeId packTypeId,
  }) {
    final digest = sha256.convert(
      utf8.encode('${installedCollectionId.value}:${packTypeId.value}'),
    );
    final bytes = digest.bytes;
    final value =
        (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];
    return value & 0x7fffffff;
  }
}
