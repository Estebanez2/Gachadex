import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../../../cards/application/card_providers.dart';
import '../../../cards/domain/repositories/card_repository.dart';
import '../../../cards/presentation/widgets/gachadex_card.dart';
import '../../../packs/application/pack_providers.dart';
import '../../../packs/domain/entities/pack_configuration.dart';
import '../../../rarities/application/rarity_use_case_providers.dart';
import '../../../rarities/application/rarity_use_cases.dart';
import '../../../rarities/domain/catalogs/rarity_visual_catalog.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../../../rarities/domain/validation/rarity_validation.dart';
import '../../../rarities/presentation/widgets/rarity_preview.dart';
import '../../application/collection_draft_use_case_providers.dart';
import '../../domain/catalogs/draft_cover_catalog.dart';
import '../../domain/validation/collection_draft_validation.dart';
import '../../domain/validation/collection_finalization_validation.dart';
import '../controllers/collection_draft_controller.dart';
import '../widgets/draft_cover_preview.dart';
import '../widgets/visual_option_labels.dart';

enum _EditorSection { information, rarities, cards, packs, review }

class CollectionDraftEditorPage extends ConsumerStatefulWidget {
  const CollectionDraftEditorPage({super.key, required this.projectId});

  final CollectionProjectId projectId;

  @override
  ConsumerState<CollectionDraftEditorPage> createState() =>
      _CollectionDraftEditorPageState();
}

class _CollectionDraftEditorPageState
    extends ConsumerState<CollectionDraftEditorPage>
    with WidgetsBindingObserver {
  _EditorSection _section = _EditorSection.information;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      unawaited(
        ref
            .read(collectionDraftControllerProvider(widget.projectId).notifier)
            .flushPendingSave(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final asyncState = ref.watch(
      collectionDraftControllerProvider(widget.projectId),
    );
    final draft = asyncState.asData?.value;
    final title = draft == null || draft.name.trim().isEmpty
        ? l10n.unnamedCollection
        : draft.name.trim();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _leave();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: l10n.backToDrafts,
            onPressed: _leave,
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(title),
          actions: [
            if (draft != null)
              IconButton(
                tooltip: l10n.deleteDraft,
                onPressed: () => _confirmDeleteDraft(context, ref, draft),
                icon: const Icon(Icons.delete_outline),
              ),
          ],
        ),
        body: SafeArea(
          child: draft == null
              ? asyncState.when(
                  loading: () => const AppLoadingView(),
                  error: (error, stackTrace) => AppErrorView(
                    title: l10n.screenErrorTitle,
                    description: error is EntityNotFoundFailure
                        ? l10n.projectNotFound
                        : l10n.saveError,
                    onRetry: () => context.go(AppRoutes.createPath),
                    retryLabel: l10n.backToDrafts,
                  ),
                  data: (state) => _EditorBody(
                    state: state,
                    section: _section,
                    onSectionChanged: (section) {
                      setState(() => _section = section);
                    },
                  ),
                )
              : _EditorBody(
                  state: draft,
                  section: _section,
                  onSectionChanged: (section) {
                    setState(() => _section = section);
                  },
                ),
        ),
      ),
    );
  }

  Future<void> _leave() async {
    await ref
        .read(collectionDraftControllerProvider(widget.projectId).notifier)
        .flushPendingSave();
    if (mounted) {
      context.go(AppRoutes.createPath);
    }
  }
}

class _EditorBody extends ConsumerWidget {
  const _EditorBody({
    required this.state,
    required this.section,
    required this.onSectionChanged,
  });

