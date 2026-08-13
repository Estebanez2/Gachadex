import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gachadex/core/domain/domain_enums.dart';
import 'package:gachadex/features/cards/presentation/widgets/gachadex_card.dart';

void main() {
  testWidgets('GachadexCard uses the front overlay and bounds media', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              key: ValueKey('card_box'),
              width: 300,
              child: GachadexCard(
                name: 'Pepe',
                health: 100,
                description: 'Descripcion corta',
                rarityName: 'Rara',
                media: ColoredBox(
                  key: ValueKey('test_media'),
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey('gachadex_card_front_overlay_asset')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('test_media')), findsOneWidget);

    final cardRect = tester.getRect(find.byKey(const ValueKey('card_box')));
    final mediaRect = tester.getRect(
      find.byKey(const ValueKey('gachadex_card_media_rect')),
    );

    expect(mediaRect.left, greaterThan(cardRect.left));
    expect(mediaRect.top, greaterThan(cardRect.top));
    expect(mediaRect.right, lessThan(cardRect.right));
    expect(mediaRect.bottom, lessThan(cardRect.bottom));
  });

  testWidgets('GachadexCardBack uses the back asset', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: SizedBox(width: 240, child: GachadexCardBack())),
        ),
      ),
    );

    expect(
      find.byKey(const ValueKey('gachadex_card_back_asset')),
      findsOneWidget,
    );
  });

  testWidgets('video cards can be represented by a thumbnail only', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 180,
              child: GachadexCard(
                name: 'Video',
                health: 80,
                description: 'Clip',
                rarityName: 'Especial',
                mediaType: MediaType.video,
                media: ColoredBox(
                  key: ValueKey('video_thumbnail'),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('video_thumbnail')), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_rounded), findsOneWidget);
  });
}
