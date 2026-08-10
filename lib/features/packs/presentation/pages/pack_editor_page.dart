import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/database/database_providers.dart';
import '../../../../core/domain/domain_enums.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../cards/application/card_providers.dart';
import '../../../cards/domain/repositories/card_repository.dart';
import '../../../collection_creator/domain/entities/collection_project.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../../application/pack_providers.dart';
import '../../application/pack_use_cases.dart';
import '../../domain/catalogs/pack_visual_catalog.dart';
import '../../domain/entities/pack_card_pool_entry.dart';
import '../../domain/entities/pack_configuration.dart';
import '../../domain/entities/pack_rarity_probability.dart';
import '../../domain/entities/pack_slot_rule.dart';
import '../../domain/services/pack_generator.dart';
import '../../domain/validation/pack_validation.dart';
import '../../domain/value_objects/pack_visual_style.dart';

class PackEditorPage extends ConsumerStatefulWidget {
  const PackEditorPage({super.key, required this.projectId, this.packTypeId});

  final CollectionProjectId projectId;
  final PackTypeId? packTypeId;

  @override
  ConsumerState<PackEditorPage> createState() => _PackEditorPageState();
}

class _PackEditorPageState extends ConsumerState<PackEditorPage> {
  PackInput? _input;
  PackConfiguration? _editingConfiguration;
  bool _loaded = false;
  bool _saving = false;
  bool _submitted = false;
  int _simulationCount = 100;
  String? _simulationText;