  final CollectionDraftEditorState state;
  final _EditorSection section;
  final ValueChanged<_EditorSection> onSectionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: AppConstants.spacingSm,
                  runSpacing: AppConstants.spacingSm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Chip(label: Text(l10n.draft)),
                    _SaveStatusChip(state: state),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingMd),
                _CompletionPanel(
                  state: state,
                  onSectionChanged: onSectionChanged,
                ),
                const SizedBox(height: AppConstants.spacingMd),
                SegmentedButton<_EditorSection>(
                  segments: [
                    ButtonSegment(
                      value: _EditorSection.information,
                      icon: const Icon(Icons.info_outline),
                      label: Text(l10n.information),
                    ),
                    ButtonSegment(
                      value: _EditorSection.rarities,
                      icon: const Icon(Icons.auto_awesome_outlined),
                      label: Text(l10n.rarities),
                    ),
                    ButtonSegment(
                      value: _EditorSection.cards,
                      icon: const Icon(Icons.style_outlined),
                      label: Text(l10n.cards),
                    ),
                    ButtonSegment(
                      value: _EditorSection.packs,
                      icon: const Icon(Icons.inventory_2_outlined),
                      label: Text(l10n.packs),
                    ),
                    ButtonSegment(
                      value: _EditorSection.review,
                      icon: const Icon(Icons.fact_check_outlined),
                      label: Text(l10n.review),
                    ),
                  ],
                  selected: {section},
                  onSelectionChanged: (selection) {
                    onSectionChanged(selection.single);
                  },
                ),
                const SizedBox(height: AppConstants.spacingMd),
                AnimatedSwitcher(
                  duration: AppConstants.shortAnimationDuration,
                  child: switch (section) {
                    _EditorSection.information => _InformationSection(
                      key: const ValueKey('information'),
                      state: state,
                    ),
                    _EditorSection.rarities => _RaritiesSection(
                      key: const ValueKey('rarities'),
                      state: state,
                    ),
                    _EditorSection.cards => _CardsSection(
                      key: const ValueKey('cards'),
                      state: state,
                    ),
                    _EditorSection.packs => _PacksSection(
                      key: const ValueKey('packs'),
                      state: state,
                    ),
                    _EditorSection.review => _ReviewSection(
                      key: const ValueKey('review'),
                      state: state,
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SaveStatusChip extends ConsumerWidget {
  const _SaveStatusChip({required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final (icon, label) = switch (state.saveStatus) {
      DraftSaveStatus.pending => (Icons.pending_outlined, l10n.savePending),
      DraftSaveStatus.saving => (Icons.sync_outlined, l10n.saving),
      DraftSaveStatus.error => (
        Icons.error_outline,
        state.infoErrors.canSave ? l10n.saveError : l10n.fixFieldsToSave,
      ),
      DraftSaveStatus.saved => (Icons.check_circle_outline, l10n.saved),
    };

    return InputChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      onPressed:
          state.saveStatus == DraftSaveStatus.error && state.infoErrors.canSave
          ? () => ref
                .read(
                  collectionDraftControllerProvider(state.project.id).notifier,
                )
                .retrySave()
          : null,
    );
  }
}

class _CompletionPanel extends StatelessWidget {
  const _CompletionPanel({required this.state, required this.onSectionChanged});

  final CollectionDraftEditorState state;
  final ValueChanged<_EditorSection> onSectionChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          children: [
            _CompletionRow(
              title: l10n.information,
              status: state.completeness.info,
              missingText: l10n.collectionNeedsName,
              onTap: () => onSectionChanged(_EditorSection.information),
            ),
            const Divider(),
            _CompletionRow(
              title: l10n.rarities,
              status: state.completeness.rarities,
              missingText: l10n.atLeastOneRarity,
              onTap: () => onSectionChanged(_EditorSection.rarities),
            ),
            const Divider(),
            _CompletionRow(
              title: l10n.cards,
              status: state.completeness.cards,
              missingText: l10n.atLeastOneCard,
              onTap: () => onSectionChanged(_EditorSection.cards),
            ),
            const Divider(),
            _CompletionRow(
              title: l10n.packs,
              status: state.completeness.packs,
              missingText: l10n.atLeastOnePack,
              onTap: () => onSectionChanged(_EditorSection.packs),
            ),
            const Divider(),
            _CompletionRow(
              title: l10n.review,
              status: state.completeness.completeForThisPhase
                  ? DraftSectionCompletion.completeForThisPhase
                  : DraftSectionCompletion.incomplete,
              missingText: l10n.reviewNeedsCompleteDraft,
              onTap: () => onSectionChanged(_EditorSection.review),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({
    required this.title,
    required this.status,
    required this.missingText,
    required this.onTap,
  });

  final String title;
  final DraftSectionCompletion status;
  final String missingText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final complete = status == DraftSectionCompletion.completeForThisPhase;
    final label = switch (status) {
      DraftSectionCompletion.notStarted => l10n.notStarted,
      DraftSectionCompletion.incomplete => l10n.incomplete,
      DraftSectionCompletion.completeForThisPhase => l10n.completeForThisPhase,
      DraftSectionCompletion.withErrors => l10n.withErrors,
    };

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(
        complete ? Icons.check_circle_outline : Icons.radio_button_unchecked,
      ),
      title: Text(title),
      subtitle: complete ? null : Text(missingText),
      trailing: Text(label),
    );
  }
}

class _InformationSection extends ConsumerWidget {
  const _InformationSection({super.key, required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final controller = ref.read(
      collectionDraftControllerProvider(state.project.id).notifier,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DraftCoverPreview(
          style: state.draftCoverStyle,
          collectionName: state.name,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          key: ValueKey('draft-name-${state.project.id.value}'),
          initialValue: state.name,
          maxLength: CollectionDraftValidation.maxNameLength,
          decoration: InputDecoration(
            labelText: l10n.collectionName,
            errorText: state.infoErrors.nameTooLong ? l10n.fieldTooLong : null,
          ),
          buildCounter: _buildCounter,
          textInputAction: TextInputAction.next,
          onChanged: controller.editName,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          key: ValueKey('draft-author-${state.project.id.value}'),
          initialValue: state.author,
          maxLength: CollectionDraftValidation.maxAuthorLength,
          decoration: InputDecoration(
            labelText: l10n.author,
            errorText: state.infoErrors.authorTooLong
                ? l10n.fieldTooLong
                : null,
          ),
          buildCounter: _buildCounter,
          textInputAction: TextInputAction.next,
          onChanged: controller.editAuthor,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextFormField(
          key: ValueKey('draft-description-${state.project.id.value}'),
          initialValue: state.description,
          maxLength: CollectionDraftValidation.maxDescriptionLength,
          minLines: 3,
          maxLines: 7,
          decoration: InputDecoration(
            labelText: l10n.description,
            errorText: state.infoErrors.descriptionTooLong
                ? l10n.fieldTooLong
                : null,
          ),
          buildCounter: _buildCounter,
          onChanged: controller.editDescription,
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _CoverStyleSection(state: state),
      ],
    );
  }

  Widget? _buildCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    final max = maxLength;
    if (max == null) {
      return null;
    }

    return Text(context.l10n.charactersCounter(currentLength, max));
  }
}

class _CoverStyleSection extends ConsumerWidget {
  const _CoverStyleSection({required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final controller = ref.read(
      collectionDraftControllerProvider(state.project.id).notifier,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.cover,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _OptionTitle(label: l10n.primaryColor),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: [
            for (final option in DraftCoverCatalog.colors)
              ChoiceChip(
                avatar: CircleAvatar(backgroundColor: Color(option.colorValue)),
                label: Text(coverColorLabel(l10n, option.id)),
                selected: state.draftCoverStyle.backgroundColorId == option.id,
                onSelected: (_) {
                  controller.editCover(
                    state.draftCoverStyle.copyWith(
                      backgroundColorId: option.id,
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _OptionTitle(label: l10n.accentColor),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: [
            for (final option in DraftCoverCatalog.colors)
              ChoiceChip(
                avatar: CircleAvatar(backgroundColor: Color(option.colorValue)),
                label: Text(coverColorLabel(l10n, option.id)),
                selected: state.draftCoverStyle.accentColorId == option.id,
                onSelected: (_) {
                  controller.editCover(
                    state.draftCoverStyle.copyWith(accentColorId: option.id),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _OptionTitle(label: l10n.icon),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: [
            for (final option in DraftCoverCatalog.icons)
              ChoiceChip(
                avatar: Icon(coverIconForId(option.id), size: 18),
                label: Text(coverIconLabel(l10n, option.id)),
                selected: state.draftCoverStyle.iconId == option.id,
                onSelected: (_) {
                  controller.editCover(
                    state.draftCoverStyle.copyWith(iconId: option.id),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _OptionTitle(label: l10n.style),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: [
            for (final option in DraftCoverCatalog.patterns)
              ChoiceChip(
                label: Text(coverPatternLabel(l10n, option.id)),
                selected: state.draftCoverStyle.patternId == option.id,
                onSelected: (_) {
                  controller.editCover(
                    state.draftCoverStyle.copyWith(patternId: option.id),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _RaritiesSection extends ConsumerWidget {
  const _RaritiesSection({super.key, required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contentVersionId = state.project.currentContentVersionId;
    if (contentVersionId == null) {
      return AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.projectNotFound,
      );
    }
    final probabilityTotal = _rarityProbabilityTotal(state.rarities);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.rarities,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Tooltip(
              message: l10n.addRarity,
              child: FilledButton.icon(
                onPressed: () => _showRarityForm(context, ref, state),
                icon: const Icon(Icons.add),
                label: Text(l10n.addRarity),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        if (state.rarities.isEmpty)
          AppEmptyView(
            icon: Icons.auto_awesome_outlined,
            title: l10n.noRaritiesTitle,
            description: l10n.noRaritiesDescription,
            action: FilledButton.icon(
              onPressed: () => _showRarityForm(context, ref, state),
              icon: const Icon(Icons.add),
              label: Text(l10n.addRarity),
            ),
          )
        else ...[
          _RarityProbabilitySummary(total: probabilityTotal),
          const SizedBox(height: AppConstants.spacingMd),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            itemCount: state.rarities.length,
            onReorderItem: (oldIndex, newIndex) {
              _reorder(context, ref, state, oldIndex, newIndex);
            },
            itemBuilder: (context, index) {
              final rarity = state.rarities[index];
              return _RarityListItem(
                key: ValueKey(rarity.id.value),
                rarity: rarity,
                index: index,
                isFirst: index == 0,
                isLast: index == state.rarities.length - 1,
                onEdit: () => _showRarityForm(context, ref, state, rarity),
                onDelete: () =>
                    _confirmDeleteRarity(context, ref, state, rarity),
                onMoveUp: () => _move(context, ref, state, index, -1),
                onMoveDown: () => _move(context, ref, state, index, 1),
              );
            },
          ),
        ],
      ],
    );
  }

  Future<void> _move(
    BuildContext context,
    WidgetRef ref,
    CollectionDraftEditorState state,
    int index,
    int direction,
  ) async {
    final target = index + direction;
    if (target < 0 || target >= state.rarities.length) {
      return;
    }

    final items = state.rarities.toList();
    final item = items.removeAt(index);
    items.insert(target, item);
    await _persistOrder(context, ref, state, items);
  }

  Future<void> _reorder(
    BuildContext context,
    WidgetRef ref,
    CollectionDraftEditorState state,
    int oldIndex,
    int newIndex,
  ) async {
    final items = state.rarities.toList();
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    await _persistOrder(context, ref, state, items);
  }

  Future<void> _persistOrder(
    BuildContext context,
    WidgetRef ref,
    CollectionDraftEditorState state,
    List<Rarity> ordered,
  ) async {
    final contentVersionId = state.project.currentContentVersionId;
    if (contentVersionId == null) {
      return;
    }

    try {
      await ref
          .read(reorderRaritiesProvider)
          .call(
            projectId: state.project.id,
            collectionId: state.project.collectionId,
            contentVersionId: contentVersionId,
            orderedIds: ordered
                .map((rarity) => rarity.id)
                .toList(growable: false),
          );
    } on Object {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.saveError)));
      }
    }
  }
}

class _CardsSection extends ConsumerWidget {
  const _CardsSection({super.key, required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contentVersionId = state.project.currentContentVersionId;
    if (contentVersionId == null) {
      return AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.projectNotFound,
      );
    }

    final cardsAsync = ref.watch(
      imageCardsProvider((
        collectionId: state.project.collectionId,
        contentVersionId: contentVersionId,
      )),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${l10n.cards} (${state.cardCount})',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            FilledButton.icon(
              onPressed: () => context.go(
                AppRoutes.createCardNewPath(state.project.id.value),
              ),
              icon: const Icon(Icons.add),
              label: Text(l10n.addCard),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        cardsAsync.when(
          loading: () => const AppLoadingView(),
          error: (error, stackTrace) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.saveError,
          ),
          data: (cards) {
            if (cards.isEmpty) {
              return AppEmptyView(
                icon: Icons.style_outlined,
                title: l10n.noCardsTitle,
                description: l10n.noCardsDescription,
                action: FilledButton.icon(
                  onPressed: () => context.go(
                    AppRoutes.createCardNewPath(state.project.id.value),
                  ),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.addCard),
                ),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 220,
                childAspectRatio: 0.66,
                mainAxisSpacing: AppConstants.spacingMd,
                crossAxisSpacing: AppConstants.spacingMd,
              ),
              itemBuilder: (context, index) {
                return _CardGridItem(
                  details: cards[index],
                  rarityName: _rarityName(cards[index]),
                  onEdit: () => context.go(
                    AppRoutes.createCardEditPath(
                      state.project.id.value,
                      cards[index].card.id.value,
                    ),
                  ),
                  onDelete: () =>
                      _confirmDeleteCard(context, ref, state, cards[index]),
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _rarityName(ImageCardDetails details) {
    for (final rarity in state.rarities) {
      if (rarity.id == details.card.rarityId) {
        return rarity.name;
      }
    }
    return '';
  }
}

class _PacksSection extends ConsumerWidget {
  const _PacksSection({super.key, required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contentVersionId = state.project.currentContentVersionId;
    if (contentVersionId == null) {
      return AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.projectNotFound,
      );
    }
    final packsAsync = ref.watch(
      packsByVersionProvider((
        collectionId: state.project.collectionId,
        contentVersionId: contentVersionId,
      )),
    );

    return packsAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (packs) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.packs,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              FilledButton.icon(
                onPressed: state.cardCount <= 0
                    ? null
                    : () => context.go(
                        AppRoutes.createPackNewPath(state.project.id.value),
                      ),
                icon: const Icon(Icons.add),
                label: Text(l10n.addPack),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),
          if (state.cardCount <= 0)
            AppEmptyView(
              icon: Icons.style_outlined,
              title: l10n.noCardsTitle,
              description: l10n.atLeastOneCard,
            )
          else if (packs.isEmpty)
            AppEmptyView(
              icon: Icons.inventory_2_outlined,
              title: l10n.noPacksTitle,
              description: l10n.noPacksDescription,
            )
          else
            ReorderableListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: packs.length,
              onReorderItem: (oldIndex, newIndex) async {
                final ordered = [...packs];
                final moved = ordered.removeAt(oldIndex);
                ordered.insert(newIndex, moved);
                await ref
                    .read(packEditorUseCasesProvider)
                    .reorder(
                      collectionId: state.project.collectionId,
                      contentVersionId: contentVersionId,
                      orderedIds: ordered
                          .map((config) => config.packType.id)
                          .toList(),
                    );
              },
              itemBuilder: (context, index) {
                final config = packs[index];
                return _PackListItem(
                  key: ValueKey(config.packType.id.value),
                  config: config,
                  index: index,
                  isFirst: index == 0,
                  isLast: index == packs.length - 1,
                  onEdit: () => context.go(
                    AppRoutes.createPackEditPath(
                      state.project.id.value,
                      config.packType.id.value,
                    ),
                  ),
                  onSetMain: config.packType.isMain
                      ? null
                      : () => ref
                            .read(packEditorUseCasesProvider)
                            .setMain(config.packType.id),
                  onDelete: () => _confirmDeletePack(context, ref, config),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _ReviewSection extends ConsumerWidget {
  const _ReviewSection({super.key, required this.state});

  final CollectionDraftEditorState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final reportAsync = ref.watch(
      collectionFinalizationReportProvider(state.project.id),
    );

    return reportAsync.when(
      loading: () => const AppLoadingView(),
      error: (_, _) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
      ),
      data: (report) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.review,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(l10n.finalizationReviewDescription),
          const SizedBox(height: AppConstants.spacingMd),
          _FinalizationSectionCard(
            title: l10n.information,
            issues: report.issuesFor(FinalizationSection.information),
          ),
          _FinalizationSectionCard(
            title: l10n.rarities,
            issues: report.issuesFor(FinalizationSection.rarities),
          ),
          _FinalizationSectionCard(
            title: l10n.cards,
            issues: report.issuesFor(FinalizationSection.cards),
          ),
          _FinalizationSectionCard(
            title: l10n.packs,
            issues: report.issuesFor(FinalizationSection.packs),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Align(
            alignment: Alignment.centerRight,
            child: FilledButton.icon(
              onPressed: report.canFinalize
                  ? () => _confirmFinalizeCollection(context, ref, state)
                  : null,
              icon: const Icon(Icons.check_circle_outline),
              label: Text(l10n.finalizeCollection),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalizationSectionCard extends StatelessWidget {
  const _FinalizationSectionCard({required this.title, required this.issues});

  final String title;
  final List<CollectionFinalizationIssue> issues;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final complete = issues.isEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  complete ? Icons.check_circle_outline : Icons.error_outline,
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(complete ? l10n.ready : l10n.withErrors),
              ],
            ),
            if (!complete) ...[
              const SizedBox(height: AppConstants.spacingSm),
              for (final issue in issues)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.spacingXs,
                  ),
                  child: Text(issue.message),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PackListItem extends StatelessWidget {
  const _PackListItem({
    super.key,
    required this.config,
    required this.index,
    required this.isFirst,
    required this.isLast,
    required this.onEdit,
    required this.onSetMain,
    required this.onDelete,
  });

  final PackConfiguration config;
  final int index;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback? onSetMain;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pack = config.packType;
    final complete =
        config.pool.any((entry) => entry.isEnabled) &&
        config.slotRules.length == pack.cardCount &&
        config.slotRules
            .where((rule) => rule.probabilityGroupId != null)
            .every(
              (rule) => config.probabilities.any(
                (probability) =>
                    probability.probabilityGroupId == rule.probabilityGroupId,
              ),
            );

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: ListTile(
        onTap: onEdit,
        leading: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_handle),
        ),
        title: Text(pack.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          '${l10n.cardsPerPack}: ${pack.cardCount} · '
          '${l10n.maxAccumulated}: ${pack.maxAccumulated}\n'
          '${pack.isMain ? l10n.mainPack : l10n.packSecondary} · '
          '${complete ? l10n.packConfigurationValid : l10n.packConfigurationIncomplete}',
        ),
        trailing: PopupMenuButton<_PackAction>(
          onSelected: (action) {
            switch (action) {
              case _PackAction.edit:
                onEdit();
              case _PackAction.main:
                onSetMain?.call();
              case _PackAction.delete:
                onDelete();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(value: _PackAction.edit, child: Text(l10n.editPack)),
            if (onSetMain != null)
              PopupMenuItem(
                value: _PackAction.main,
                child: Text(l10n.mainPack),
              ),
            PopupMenuItem(
              value: _PackAction.delete,
              child: Text(l10n.deletePack),
            ),
          ],
        ),
        isThreeLine: true,
        dense: false,
        selected: pack.isMain,
        selectedTileColor: Theme.of(context).colorScheme.secondaryContainer,
        minLeadingWidth: 32,
        titleTextStyle: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingSm,
        ),
        visualDensity: VisualDensity.standard,
        enabled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        horizontalTitleGap: AppConstants.spacingSm,
        tileColor: complete
            ? null
            : Theme.of(context).colorScheme.errorContainer,
      ),
    );
  }
}

enum _PackAction { edit, main, delete }

class _CardGridItem extends StatelessWidget {
  const _CardGridItem({
    required this.details,
    required this.rarityName,
    required this.onEdit,
    required this.onDelete,
  });

  final ImageCardDetails details;
  final String rarityName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final thumbnail = details.thumbnailAsset ?? details.mediaAsset;

    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      child: Stack(
        children: [
          Positioned.fill(
            child: GachadexCard(
              name: details.card.name,
              health: details.card.health,
              description: details.card.description ?? '',
              rarityName: rarityName,
              rarityColorValue: details.rarity.colorValue,
              rarityEffectId: details.rarity.effectId,
              mediaType: details.card.mediaType,
              compact: true,
              media: StoredMediaImage(path: thumbnail.relativePath),
              showVideoIndicator: details.card.mediaType.name == 'video',
            ),
          ),
          Positioned(
            right: AppConstants.spacingXs,
            top: AppConstants.spacingXs,
            child: Material(
              color: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.86),
              borderRadius: BorderRadius.circular(999),
              child: PopupMenuButton<_CardMenuAction>(
                tooltip: l10n.cards,
                onSelected: (action) {
                  switch (action) {
                    case _CardMenuAction.edit:
                      onEdit();
                    case _CardMenuAction.delete:
                      onDelete();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: _CardMenuAction.edit,
                    child: Text(l10n.editCard),
                  ),
                  PopupMenuItem(
                    value: _CardMenuAction.delete,
                    child: Text(l10n.deleteCard),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: AppConstants.spacingXs,
            bottom: AppConstants.spacingXs,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surface.withValues(alpha: 0.88),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingSm,
                  vertical: AppConstants.spacingXs,
                ),
                child: Text(
                  '#${details.card.collectionNumber}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _CardMenuAction { edit, delete }

class _RarityListItem extends StatelessWidget {
  const _RarityListItem({
    super.key,
    required this.rarity,
    required this.index,
    required this.isFirst,
    required this.isLast,
    required this.onEdit,
    required this.onDelete,
    required this.onMoveUp,
    required this.onMoveDown,
  });

  final Rarity rarity;
  final int index;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingSm),
        child: Column(
          children: [
            RarityPreview(rarity: rarity, compact: true),
            const SizedBox(height: AppConstants.spacingSm),
            Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Tooltip(
                    message: l10n.order,
                    child: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.drag_handle),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: l10n.moveUp,
                  onPressed: isFirst ? null : onMoveUp,
                  icon: const Icon(Icons.keyboard_arrow_up),
                ),
                IconButton(
                  tooltip: l10n.moveDown,
                  onPressed: isLast ? null : onMoveDown,
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
                const Spacer(),
                IconButton(
                  tooltip: l10n.editRarity,
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: l10n.deleteRarity,
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RarityProbabilitySummary extends StatelessWidget {
  const _RarityProbabilitySummary({required this.total});

  final int total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isComplete = total == 100;
    final statusText = total < 100
        ? context.l10n.rarityProbabilityMissing(100 - total)
        : total > 100
        ? context.l10n.rarityProbabilityExcess(total - 100)
        : context.l10n.rarityProbabilityComplete;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isComplete
            ? colorScheme.primaryContainer
            : colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Row(
          children: [
            Icon(
              isComplete ? Icons.check_circle_outline : Icons.error_outline,
              color: isComplete
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onErrorContainer,
            ),
            const SizedBox(width: AppConstants.spacingSm),
            Expanded(
              child: Text(
                '${context.l10n.rarityProbabilityTotal(total)}. $statusText',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isComplete
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

int _rarityProbabilityTotal(List<Rarity> rarities) {
  return rarities
      .where((rarity) => rarity.isEnabled)
      .fold(0, (sum, rarity) => sum + rarity.probabilityWeight);
}

class _OptionTitle extends StatelessWidget {
  const _OptionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

Future<void> _confirmDeleteDraft(
  BuildContext context,
  WidgetRef ref,
  CollectionDraftEditorState state,
) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteDraftDialogTitle),
      content: Text(l10n.deleteDraftDialogDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.delete_outline),
          label: Text(l10n.delete),
        ),
      ],
    ),
  );

  if (confirmed != true) {
    return;
  }

  await ref
      .read(collectionDraftControllerProvider(state.project.id).notifier)
      .flushPendingSave();
  await ref.read(deleteCollectionDraftProvider).call(state.project.id);

  if (context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.draftDeleted)));
    context.go(AppRoutes.createPath);
  }
}

Future<void> _confirmFinalizeCollection(
  BuildContext context,
  WidgetRef ref,
  CollectionDraftEditorState state,
) async {
  final l10n = context.l10n;
  await ref
      .read(collectionDraftControllerProvider(state.project.id).notifier)
      .flushPendingSave();
  ref.invalidate(collectionFinalizationReportProvider(state.project.id));

  if (!context.mounted) {
    return;
  }

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.finalizeCollection),
      content: Text(l10n.finalizeCollectionDialogDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.check_circle_outline),
          label: Text(l10n.finalizeCollection),
        ),
      ],
    ),
  );

  if (confirmed != true) {
    return;
  }

  try {
    final installed = await ref
        .read(finalizeCollectionProvider)
        .call(state.project.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.collectionFinalized)));
      context.go(AppRoutes.installedCollectionPath(installed.id.value));
    }
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.finalizeCollectionError)));
      ref.invalidate(collectionFinalizationReportProvider(state.project.id));
    }
  }
}

Future<void> _confirmDeleteRarity(
  BuildContext context,
  WidgetRef ref,
  CollectionDraftEditorState state,
  Rarity rarity,
) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteRarityDialogTitle),
      content: Text('${rarity.name}\n\n${l10n.deleteRarityDialogDescription}'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.delete_outline),
          label: Text(l10n.delete),
        ),
      ],
    ),
  );

  if (confirmed != true) {
    return;
  }

  try {
    await ref
        .read(deleteRarityProvider)
        .call(projectId: state.project.id, rarityId: rarity.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.rarityDeleted)));
    }
  } on ReferentialIntegrityFailure {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.rarityInUse)));
    }
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }
}

Future<void> _confirmDeleteCard(
  BuildContext context,
  WidgetRef ref,
  CollectionDraftEditorState state,
  ImageCardDetails details,
) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deleteCard),
      content: Text(l10n.deleteCardDialogDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.delete_outline),
          label: Text(l10n.delete),
        ),
      ],
    ),
  );

  if (confirmed != true) {
    return;
  }

  try {
    await ref
        .read(deleteImageCardProvider)
        .call(projectId: state.project.id, cardId: details.card.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.cardDeleted)));
    }
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }
}

Future<void> _confirmDeletePack(
  BuildContext context,
  WidgetRef ref,
  PackConfiguration config,
) async {
  final l10n = context.l10n;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(l10n.deletePack),
      content: Text('${config.packType.name}\n\n${l10n.deletePackDescription}'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(true),
          icon: const Icon(Icons.delete_outline),
          label: Text(l10n.delete),
        ),
      ],
    ),
  );

  if (confirmed != true) {
    return;
  }

  try {
    await ref.read(packEditorUseCasesProvider).delete(config.packType.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.packDeleted)));
    }
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }
}

