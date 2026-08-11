import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/features/cards/application/card_video_processor.dart';

void main() {
  group('card video trimming rules', () {
    test('does not require trim for clips up to fifteen seconds', () {
      expect(cardVideoNeedsTrim(const Duration(seconds: 15)), isFalse);
    });

    test('requires trim for clips longer than fifteen seconds', () {
      expect(cardVideoNeedsTrim(const Duration(seconds: 16)), isTrue);
    });

    test('clamps trim start within the usable source range', () {
      expect(
        clampCardVideoTrimStart(
          sourceDuration: const Duration(seconds: 45),
          requestedStart: const Duration(seconds: 40),
        ),
        const Duration(seconds: 30),
      );
      expect(
        clampCardVideoTrimStart(
          sourceDuration: const Duration(seconds: 45),
          requestedStart: const Duration(seconds: -2),
        ),
        Duration.zero,
      );
    });
  });
}