  bool get _isEditing => widget.packTypeId != null;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final projectAsync = ref.watch(
      _packEditorProjectProvider(widget.projectId),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.backToDrafts,
          onPressed: () => context.go(AppRoutes.createPath),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(_isEditing ? l10n.editPack : l10n.addPack),
      ),
      body: SafeArea(
        child: projectAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.projectNotFound,
          ),
          data: (project) => _ProjectContent(project: project),
        ),
      ),
    );
  }

  void _goBack(CollectionProject project) {
    context.go(AppRoutes.createProjectPath(project.id.value));
  }

  Future<void> _loadInitialState({
    required CollectionProject project,
    required List<Rarity> rarities,
    required List<ImageCardDetails> cards,
    required List<PackConfiguration> packs,
  }) async {
    if (_loaded) {
      return;
    }
    final packTypeId = widget.packTypeId;
    if (packTypeId == null) {
      _input = PackInput.defaults(
        rarities,
        cards.map((details) => details.card).toList(),
      ).copyWith(isMain: packs.isEmpty);
    } else {
      final config = packs.firstWhere(
        (candidate) => candidate.packType.id == packTypeId,
      );
      _editingConfiguration = config;
      _input = _inputFromConfiguration(config, rarities);
    }
    _loaded = true;
  }

  PackInput _inputFromConfiguration(
    PackConfiguration config,
    List<Rarity> rarities,
  ) {
    final probabilitiesByGroup = <ProbabilityGroupId, Map<RarityId, int>>{};
    for (final probability in config.probabilities) {
      probabilitiesByGroup
          .putIfAbsent(probability.probabilityGroupId, () => {})
          .putIfAbsent(probability.rarityId, () => probability.weight);
    }
    final defaultWeights = {for (final rarity in rarities) rarity.id: 1};
    final rules = [...config.slotRules]
      ..sort((a, b) => a.slotIndex.compareTo(b.slotIndex));
    return PackInput(
      name: config.packType.name,
      description: config.packType.description ?? '',
      frontStyle: config.packType.frontStyle,
      backStyle: config.packType.backStyle,
      cardCount: config.packType.cardCount,
      rechargeSeconds: config.packType.rechargeSeconds,
      maxAccumulated: config.packType.maxAccumulated,
      isMain: config.packType.isMain,
      coinsPerFullRecharge: config.packType.coinsPerFullRecharge,
      enabledCardIds: config.pool
          .where((entry) => entry.isEnabled)
          .map((entry) => entry.cardId)
          .toSet(),
      slotRules: [
        for (final rule in rules)
          PackSlotRuleInput(
            ruleType: rule.ruleType,
            fixedRarityId: rule.fixedRarityId,
            minimumRarityOrder: rule.minimumRarityOrder,
            weights:
                probabilitiesByGroup[rule.probabilityGroupId] ?? defaultWeights,
          ),
      ],
    );
  }

  Future<void> _save({
    required CollectionProject project,
    required List<Rarity> rarities,
    required List<ImageCardDetails> cards,
    required List<PackConfiguration> packs,
  }) async {
    setState(() => _submitted = true);
    final input = _input;
    final contentVersionId = project.currentContentVersionId;
    if (input == null || contentVersionId == null || !_basicInputValid(input)) {
      return;
    }
    final duplicate = packs.any((config) {
      if (_editingConfiguration?.packType.id == config.packType.id) {
        return false;
      }
      return PackValidation.normalizedName(config.packType.name) ==
          PackValidation.normalizedName(input.name);
    });
    if (duplicate) {
      return;
    }

    setState(() => _saving = true);
    try {
      final useCases = ref.read(packEditorUseCasesProvider);
      final sortIndex =
          _editingConfiguration?.packType.sortIndex ?? packs.length;
      if (_editingConfiguration == null) {
        await useCases.create(
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
          sortIndex: sortIndex,
          input: input,
        );
      } else {
        await useCases.update(
          packTypeId: _editingConfiguration!.packType.id,
          collectionId: project.collectionId,
          contentVersionId: contentVersionId,
          sortIndex: sortIndex,
          input: input,
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.packSaved)));
        _goBack(project);
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.saveError)));
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  bool _basicInputValid(PackInput input) {
    return input.name.trim().isNotEmpty &&
        input.name.trim().length <= PackValidation.maxNameLength &&
        input.cardCount >= PackValidation.minCardCount &&
        input.cardCount <= PackValidation.maxCardCount &&
        input.rechargeSeconds > 0 &&
        input.maxAccumulated > 0 &&
        (!input.isMain || input.maxAccumulated >= 3) &&
        input.enabledCardIds.isNotEmpty &&
        input.slotRules.length == input.cardCount &&
        input.slotRules.every((rule) {
          if (rule.ruleType == PackSlotRuleType.fixedRarity) {
            return rule.fixedRarityId != null;
          }
          if (rule.ruleType == PackSlotRuleType.minimumRarity) {
            return rule.minimumRarityOrder != null &&
                rule.weights.values.any((weight) => weight > 0);
          }
          return rule.weights.values.any((weight) => weight > 0);
        });
  }

  void _setCardCount(int value, List<Rarity> rarities) {
    final input = _input;
    if (input == null) {
      return;
    }
    final clamped = value.clamp(
      PackValidation.minCardCount,
      PackValidation.maxCardCount,
    );
    final weights = {for (final rarity in rarities) rarity.id: 1};
    final rules = [...input.slotRules];
    while (rules.length < clamped) {
      rules.add(
        PackSlotRuleInput(
          ruleType: PackSlotRuleType.probabilityDistribution,
          weights: weights,
        ),
      );
    }
    if (rules.length > clamped) {
      rules.removeRange(clamped, rules.length);
    }
    setState(
      () => _input = input.copyWith(cardCount: clamped, slotRules: rules),
    );
  }

  void _simulate({
    required List<Rarity> rarities,
    required List<ImageCardDetails> cards,
  }) {
    final input = _input;
    final editing = _editingConfiguration;
    if (input == null || !_basicInputValid(input)) {
      setState(
        () => _simulationText = context.l10n.packConfigurationIncomplete,
      );
      return;
    }
    if (editing == null) {
      setState(() => _simulationText = context.l10n.savePackBeforeSimulating);
      return;
    }
    try {
      final packConfig = _previewConfiguration(
        input: input,
        editing: editing,
        collectionId: editing.packType.collectionId,
        contentVersionId: editing.packType.contentVersionId,
      );
      final counts = <String, int>{};
      final random = Random(42);
      for (var i = 0; i < _simulationCount; i++) {
        final result = const PackGenerator().generate(
          PackGenerationContext(
            configuration: packConfig,
            eligibleCards: cards.map((details) => details.card).toList(),
            rarities: rarities,
          ),
          random,
        );
        for (final card in result) {
          final rarity = rarities.firstWhere((r) => r.id == card.rarityId);
          counts[rarity.name] = (counts[rarity.name] ?? 0) + 1;
        }
      }
      final lines = counts.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join('\n');
      setState(() => _simulationText = lines);
    } on PackGenerationException catch (error) {
      setState(() => _simulationText = error.message);
    }
  }

  PackConfiguration _previewConfiguration({
    required PackInput input,
    required PackConfiguration editing,
    required CollectionId collectionId,
    required ContentVersionId contentVersionId,
  }) {
    final probabilities = <PackRarityProbability>[];
    final rules = <PackSlotRule>[];
    for (var index = 0; index < input.cardCount; index++) {
      final slot = input.slotRules[index];
      final existing = index < editing.slotRules.length
          ? editing.slotRules[index]
          : null;
      final groupId = slot.ruleType == PackSlotRuleType.fixedRarity
          ? null
          : existing?.probabilityGroupId ??
                ProbabilityGroupId('00000000-0000-4000-8000-000000000101');
      if (groupId != null) {
        for (final entry in slot.weights.entries) {
          if (entry.value > 0) {
            probabilities.add(
              PackRarityProbability(
                probabilityGroupId: groupId,
                rarityId: entry.key,
                weight: entry.value,
              ),
            );
          }
        }
      }
      rules.add(
        PackSlotRule(
          id:
              existing?.id ??
              PackSlotRuleId('00000000-0000-4000-8000-000000000102'),
          packTypeId: editing.packType.id,
          slotIndex: index,
          ruleType: slot.ruleType,
          fixedRarityId: slot.ruleType == PackSlotRuleType.fixedRarity
              ? slot.fixedRarityId
              : null,
          minimumRarityOrder: slot.ruleType == PackSlotRuleType.minimumRarity
              ? slot.minimumRarityOrder
              : null,
          probabilityGroupId: groupId,
        ),
      );
    }
    return PackConfiguration(
      packType: editing.packType,
      pool: [
        for (final cardId in input.enabledCardIds)
          PackCardPoolEntry(
            packTypeId: editing.packType.id,
            cardId: cardId,
            isEnabled: true,
          ),
      ],
      slotRules: rules,
      probabilities: probabilities,
    );
  }
}

