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

    test('represents a selected clip as start plus duration', () {
      final trim = normalizeCardVideoTrim(
        sourceDuration: const Duration(seconds: 40),
        requestedTrim: const CardVideoTrim(
          start: Duration(seconds: 12),
          duration: Duration(seconds: 15),
        ),
      );

      expect(trim.start, const Duration(seconds: 12));
      expect(trim.duration, const Duration(seconds: 15));
      expect(trim.end, const Duration(seconds: 27));
    });

    test('keeps the last fifteen seconds inside source bounds', () {
      final trim = normalizeCardVideoTrim(
        sourceDuration: const Duration(seconds: 20),
        requestedTrim: const CardVideoTrim(
          start: Duration(seconds: 10),
          duration: Duration(seconds: 15),
        ),
      );

      expect(trim.start, const Duration(seconds: 5));
      expect(trim.duration, const Duration(seconds: 15));
      expect(trim.end, const Duration(seconds: 20));
    });

    test('maps selected clip to platform compression arguments', () {
      const trim = CardVideoTrim(
        start: Duration(seconds: 12),
        duration: Duration(seconds: 15),
      );

      final standard = cardVideoCompressionArguments(
        sourceDuration: const Duration(seconds: 40),
        trim: trim,
        platform: CardVideoCompressionPlatform.standard,
      );
      final android = cardVideoCompressionArguments(
        sourceDuration: const Duration(seconds: 40),
        trim: trim,
        platform: CardVideoCompressionPlatform.android,
      );

      expect(standard.startTimeSeconds, 12);
      expect(standard.durationSeconds, 15);
      expect(android.startTimeSeconds, 12);
      expect(android.durationSeconds, 13);
    });

    test('android compression arguments support the final fifteen seconds', () {
      final arguments = cardVideoCompressionArguments(
        sourceDuration: const Duration(seconds: 20),
        trim: const CardVideoTrim(
          start: Duration(seconds: 5),
          duration: Duration(seconds: 15),
        ),
        platform: CardVideoCompressionPlatform.android,
      );

      expect(arguments.startTimeSeconds, 5);
      expect(arguments.durationSeconds, 0);
    });
  });
}
