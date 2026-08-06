import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'project_media_storage.dart';

final projectMediaStorageProvider = Provider<ProjectMediaStorage>((ref) {
  return const LocalProjectMediaStorage();
});