final _packEditorProjectProvider = FutureProvider.autoDispose
    .family<CollectionProject, CollectionProjectId>((ref, projectId) {
      return ref.watch(collectionProjectRepositoryProvider).getById(projectId);
    });

class _ProjectContent extends ConsumerWidget {
  const _ProjectContent({required this.project});

  final CollectionProject project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentVersionId = project.currentContentVersionId;
    if (contentVersionId == null) {
      return AppErrorView(
        title: context.l10n.screenErrorTitle,
        description: context.l10n.projectNotFound,
      );
    }
    final args = (
      collectionId: project.collectionId,
      contentVersionId: contentVersionId,
    );
    final cardsAsync = ref.watch(imageCardsProvider(args));
    final raritiesAsync = ref.watch(_raritiesForPackEditorProvider(args));
    final packsAsync = ref.watch(packsByVersionProvider(args));

    return cardsAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: context.l10n.screenErrorTitle,
        description: context.l10n.saveError,
      ),
      data: (cards) => raritiesAsync.when(
        loading: () => const AppLoadingView(),
        error: (_, _) => AppErrorView(
          title: context.l10n.screenErrorTitle,
          description: context.l10n.saveError,
        ),
        data: (rarities) => packsAsync.when(
          loading: () => const AppLoadingView(),
          error: (_, _) => AppErrorView(
            title: context.l10n.screenErrorTitle,
            description: context.l10n.saveError,
          ),
          data: (packs) => _PackEditorForm(
            project: project,
            rarities: rarities,
            cards: cards,
            packs: packs,
          ),
        ),
      ),
    );
  }
}

