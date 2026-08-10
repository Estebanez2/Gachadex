enum FinalizationSection { information, rarities, cards, packs }

final class CollectionFinalizationIssue {
  const CollectionFinalizationIssue({
    required this.section,
    required this.message,
  });

  final FinalizationSection section;
  final String message;
}

final class CollectionFinalizationReport {
  const CollectionFinalizationReport(this.issues);

  final List<CollectionFinalizationIssue> issues;

  bool get canFinalize => issues.isEmpty;

  List<CollectionFinalizationIssue> issuesFor(FinalizationSection section) {
    return issues.where((issue) => issue.section == section).toList();
  }
}
