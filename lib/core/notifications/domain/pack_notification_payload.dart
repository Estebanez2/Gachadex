import 'dart:convert';

import '../../identifiers/entity_id.dart';

final class PackNotificationPayload {
  const PackNotificationPayload({
    required this.installedCollectionId,
    required this.packTypeId,
  });

  static const _type = 'pack_available';

  final InstalledCollectionId installedCollectionId;
  final PackTypeId packTypeId;

  String encode() {
    return jsonEncode({
      'type': _type,
      'installedCollectionId': installedCollectionId.value,
      'packTypeId': packTypeId.value,
    });
  }

  static PackNotificationPayload? tryDecode(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(value);
      if (decoded is! Map<String, Object?> || decoded['type'] != _type) {
        return null;
      }
      final installedCollectionId = decoded['installedCollectionId'];
      final packTypeId = decoded['packTypeId'];
      if (installedCollectionId is! String || packTypeId is! String) {
        return null;
      }
      return PackNotificationPayload(
        installedCollectionId: InstalledCollectionId(installedCollectionId),
        packTypeId: PackTypeId(packTypeId),
      );
    } on Object {
      return null;
    }
  }
}
