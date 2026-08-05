import '../../../../core/domain/domain_enums.dart';
import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class CollectionProject {
  CollectionProject({
    required this.id,
    required this.collectionId,
    required String name,
    required String? author,
    required String? description,
    required this.coverAssetId,
    required this.status,
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
    required int currentContentVersion,
    required this.currentContentVersionId,
    required this.mainPackTypeId,
    int startingPackCount = 3,
  }) : name = DomainValidation.requireTrimmedNotEmpty(name, 'name'),
       author = DomainValidation.optionalTrimmed(author),
       description = DomainValidation.optionalTrimmed(description),
       createdAtUtc = DomainValidation.requireUtc(createdAtUtc, 'createdAtUtc'),
       updatedAtUtc = DomainValidation.requireUtc(updatedAtUtc, 'updatedAtUtc'),
       currentContentVersion = DomainValidation.requirePositive(
         currentContentVersion,
         'currentContentVersion',
       ),
       startingPackCount = DomainValidation.requireNonNegative(
         startingPackCount,
         'startingPackCount',
       );

  final CollectionProjectId id;
  final CollectionId collectionId;
  final String name;
  final String? author;
  final String? description;
  final MediaAssetId? coverAssetId;
  final CollectionProjectStatus status;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
  final int currentContentVersion;
  final ContentVersionId? currentContentVersionId;
  final PackTypeId? mainPackTypeId;
  final int startingPackCount;

  bool get isDraft => status == CollectionProjectStatus.draft;

  CollectionProject copyWith({
    String? name,
    String? author,
    String? description,
    MediaAssetId? coverAssetId,
    CollectionProjectStatus? status,
    DateTime? updatedAtUtc,
    int? currentContentVersion,
    ContentVersionId? currentContentVersionId,
    PackTypeId? mainPackTypeId,
    int? startingPackCount,
  }) {
    return CollectionProject(
      id: id,
      collectionId: collectionId,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      coverAssetId: coverAssetId ?? this.coverAssetId,
      status: status ?? this.status,
      createdAtUtc: createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      currentContentVersion:
          currentContentVersion ?? this.currentContentVersion,
      currentContentVersionId:
          currentContentVersionId ?? this.currentContentVersionId,
      mainPackTypeId: mainPackTypeId ?? this.mainPackTypeId,
      startingPackCount: startingPackCount ?? this.startingPackCount,
    );
  }
}
