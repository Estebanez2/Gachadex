import '../../../../core/domain/domain_validation.dart';
import '../../../../core/identifiers/entity_id.dart';

final class PackRarityProbability {
  PackRarityProbability({
    required this.probabilityGroupId,
    required this.rarityId,
    required int weight,
  }) : weight = DomainValidation.requirePositive(weight, 'weight');

  final ProbabilityGroupId probabilityGroupId;
  final RarityId rarityId;
  final int weight;
}
