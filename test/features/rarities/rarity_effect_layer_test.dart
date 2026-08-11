import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/features/rarities/presentation/widgets/rarity_effect_layer.dart';

void main() {
  group('RarityEffectFrame', () {
    test('maps known effect ids and falls back to none', () {
      expect(
        rarityEffectKindForId('rarity_effect_soft_glow'),
        RarityEffectKind.softGlow,
      );
      expect(
        rarityEffectKindForId('rarity_effect_spark'),
        RarityEffectKind.sparkle,
      );
      expect(
        rarityEffectKindForId('rarity_effect_gradient'),
        RarityEffectKind.gradient,
      );
      expect(
        rarityEffectKindForId('rarity_effect_holo'),
        RarityEffectKind.holographic,
      );
      expect(
        rarityEffectKindForId('rarity_effect_pulse'),
        RarityEffectKind.pulse,
      );
      expect(rarityEffectKindForId('missing'), RarityEffectKind.none);
      expect(rarityEffectKindForId(null), RarityEffectKind.none);
    });

    testWidgets('respects disableAnimations for animated effects', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SizedBox(
              width: 120,
              height: 160,
              child: RarityEffectFrame(
                effectId: 'rarity_effect_holo',
                baseColor: Color(0xFF2F6FA8),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: ColoredBox(color: Colors.black),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(RarityEffectFrame), findsOneWidget);
      expect(tester.binding.transientCallbackCount, 0);
    });
  });
}
