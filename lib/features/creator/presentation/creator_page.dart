import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/identifiers/entity_id.dart';
import '../../../core/widgets/app_empty_view.dart';
import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_loading_view.dart';
import '../../collection_creator/application/collection_draft_use_case_providers.dart';
import '../../collection_creator/presentation/controllers/collection_draft_controller.dart';
import '../../collection_creator/presentation/widgets/draft_cover_preview.dart';

class CreatorPage extends ConsumerWidget {
  const CreatorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final summaries = ref.watch(collectionDraftSummariesProvider);

    return summaries.when(
      loading: () => const AppLoadingView(),
      error: (error, stackTrace) => AppErrorView(
        title: l10n.screenErrorTitle,
        description: l10n.saveError,
        onRetry: () => ref.invalidate(collectionDraftSummariesProvider),
      ),
      data: (items) {
        if (items.isEmpty) {
          return AppEmptyView(
            icon: Icons.edit_note_outlined,
            title: l10n.emptyDraftsTitle,
            description: l10n.emptyDraftsDescription,
            action: const _NewDraftButton(),
          );
        }

        return SafeArea(
          child: ListView.separated(
            padding: AppConstants.pagePadding,
            itemCount: items.length + 1,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppConstants.spacingMd),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const _CreatorHeader();
              }

              return _DraftListItem(summary: items[index - 1]);
            },
          ),
        );
      },
    );
  }
}

class _CreatorHeader extends StatelessWidget {
  const _CreatorHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.create,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            l10n.collectionDraftsDescription,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          const _NewDraftButton(),
        ],
      ),
    );
  }
}

class _NewDraftButton extends ConsumerWidget {
  const _NewDraftButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final createState = ref.watch(createDraftControllerProvider);
    final isCreating = createState.isLoading;

    return Tooltip(
      message: l10n.newCollection,
      child: FilledButton.icon(
        onPressed: isCreating
            ? null
            : () async {
                final projectId = await ref
                    .read(createDraftControllerProvider.notifier)
                    .create();
                if (context.mounted && projectId != null) {
                  context.go(AppRoutes.createProjectPath(projectId.value));
                }
              },
        icon: isCreating
            ? const SizedBox.square(
                dimension: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.add),
        label: Text(l10n.newCollection),
      ),
    );
  }
}

class _DraftListItem extends ConsumerWidget {
  const _DraftListItem({required this.summary});

  final CollectionDraftSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final project = summary.project;
    final title = project.name.isEmpty ? l10n.unnamedCollection : project.name;
    final date = DateFormat.yMd(
      'es',
    ).add_Hm().format(project.updatedAtUtc.toLocal());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DraftCoverPreview(
              style: project.draftCoverStyle,
              collectionName: title,
              height: 152,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (project.author != null) ...[
                        const SizedBox(height: AppConstants.spacingXs),
                        Text(project.author!),
                      ],
                    ],
                  ),
                ),
                PopupMenuButton<_DraftAction>(
                  tooltip: l10n.deleteDraft,
                  onSelected: (action) async {
                    if (action == _DraftAction.delete) {
                      await _confirmDeleteDraft(context, ref, project.id);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: _DraftAction.delete,
                      child: Text(l10n.deleteDraft),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Wrap(
              spacing: AppConstants.spacingSm,
              runSpacing: AppConstants.spacingSm,
              children: [
                Chip(label: Text(l10n.draft)),
                Chip(label: Text(l10n.rarityCount(summary.rarityCount))),
                Chip(
                  label: Text(
                    l10n.draftSectionsProgress(
                      summary.completeness.completedRequiredCount,
                      summary.completeness.requiredSectionCount,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingSm),
            Text(
              l10n.lastUpdated(date),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.icon(
                onPressed: () {
                  context.go(AppRoutes.createProjectPath(project.id.value));
                },
                icon: const Icon(Icons.arrow_forward),
                label: Text(l10n.continueEditing),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _DraftAction { delete }

Future<void> _confirmDeleteDraft(
  BuildContext context,
  WidgetRef ref,
  CollectionProjectId projectId,
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

  try {
    await ref.read(deleteCollectionDraftProvider).call(projectId);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.draftDeleted)));
    }
  } on Object {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.saveError)));
    }
  }
}