typedef _PackEditorArgs = ({
  CollectionId collectionId,
  ContentVersionId contentVersionId,
});

final _raritiesForPackEditorProvider = StreamProvider.autoDispose
    .family<List<Rarity>, _PackEditorArgs>((ref, args) {
      return ref
          .watch(rarityRepositoryProvider)
          .watchByCollectionVersion(
            collectionId: args.collectionId,
            contentVersionId: args.contentVersionId,
          );
    });

RarityId? _firstRarityId(List<Rarity> rarities) {
  return rarities.isEmpty ? null : rarities.first.id;
}

int? _firstRarityOrder(List<Rarity> rarities) {
  return rarities.isEmpty ? null : rarities.first.orderIndex;
}

class _PackEditorForm extends ConsumerStatefulWidget {
  const _PackEditorForm({
    required this.project,
    required this.rarities,
    required this.cards,
    required this.packs,
  });

  final CollectionProject project;
  final List<Rarity> rarities;
  final List<ImageCardDetails> cards;
  final List<PackConfiguration> packs;

  @override
  ConsumerState<_PackEditorForm> createState() => _PackEditorFormState();
}

class _PackEditorFormState extends ConsumerState<_PackEditorForm> {
  @override
  Widget build(BuildContext context) {
    final pageState = context.findAncestorStateOfType<_PackEditorPageState>()!;
    pageState._loadInitialState(
      project: widget.project,
      rarities: widget.rarities,
      cards: widget.cards,
      packs: widget.packs,
    );
    final input = pageState._input;
    if (input == null) {
      return const AppLoadingView();
    }
    final duplicate = widget.packs.any((config) {
      if (pageState._editingConfiguration?.packType.id == config.packType.id) {
        return false;
      }
      return PackValidation.normalizedName(config.packType.name) ==
          PackValidation.normalizedName(input.name);
    });

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        _PackPreview(style: input.frontStyle, name: input.name),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          initialValue: input.name,
          maxLength: PackValidation.maxNameLength,
          decoration: InputDecoration(
            labelText: context.l10n.name,
            errorText: pageState._submitted
                ? _nameError(context.l10n, input, duplicate)
                : null,
          ),
          onChanged: (value) {
            setState(() {
              pageState._input = input.copyWith(name: value);
            });
          },
        ),
        const SizedBox(height: AppConstants.spacingSm),
        TextFormField(
          initialValue: input.description,
          decoration: InputDecoration(labelText: context.l10n.description),
          minLines: 2,
          maxLines: 4,
          onChanged: (value) {
            setState(() {
              pageState._input = input.copyWith(description: value);
            });
          },
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(context.l10n.mainPack),
          value: input.isMain,
          onChanged: (value) {
            setState(() {
              pageState._input = input.copyWith(isMain: value);
            });
          },
        ),
        _NumberField(
          label: context.l10n.cardsPerPack,
          value: input.cardCount,
          min: 1,
          max: 10,
          onChanged: (value) =>
              setState(() => pageState._setCardCount(value, widget.rarities)),
        ),
        _DurationField(
          seconds: input.rechargeSeconds,
          onChanged: (seconds) {
            setState(() {
              pageState._input = input.copyWith(rechargeSeconds: seconds);
            });
          },
        ),
        _NumberField(
          label: context.l10n.maxAccumulated,
          value: input.maxAccumulated,
          min: 1,
          max: 99,
          onChanged: (value) {
            setState(() {
              pageState._input = input.copyWith(maxAccumulated: value);
            });
          },
        ),
        _NumberField(
          label: context.l10n.accelerationCost,
          value: input.coinsPerFullRecharge,
          min: 0,
          max: 999999,
          onChanged: (value) {
            setState(() {
              pageState._input = input.copyWith(coinsPerFullRecharge: value);
            });
          },
        ),
        _StylePicker(
          title: context.l10n.frontDesign,
          style: input.frontStyle,
          onChanged: (style) {
            setState(() {
              pageState._input = input.copyWith(frontStyle: style);
            });
          },
        ),
        _StylePicker(
          title: context.l10n.backDesign,
          style: input.backStyle,
          onChanged: (style) {
            setState(() {
              pageState._input = input.copyWith(backStyle: style);
            });
          },
        ),
        _EligibleCardsSection(
          cards: widget.cards,
          rarities: widget.rarities,
          selectedIds: input.enabledCardIds,
          onChanged: (ids) {
            setState(() {
              pageState._input = input.copyWith(enabledCardIds: ids);
            });
          },
        ),
        _SlotRulesSection(
          input: input,
          rarities: widget.rarities,
          onChanged: (rules) {
            setState(() {
              pageState._input = input.copyWith(slotRules: rules);
            });
          },
        ),
        _ValidationSummary(
          input: input,
          duplicateName: duplicate,
          submitted: pageState._submitted,
        ),
        _SimulationSection(
          count: pageState._simulationCount,
          result: pageState._simulationText,
          onCountChanged: (value) {
            setState(() => pageState._simulationCount = value);
          },
          onRun: () {
            setState(() {
              pageState._simulate(
                rarities: widget.rarities,
                cards: widget.cards,
              );
            });
          },
        ),
        const SizedBox(height: AppConstants.spacingLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: pageState._saving
                  ? null
                  : () => pageState._goBack(widget.project),
              child: Text(context.l10n.cancel),
            ),
            const SizedBox(width: AppConstants.spacingSm),
            FilledButton.icon(
              onPressed: pageState._saving
                  ? null
                  : () => pageState._save(
                      project: widget.project,
                      rarities: widget.rarities,
                      cards: widget.cards,
                      packs: widget.packs,
                    ),
              icon: pageState._saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(context.l10n.save),
            ),
          ],
        ),
      ],
    );
  }

  String? _nameError(AppLocalizations l10n, PackInput input, bool duplicate) {
    if (input.name.trim().isEmpty) {
      return l10n.packNameRequired;
    }
    if (input.name.trim().length > PackValidation.maxNameLength) {
      return l10n.fieldTooLong;
    }
    if (duplicate) {
      return l10n.duplicatePackName;
    }
    return null;
  }
}

