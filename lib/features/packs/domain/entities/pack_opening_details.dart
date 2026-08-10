import '../../../cards/domain/repositories/card_repository.dart';
import 'pack_opening.dart';
import 'pack_opening_card.dart';

final class PackOpeningCardDetails {
  const PackOpeningCardDetails({required this.result, required this.card});

  final PackOpeningCard result;
  final ImageCardDetails card;
}

final class PackOpeningDetails {
  const PackOpeningDetails({required this.opening, required this.cards});

  final PackOpening opening;
  final List<PackOpeningCardDetails> cards;
}