Future<void> _showRarityForm(
  BuildContext context,
  WidgetRef ref,
  CollectionDraftEditorState state, [
  Rarity? rarity,
]) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => _RarityFormSheet(state: state, rarity: rarity),
  );
}

class _RarityFormSheet extends ConsumerStatefulWidget {
  const _RarityFormSheet({required this.state, this.rarity});

  final CollectionDraftEditorState state;
  final Rarity? rarity;

  @override
  ConsumerState<_RarityFormSheet> createState() => _RarityFormSheetState();
}

class _RarityFormSheetState extends ConsumerState<_RarityFormSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _sellValueController;
  late final TextEditingController _probabilityController;
  late int _colorValue;
  late String _iconId;
  late String _frameId;
  late String _effectId;
  late bool _isEnabled;
  bool _submitted = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final input = widget.rarity == null
        ? RarityInput.defaults()
        : RarityInput(
            name: widget.rarity!.name,
            colorValue: widget.rarity!.colorValue,
            iconId: widget.rarity!.iconId,
            frameId: widget.rarity!.frameId,
            effectId:
                widget.rarity!.effectId ?? RarityVisualCatalog.defaultEffectId,
            sellValue: widget.rarity!.sellValue,
            probabilityWeight: widget.rarity!.probabilityWeight,
            isEnabled: widget.rarity!.isEnabled,
          );
    _nameController = TextEditingController(text: input.name);
    _sellValueController = TextEditingController(
      text: input.sellValue.toString(),
    );
    _probabilityController = TextEditingController(
      text: input.probabilityWeight.toString(),
    );
    _colorValue = input.colorValue;
    _iconId = input.iconId;
    _frameId = input.frameId;
    _effectId = input.effectId;
    _isEnabled = input.isEnabled;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sellValueController.dispose();
    _probabilityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    final sellValue = int.tryParse(_sellValueController.text.trim());
    final probabilityWeight = int.tryParse(_probabilityController.text.trim());
    final input = RarityInput(
      name: _nameController.text,
      colorValue: _colorValue,
      iconId: _iconId,
      frameId: _frameId,
      effectId: _effectId,
      sellValue: sellValue ?? -1,
      probabilityWeight: probabilityWeight ?? -1,
      isEnabled: _isEnabled,
    );
    final duplicate = _hasDuplicateName(input.name);
    final validation = RarityValidation.validate(
      name: input.name,
      isDuplicateName: duplicate,
      colorValue: input.colorValue,
      iconId: input.iconId,
      frameId: input.frameId,
      effectId: input.effectId,
      sellValue: input.sellValue,
      probabilityWeight: input.probabilityWeight,
    );
    final showErrors = _submitted;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: SingleChildScrollView(
          padding: AppConstants.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.rarity == null ? l10n.addRarity : l10n.editRarity,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              RarityPreview(rarity: _previewRarity(l10n, input), compact: true),
              const SizedBox(height: AppConstants.spacingMd),
              TextFormField(
                controller: _nameController,
                maxLength: RarityVisualCatalog.maxNameLength,
                decoration: InputDecoration(
                  labelText: l10n.name,
                  errorText: showErrors
                      ? _rarityNameError(l10n, validation)
                      : null,
                ),
                buildCounter: _buildCounter,
                textInputAction: TextInputAction.next,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              TextFormField(
                controller: _sellValueController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.sellValue,
                  errorText:
                      showErrors &&
                          (validation.issues.contains(
                                RarityValidationIssue.negativeSellValue,
                              ) ||
                              validation.issues.contains(
                                RarityValidationIssue.sellValueTooHigh,
                              ))
                      ? l10n.sellValueInvalid
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              TextFormField(
                controller: _probabilityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.appearanceProbability,
                  suffixText: '%',
                  errorText:
                      showErrors &&
                          (validation.issues.contains(
                                RarityValidationIssue.negativeProbabilityWeight,
                              ) ||
                              validation.issues.contains(
                                RarityValidationIssue.probabilityWeightTooHigh,
                              ))
                      ? l10n.probabilityWeightInvalid
                      : null,
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _OptionTitle(label: l10n.color),
              Wrap(
                spacing: AppConstants.spacingSm,
                runSpacing: AppConstants.spacingSm,
                children: [
                  for (final option in RarityVisualCatalog.colors)
                    ChoiceChip(
                      avatar: CircleAvatar(
                        backgroundColor: Color(option.colorValue),
                      ),
                      label: Text(rarityColorLabel(l10n, option.id)),
                      selected: _colorValue == option.colorValue,
                      onSelected: (_) {
                        setState(() => _colorValue = option.colorValue);
                      },
                    ),
                ],
              ),
              const SizedBox(height: AppConstants.spacingLg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(l10n.cancel),
                  ),
                  const SizedBox(width: AppConstants.spacingSm),
                  FilledButton.icon(
                    onPressed: _saving ? null : () => _save(input, validation),
                    icon: _saving
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.save_outlined),
                    label: Text(l10n.save),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildCounter(
    BuildContext context, {
    required int currentLength,
    required bool isFocused,
    required int? maxLength,
  }) {
    final max = maxLength;
    if (max == null) {
      return null;
    }

    return Text(context.l10n.charactersCounter(currentLength, max));
  }

  String? _rarityNameError(
    AppLocalizations l10n,
    RarityValidationResult validation,
  ) {
    if (validation.issues.contains(RarityValidationIssue.emptyName)) {
      return l10n.rarityNameRequired;
    }
    if (validation.issues.contains(RarityValidationIssue.nameTooLong)) {
      return l10n.fieldTooLong;
    }
    if (validation.issues.contains(RarityValidationIssue.duplicateName)) {
      return l10n.duplicateRarityName;
    }

    return null;
  }

  bool _hasDuplicateName(String name) {
    final normalized = RarityValidation.normalizedName(name);
    return widget.state.rarities.any((rarity) {
      if (widget.rarity != null && rarity.id == widget.rarity!.id) {
        return false;
      }

      return RarityValidation.normalizedName(rarity.name) == normalized;
    });
  }

  Rarity _previewRarity(AppLocalizations l10n, RarityInput input) {
    final name = input.name.trim().isEmpty ? l10n.name : input.name;
    final sellValue = input.sellValue < 0 ? 0 : input.sellValue;
    final probabilityWeight = input.probabilityWeight < 0
        ? 0
        : input.probabilityWeight;
    final contentVersionId = widget.state.project.currentContentVersionId;

    return Rarity(
      id: widget.rarity?.id ?? RarityId('00000000-0000-4000-8000-000000000001'),
      collectionId: widget.state.project.collectionId,
      contentVersionId:
          contentVersionId ??
          ContentVersionId('00000000-0000-4000-8000-000000000002'),
      name: name,
      orderIndex: widget.rarity?.orderIndex ?? widget.state.rarities.length,
      colorValue: input.colorValue,
      iconId: input.iconId,
      frameId: input.frameId,
      effectId: input.effectId,
      sellValue: sellValue,
      probabilityWeight: probabilityWeight,
      isEnabled: input.isEnabled,
    );
  }

  Future<void> _save(
    RarityInput input,
    RarityValidationResult validation,
  ) async {
    setState(() => _submitted = true);
    if (!validation.canSave) {
      return;
    }

    final contentVersionId = widget.state.project.currentContentVersionId;
    if (contentVersionId == null) {
      return;
    }

    setState(() => _saving = true);
    try {
      if (widget.rarity == null) {
        await ref
            .read(createRarityProvider)
            .call(
              projectId: widget.state.project.id,
              collectionId: widget.state.project.collectionId,
              contentVersionId: contentVersionId,
              input: input,
            );
      } else {
        await ref
            .read(updateRarityProvider)
            .call(
              projectId: widget.state.project.id,
              rarityId: widget.rarity!.id,
              input: input,
            );
      }

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.raritySaved)));
        Navigator.of(context).pop();
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
}