class _PackPreview extends StatelessWidget {
  const _PackPreview({required this.style, required this.name});

  final PackVisualStyle style;
  final String name;

  @override
  Widget build(BuildContext context) {
    final color = Color(PackVisualCatalog.colorValueForId(style.colorId));
    final accent = Color(
      PackVisualCatalog.colorValueForId(style.accentColorId),
    );
    return AspectRatio(
      aspectRatio: 2.1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _PackPatternPainter(style, accent)),
            ),
            Center(
              child: Icon(
                PackVisualCatalog.iconForId(style.iconId),
                size: 56,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: AppConstants.spacingMd,
              right: AppConstants.spacingMd,
              bottom: AppConstants.spacingMd,
              child: Text(
                name.trim().isEmpty ? context.l10n.packPreviewName : name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackPatternPainter extends CustomPainter {
  const _PackPatternPainter(this.style, this.accent);

  final PackVisualStyle style;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = accent.withValues(alpha: 0.28);
    if (style.patternId == 'dots') {
      for (var x = 18.0; x < size.width; x += 32) {
        for (var y = 18.0; y < size.height; y += 32) {
          canvas.drawCircle(Offset(x, y), 4, paint);
        }
      }
      return;
    }
    if (style.patternId == 'frame') {
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          const Radius.circular(8),
        ).deflate(14),
        paint,
      );
      return;
    }
    paint.strokeWidth = 10;
    for (var x = -size.height; x < size.width; x += 34) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PackPatternPainter oldDelegate) {
    return oldDelegate.style != style || oldDelegate.accent != accent;
  }
}

class _NumberField extends StatelessWidget {
  const _NumberField({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: SizedBox(
        width: 132,
        child: Row(
          children: [
            IconButton(
              onPressed: value <= min ? null : () => onChanged(value - 1),
              icon: const Icon(Icons.remove),
            ),
            Expanded(child: Center(child: Text(value.toString()))),
            IconButton(
              onPressed: value >= max ? null : () => onChanged(value + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class _DurationField extends StatelessWidget {
  const _DurationField({required this.seconds, required this.onChanged});

  final int seconds;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(context.l10n.rechargeTime),
      subtitle: Text('${hours}h ${remainingMinutes}m'),
      trailing: SizedBox(
        width: 132,
        child: Row(
          children: [
            IconButton(
              onPressed: seconds <= 60 ? null : () => onChanged(seconds - 3600),
              icon: const Icon(Icons.remove),
            ),
            IconButton(
              onPressed: () => onChanged(seconds + 3600),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class _StylePicker extends StatelessWidget {
  const _StylePicker({
    required this.title,
    required this.style,
    required this.onChanged,
  });

  final String title;
  final PackVisualStyle style;
  final ValueChanged<PackVisualStyle> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          Wrap(
            spacing: AppConstants.spacingSm,
            children: [
              for (final color in PackVisualCatalog.colors)
                ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: Color(color.colorValue),
                  ),
                  label: Text(color.id),
                  selected: style.colorId == color.id,
                  onSelected: (_) =>
                      onChanged(style.copyWith(colorId: color.id)),
                ),
            ],
          ),
          Wrap(
            spacing: AppConstants.spacingSm,
            children: [
              for (final color in PackVisualCatalog.colors)
                ChoiceChip(
                  avatar: CircleAvatar(
                    backgroundColor: Color(color.colorValue),
                  ),
                  label: Text('${context.l10n.accentColor}: ${color.id}'),
                  selected: style.accentColorId == color.id,
                  onSelected: (_) =>
                      onChanged(style.copyWith(accentColorId: color.id)),
                ),
            ],
          ),
          Wrap(
            spacing: AppConstants.spacingSm,
            children: [
              for (final icon in PackVisualCatalog.icons)
                ChoiceChip(
                  avatar: Icon(PackVisualCatalog.iconForId(icon.id), size: 18),
                  label: Text(icon.id),
                  selected: style.iconId == icon.id,
                  onSelected: (_) => onChanged(style.copyWith(iconId: icon.id)),
                ),
            ],
          ),
          Wrap(
            spacing: AppConstants.spacingSm,
            children: [
              for (final pattern in PackVisualCatalog.patterns)
                ChoiceChip(
                  label: Text(pattern.id),
                  selected: style.patternId == pattern.id,
                  onSelected: (_) =>
                      onChanged(style.copyWith(patternId: pattern.id)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EligibleCardsSection extends StatefulWidget {
  const _EligibleCardsSection({
    required this.cards,
    required this.rarities,
    required this.selectedIds,
    required this.onChanged,
  });

  final List<ImageCardDetails> cards;
  final List<Rarity> rarities;
  final Set<CardId> selectedIds;
  final ValueChanged<Set<CardId>> onChanged;

  @override
  State<_EligibleCardsSection> createState() => _EligibleCardsSectionState();
}

class _EligibleCardsSectionState extends State<_EligibleCardsSection> {
  String _query = '';
  RarityId? _rarityFilter;

  @override
  Widget build(BuildContext context) {
    final filtered = widget.cards.where((details) {
      final matchesText =
          _query.trim().isEmpty ||
          details.card.name.toLowerCase().contains(_query.toLowerCase()) ||
          details.card.collectionNumber.toString().contains(_query);
      final matchesRarity =
          _rarityFilter == null || details.card.rarityId == _rarityFilter;
      return matchesText && matchesRarity;
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.eligibleCardsCount(widget.selectedIds.length),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextField(
            decoration: InputDecoration(labelText: context.l10n.searchCards),
            onChanged: (value) => setState(() => _query = value),
          ),
          DropdownButton<RarityId?>(
            value: _rarityFilter,
            isExpanded: true,
            items: [
              DropdownMenuItem(value: null, child: Text(context.l10n.allCards)),
              for (final rarity in widget.rarities)
                DropdownMenuItem(value: rarity.id, child: Text(rarity.name)),
            ],
            onChanged: (value) => setState(() => _rarityFilter = value),
          ),
          Wrap(
            spacing: AppConstants.spacingSm,
            children: [
              TextButton(
                onPressed: () {
                  widget.onChanged(widget.cards.map((e) => e.card.id).toSet());
                },
                child: Text(context.l10n.selectAll),
              ),
              TextButton(
                onPressed: () => widget.onChanged({}),
                child: Text(context.l10n.deselectAll),
              ),
            ],
          ),
          for (final details in filtered)
            CheckboxListTile(
              value: widget.selectedIds.contains(details.card.id),
              onChanged: (value) {
                final ids = {...widget.selectedIds};
                if (value == true) {
                  ids.add(details.card.id);
                } else {
                  ids.remove(details.card.id);
                }
                widget.onChanged(ids);
              },
              secondary: SizedBox.square(
                dimension: 44,
                child: StoredMediaImage(
                  path: (details.thumbnailAsset ?? details.mediaAsset)
                      .relativePath,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(details.card.name),
              subtitle: Text('#${details.card.collectionNumber}'),
            ),
        ],
      ),
    );
  }
}

class _SlotRulesSection extends StatelessWidget {
  const _SlotRulesSection({
    required this.input,
    required this.rarities,
    required this.onChanged,
  });

  final PackInput input;
  final List<Rarity> rarities;
  final ValueChanged<List<PackSlotRuleInput>> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.slotRules,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (var index = 0; index < input.slotRules.length; index++)
            _SlotRuleTile(
              index: index,
              rule: input.slotRules[index],
              rarities: rarities,
              onChanged: (rule) {
                final rules = [...input.slotRules];
                rules[index] = rule;
                onChanged(rules);
              },
            ),
        ],
      ),
    );
  }
}

class _SlotRuleTile extends StatelessWidget {
  const _SlotRuleTile({
    required this.index,
    required this.rule,
    required this.rarities,
    required this.onChanged,
  });

  final int index;
  final PackSlotRuleInput rule;
  final List<Rarity> rarities;
  final ValueChanged<PackSlotRuleInput> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.slotPosition(index + 1)),
            DropdownButton<PackSlotRuleType>(
              value: rule.ruleType,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: PackSlotRuleType.probabilityDistribution,
                  child: Text(context.l10n.probabilityDistribution),
                ),
                DropdownMenuItem(
                  value: PackSlotRuleType.fixedRarity,
                  child: Text(context.l10n.fixedRarity),
                ),
                DropdownMenuItem(
                  value: PackSlotRuleType.minimumRarity,
                  child: Text(context.l10n.minimumRarity),
                ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                final first = rarities.isEmpty ? null : rarities.first;
                onChanged(
                  PackSlotRuleInput(
                    ruleType: value,
                    fixedRarityId: value == PackSlotRuleType.fixedRarity
                        ? first?.id
                        : null,
                    minimumRarityOrder: value == PackSlotRuleType.minimumRarity
                        ? first?.orderIndex
                        : null,
                    weights: rule.weights,
                  ),
                );
              },
            ),
            if (rule.ruleType == PackSlotRuleType.fixedRarity)
              DropdownButton<RarityId>(
                value: rule.fixedRarityId ?? _firstRarityId(rarities),
                isExpanded: true,
                items: [
                  for (final rarity in rarities)
                    DropdownMenuItem(
                      value: rarity.id,
                      child: Text(rarity.name),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onChanged(
                      PackSlotRuleInput(
                        ruleType: rule.ruleType,
                        fixedRarityId: value,
                        weights: rule.weights,
                      ),
                    );
                  }
                },
              ),
            if (rule.ruleType == PackSlotRuleType.minimumRarity)
              DropdownButton<int>(
                value: rule.minimumRarityOrder ?? _firstRarityOrder(rarities),
                isExpanded: true,
                items: [
                  for (final rarity in rarities)
                    DropdownMenuItem(
                      value: rarity.orderIndex,
                      child: Text(rarity.name),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onChanged(
                      PackSlotRuleInput(
                        ruleType: rule.ruleType,
                        minimumRarityOrder: value,
                        weights: rule.weights,
                      ),
                    );
                  }
                },
              ),
            if (rule.ruleType != PackSlotRuleType.fixedRarity)
              for (final rarity in rarities)
                _WeightRow(
                  rarity: rarity,
                  weight: rule.weights[rarity.id] ?? 0,
                  onChanged: (weight) {
                    final weights = {...rule.weights, rarity.id: weight};
                    onChanged(
                      PackSlotRuleInput(
                        ruleType: rule.ruleType,
                        minimumRarityOrder: rule.minimumRarityOrder,
                        weights: weights,
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}

class _WeightRow extends StatelessWidget {
  const _WeightRow({
    required this.rarity,
    required this.weight,
    required this.onChanged,
  });

  final Rarity rarity;
  final int weight;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(rarity.name),
      trailing: SizedBox(
        width: 126,
        child: Row(
          children: [
            IconButton(
              onPressed: weight <= 0 ? null : () => onChanged(weight - 1),
              icon: const Icon(Icons.remove),
            ),
            Expanded(child: Center(child: Text(weight.toString()))),
            IconButton(
              onPressed: () => onChanged(weight + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class _ValidationSummary extends StatelessWidget {
  const _ValidationSummary({
    required this.input,
    required this.duplicateName,
    required this.submitted,
  });

  final PackInput input;
  final bool duplicateName;
  final bool submitted;

  @override
  Widget build(BuildContext context) {
    final issues = <String>[
      if (input.name.trim().isEmpty) context.l10n.packNameRequired,
      if (duplicateName) context.l10n.duplicatePackName,
      if (input.enabledCardIds.isEmpty) context.l10n.noEligibleCards,
      if (input.isMain && input.maxAccumulated < 3)
        context.l10n.mainPackNeedsThree,
      if (input.slotRules.any(
        (rule) =>
            rule.ruleType != PackSlotRuleType.fixedRarity &&
            !rule.weights.values.any((weight) => weight > 0),
      ))
        context.l10n.probabilityNeedsWeight,
    ];
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingLg),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.validation,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (issues.isEmpty)
                Text(context.l10n.packConfigurationValid)
              else
                for (final issue in issues) Text(issue),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimulationSection extends StatelessWidget {
  const _SimulationSection({
    required this.count,
    required this.result,
    required this.onCountChanged,
    required this.onRun,
  });

  final int count;
  final String? result;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onRun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.simulation,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          DropdownButton<int>(
            value: count,
            items: const [
              DropdownMenuItem(value: 100, child: Text('100')),
              DropdownMenuItem(value: 1000, child: Text('1000')),
              DropdownMenuItem(value: 10000, child: Text('10000')),
            ],
            onChanged: (value) {
              if (value != null) {
                onCountChanged(value);
              }
            },
          ),
          FilledButton.icon(
            onPressed: onRun,
            icon: const Icon(Icons.play_arrow_outlined),
            label: Text(context.l10n.simulate),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.only(top: AppConstants.spacingSm),
              child: Text(result!),
            ),
        ],
      ),
    );
  }
}
