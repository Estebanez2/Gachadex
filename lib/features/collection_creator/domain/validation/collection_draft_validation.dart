import '../value_objects/draft_cover_style.dart';

enum DraftSectionCompletion {
  notStarted,
  incomplete,
  completeForThisPhase,
  withErrors,
}

final class CollectionDraftInfoErrors {
  const CollectionDraftInfoErrors({
    required this.nameTooLong,
    required this.authorTooLong,
    required this.descriptionTooLong,
  });

  const CollectionDraftInfoErrors.none()
    : nameTooLong = false,
      authorTooLong = false,
      descriptionTooLong = false;

  final bool nameTooLong;
  final bool authorTooLong;
  final bool descriptionTooLong;

  bool get canSave => !nameTooLong && !authorTooLong && !descriptionTooLong;

  bool get hasErrors => !canSave;
}

final class CollectionDraftCompleteness {
  const CollectionDraftCompleteness({
    required this.info,
    required this.rarities,
    required this.cards,
    required this.packs,
  });

  final DraftSectionCompletion info;
  final DraftSectionCompletion rarities;
  final DraftSectionCompletion cards;
  final DraftSectionCompletion packs;

  bool get infoComplete => info == DraftSectionCompletion.completeForThisPhase;

  bool get raritiesComplete =>
      rarities == DraftSectionCompletion.completeForThisPhase;

  bool get cardsComplete =>
      cards == DraftSectionCompletion.completeForThisPhase;

  bool get packsComplete =>
      packs == DraftSectionCompletion.completeForThisPhase;

  bool get completeForThisPhase =>
      infoComplete && raritiesComplete && cardsComplete && packsComplete;

  bool get hasFuturePendingWork => true;
}

abstract final class CollectionDraftValidation {
  static const maxNameLength = 60;
  static const maxAuthorLength = 60;
  static const maxDescriptionLength = 500;

  static CollectionDraftInfoErrors validateInfo({
    required String name,
    required String author,
    required String description,
  }) {
    return CollectionDraftInfoErrors(
      nameTooLong: name.length > maxNameLength,
      authorTooLong: author.length > maxAuthorLength,
      descriptionTooLong: description.length > maxDescriptionLength,
    );
  }

  static CollectionDraftCompleteness completeness({
    required String name,
    required DraftCoverStyle coverStyle,
    required int rarityCount,
    required int cardCount,
    required int packCount,
    required CollectionDraftInfoErrors infoErrors,
  }) {
    return CollectionDraftCompleteness(
      info: _infoCompletion(
        name: name,
        coverStyle: coverStyle,
        infoErrors: infoErrors,
      ),
      rarities: _rarityCompletion(rarityCount),
      cards: _cardCompletion(cardCount),
      packs: _packCompletion(packCount),
    );
  }

  static bool isNameComplete(String name) {
    return name.trim().isNotEmpty && name.length <= maxNameLength;
  }

  static DraftSectionCompletion _infoCompletion({
    required String name,
    required DraftCoverStyle coverStyle,
    required CollectionDraftInfoErrors infoErrors,
  }) {
    if (infoErrors.hasErrors) {
      return DraftSectionCompletion.withErrors;
    }

    if (name.trim().isEmpty && coverStyle == DraftCoverStyle.defaultStyle()) {
      return DraftSectionCompletion.notStarted;
    }

    if (!isNameComplete(name)) {
      return DraftSectionCompletion.incomplete;
    }

    return DraftSectionCompletion.completeForThisPhase;
  }

  static DraftSectionCompletion _rarityCompletion(int rarityCount) {
    if (rarityCount <= 0) {
      return DraftSectionCompletion.notStarted;
    }

    return DraftSectionCompletion.completeForThisPhase;
  }

  static DraftSectionCompletion _cardCompletion(int cardCount) {
    if (cardCount <= 0) {
      return DraftSectionCompletion.notStarted;
    }

    return DraftSectionCompletion.completeForThisPhase;
  }

  static DraftSectionCompletion _packCompletion(int packCount) {
    if (packCount <= 0) {
      return DraftSectionCompletion.notStarted;
    }

    return DraftSectionCompletion.completeForThisPhase;
  }
}
