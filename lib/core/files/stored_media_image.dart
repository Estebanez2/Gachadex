import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../value_objects/relative_media_path.dart';
import 'file_providers.dart';

class StoredMediaImage extends ConsumerWidget {
  const StoredMediaImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.errorIcon = Icons.broken_image_outlined,
  });

  final RelativeMediaPath path;
  final BoxFit fit;
  final IconData errorIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = ref.watch(projectMediaStorageProvider);

    return FutureBuilder<File>(
      future: storage.resolve(path),
      builder: (context, snapshot) {
        final file = snapshot.data;
        if (file == null) {
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        }

        return Image.file(
          file,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Center(child: Icon(errorIcon));
          },
        );
      },
    );
  }
}
