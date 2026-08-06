import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/files/stored_media_image.dart';
import '../../../../core/identifiers/entity_id.dart';
import '../../../collection_creator/presentation/controllers/collection_draft_controller.dart';
import '../../../rarities/domain/entities/rarity.dart';
import '../../../rarities/presentation/widgets/rarity_preview.dart';
import '../../application/card_photo_processor.dart';
import '../../application/card_providers.dart';
import '../../application/card_use_cases.dart';
import '../../domain/catalogs/card_template_catalog.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/validation/card_validation.dart';
import '../../domain/value_objects/card_field_type.dart';

class CardEditorPage extends ConsumerStatefulWidget {
  const CardEditorPage({super.key, required this.projectId, this.cardId});

  final CollectionProjectId projectId;
  final CardId? cardId;

  @override
  ConsumerState<CardEditorPage> createState() => _CardEditorPageState();
}

class _CardEditorPageState extends ConsumerState<CardEditorPage> {
  final _nameController = TextEditingController();
  final _healthController = TextEditingController(text: '100');
  final _numberController = TextEditingController(text: '1');
  final _descriptionController = TextEditingController();
  final _comicFields = <_EditableComicField>[];

  RarityId? _rarityId;
  String _templateId = CardTemplateCatalog.defaultTemplateId;
  String _frameId = CardTemplateCatalog.defaultFrameId;
  int _primaryColor = CardTemplateCatalog.defaultPrimaryColor;
  int _secondaryColor = CardTemplateCatalog.defaultSecondaryColor;
  PendingCardPhoto? _pendingPhoto;
  bool _initialized = false;
  bool _dirty = false;
  bool _processingPhoto = false;
  bool _saving = false;
  bool _submitted = false;
  Object? _error;

  bool get _isEditing => widget.cardId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _healthController.dispose();
    _numberController.dispose();
    _descriptionController.dispose();
    for (final field in _comicFields) {
      field.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draftAsync = ref.watch(
      collectionDraftControllerProvider(widget.projectId),
    );
    final detailsAsync = widget.cardId == null
        ? null
        : ref.watch(imageCardDetailsProvider(widget.cardId!));

    final l10n = context.l10n;
    final canPop = !_dirty || _saving || _processingPhoto;

    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          await _confirmLeave();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? l10n.editCard : l10n.addCard),
          leading: IconButton(
            tooltip: l10n.backToDraft,
            onPressed: _saving || _processingPhoto ? null : _confirmLeave,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: draftAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => _ErrorBody(error: error),
            data: (draft) {
              if (detailsAsync == null) {
                _initializeForCreate(draft.rarities);
                return _FormBody(child: _buildForm(context, draft, null));
              }

              return detailsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => _ErrorBody(error: error),
                data: (details) {
                  _initializeForEdit(details);
                  return _FormBody(child: _buildForm(context, draft, details));
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    CollectionDraftEditorState draft,
    ImageCardDetails? details,
  ) {
    final l10n = context.l10n;
    final health = int.tryParse(_healthController.text.trim());
    final number = int.tryParse(_numberController.text.trim());
    final validation = CardValidation.validate(
      hasPhoto: _pendingPhoto != null || details != null,
      name: _nameController.text,
      health: health,
      collectionNumber: number,
      isDuplicateCollectionNumber: false,
      rarityId: _rarityId?.value,
      templateId: _templateId,
      frameId: _frameId,
      description: _descriptionController.text,
      comicFields: _comicInputs(),
    );
    final canSave = validation.canSave && !_saving && !_processingPhoto;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_error != null) ...[
          Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spacingMd),
              child: Text(_errorMessage(l10n, _error!)),
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
        ],
        _SectionTitle(l10n.photo),
        _PhotoPicker(
          pendingPhoto: _pendingPhoto,
          existing: details,
          processing: _processingPhoto,
          submitted: _submitted,
          onPick: () => _pickPhoto(),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _SectionTitle(l10n.mainData),
        TextFormField(
          controller: _nameController,
          maxLength: CardTemplateCatalog.maxNameLength,
          decoration: InputDecoration(
            labelText: l10n.name,
            errorText:
                _submitted && validation.has(CardValidationIssue.emptyName)
                ? l10n.cardNameRequired
                : null,
          ),
          buildCounter: _buildCounter,
          textInputAction: TextInputAction.next,
          onChanged: (_) => _markDirty(),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        TextFormField(
          controller: _healthController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.health,
            errorText:
                _submitted && validation.has(CardValidationIssue.invalidHealth)
                ? l10n.healthInvalid
                : null,
          ),
          onChanged: (_) => _markDirty(),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        TextFormField(
          controller: _numberController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            labelText: l10n.collectionNumber,
            errorText:
                _submitted &&
                    validation.has(CardValidationIssue.invalidCollectionNumber)
                ? l10n.collectionNumberInvalid
                : null,
          ),
          onChanged: (_) => _markDirty(),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        DropdownButtonFormField<RarityId>(
          initialValue: _rarityId,
          decoration: InputDecoration(
            labelText: l10n.rarity,
            errorText:
                _submitted && validation.has(CardValidationIssue.rarityRequired)
                ? l10n.rarityRequired
                : null,
          ),
          items: [
            for (final rarity in draft.rarities)
              DropdownMenuItem(value: rarity.id, child: Text(rarity.name)),
          ],
          onChanged: (value) {
            setState(() {
              _rarityId = value;
              _dirty = true;
            });
          },
        ),
        const SizedBox(height: AppConstants.spacingSm),
        TextFormField(
          controller: _descriptionController,
          maxLength: CardTemplateCatalog.maxDescriptionLength,
          minLines: 2,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: l10n.description,
            errorText:
                _submitted &&
                    validation.has(CardValidationIssue.descriptionTooLong)
                ? l10n.fieldTooLong
                : null,
          ),
          buildCounter: _buildCounter,
          onChanged: (_) => _markDirty(),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _SectionTitle(l10n.appearance),
        _ChoiceWrap(
          label: l10n.template,
          children: [
            for (final template in CardTemplateCatalog.templates)
              ChoiceChip(
                label: Text(template.name),
                selected: _templateId == template.id,
                onSelected: (_) => setState(() {
                  _templateId = template.id;
                  _dirty = true;
                }),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _ChoiceWrap(
          label: l10n.frame,
          children: [
            for (final frame in CardTemplateCatalog.frames)
              ChoiceChip(
                label: Text(frame.name),
                selected: _frameId == frame.id,
                onSelected: (_) => setState(() {
                  _frameId = frame.id;
                  _dirty = true;
                }),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _ColorSelector(
          label: l10n.primaryColor,
          value: _primaryColor,
          onChanged: (value) => setState(() {
            _primaryColor = value;
            _dirty = true;
          }),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        _ColorSelector(
          label: l10n.accentColor,
          value: _secondaryColor,
          onChanged: (value) => setState(() {
            _secondaryColor = value;
            _dirty = true;
          }),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _SectionTitle(l10n.comicFields),
        _ComicFieldEditor(
          fields: _comicFields,
          template: CardTemplateCatalog.templateById(_templateId),
          onChanged: () => setState(() => _dirty = true),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        _SectionTitle(l10n.preview),
        Center(
          child: _CardPreview(
            pendingPhoto: _pendingPhoto,
            existing: details,
            rarity: _rarityFor(draft.rarities),
            templateId: _templateId,
            frameId: _frameId,
            primaryColor: _primaryColor,
            secondaryColor: _secondaryColor,
            name: _nameController.text,
            health: health,
            collectionNumber: number,
            description: _descriptionController.text,
            fields: _comicInputs(),
          ),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: canSave ? () => _save(draft, details) : null,
            icon: _saving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(_saving ? l10n.saving : l10n.save),
          ),
        ),
      ],
    );
  }

  void _initializeForCreate(List<Rarity> rarities) {
    if (_initialized) {
      return;
    }
    _rarityId = rarities.isEmpty ? null : rarities.first.id;
    _initialized = true;
  }

  void _initializeForEdit(ImageCardDetails details) {
    if (_initialized) {
      return;
    }
    _nameController.text = details.card.name;
    _healthController.text = details.card.health.toString();
    _numberController.text = details.card.collectionNumber.toString();
    _descriptionController.text = details.card.description ?? '';
    _rarityId = details.card.rarityId;
    _templateId = details.card.templateId;
    _frameId = details.card.frameId;
    _primaryColor = details.card.primaryColor;
    _secondaryColor = details.card.secondaryColor;
    _comicFields
      ..clear()
      ..addAll(
        details.fields.map(
          (field) =>
              _EditableComicField(type: field.fieldType, value: field.value),
        ),
      );
    _initialized = true;
  }

  Future<void> _pickPhoto() async {
    setState(() {
      _processingPhoto = true;
      _error = null;
    });
    try {
      final photo = await ref
          .read(cardPhotoProcessorProvider)
          .pickFromGallery(
            template: CardTemplateCatalog.templateById(_templateId),
            context: context,
          );
      if (photo != null && mounted) {
        setState(() {
          _pendingPhoto = photo;
          _dirty = true;
        });
      }
    } on Object catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
    } finally {
      if (mounted) {
        setState(() => _processingPhoto = false);
      }
    }
  }

  Future<void> _save(
    CollectionDraftEditorState draft,
    ImageCardDetails? details,
  ) async {
    setState(() {
      _submitted = true;
      _error = null;
    });
    final contentVersionId = draft.project.currentContentVersionId;
    final rarityId = _rarityId;
    final health = int.tryParse(_healthController.text.trim());
    final number = int.tryParse(_numberController.text.trim());
    if (contentVersionId == null ||
        rarityId == null ||
        health == null ||
        number == null) {
      return;
    }

    setState(() => _saving = true);
    try {
      await ref
          .read(collectionDraftControllerProvider(widget.projectId).notifier)
          .flushPendingSave();
      final input = ImageCardInput(
        collectionNumber: number,
        name: _nameController.text,
        health: health,
        rarityId: rarityId,
        templateId: _templateId,
        frameId: _frameId,
        primaryColor: _primaryColor,
        secondaryColor: _secondaryColor,
        description: _descriptionController.text,
        comicFields: _comicInputs(),
        photo: _pendingPhoto,
      );
      if (details == null) {
        await ref
            .read(createImageCardProvider)
            .call(
              projectId: widget.projectId,
              collectionId: draft.project.collectionId,
              contentVersionId: contentVersionId,
              input: input,
            );
      } else {
        await ref
            .read(updateImageCardProvider)
            .call(
              projectId: widget.projectId,
              cardId: details.card.id,
              input: input,
            );
      }

      if (mounted) {
        setState(() => _dirty = false);
        context.go(AppRoutes.createProjectPath(widget.projectId.value));
      }
    } on Object catch (error) {
      if (mounted) {
        setState(() => _error = error);
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _confirmLeave() async {
    if (!_dirty) {
      context.go(AppRoutes.createProjectPath(widget.projectId.value));
      return;
    }

    final l10n = context.l10n;
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.unsavedChanges),
        content: Text(l10n.discardChangesQuestion),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.discardChanges),
          ),
        ],
      ),
    );
    if (discard == true && mounted) {
      context.go(AppRoutes.createProjectPath(widget.projectId.value));
    }
  }

  List<ComicFieldInput> _comicInputs() {
    return [
      for (final field in _comicFields)
        if (field.controller.text.trim().isNotEmpty)
          ComicFieldInput(type: field.type, value: field.controller.text),
    ];
  }

  Rarity? _rarityFor(List<Rarity> rarities) {
    final rarityId = _rarityId;
    if (rarityId == null) {
      return null;
    }

    for (final rarity in rarities) {
      if (rarity.id == rarityId) {
        return rarity;
      }
    }
    return null;
  }

  void _markDirty() {
    setState(() => _dirty = true);
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

  String _errorMessage(AppLocalizations l10n, Object error) {
    if (error is InvalidEntityFailure) {
      if (error.safeMessage.contains('valida')) {
        return l10n.cardInvalid;
      }
      return error.safeMessage;
    }
    if (error is DuplicateEntityFailure) {
      return l10n.collectionNumberUsed;
    }
    if (error is AppFailure) {
      return error.safeMessage;
    }
    return l10n.saveError;
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppConstants.pagePadding,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: child,
          ),
        ),
      ],
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: AppConstants.pagePadding,
        child: Text(
          error is AppFailure
              ? (error as AppFailure).safeMessage
              : l10n.screenErrorTitle,
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({
    required this.pendingPhoto,
    required this.existing,
    required this.processing,
    required this.submitted,
    required this.onPick,
  });

  final PendingCardPhoto? pendingPhoto;
  final ImageCardDetails? existing;
  final bool processing;
  final bool submitted;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasPhoto = pendingPhoto != null || existing != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: CardTemplateCatalog.templateById(
            existing?.card.templateId ?? CardTemplateCatalog.defaultTemplateId,
          ).aspectRatio,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              child: pendingPhoto != null
                  ? Image.file(File(pendingPhoto!.imagePath), fit: BoxFit.cover)
                  : existing == null
                  ? Center(child: Icon(Icons.photo_library_outlined, size: 48))
                  : StoredMediaImage(path: existing!.mediaAsset.relativePath),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        FilledButton.icon(
          onPressed: processing ? null : onPick,
          icon: processing
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.photo_library_outlined),
          label: Text(
            processing
                ? l10n.processingImage
                : hasPhoto
                ? l10n.changePhoto
                : l10n.selectPhoto,
          ),
        ),
        if (submitted && !hasPhoto) ...[
          const SizedBox(height: AppConstants.spacingXs),
          Text(
            l10n.photoRequired,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ],
    );
  }
}

class _ChoiceWrap extends StatelessWidget {
  const _ChoiceWrap({required this.label, required this.children});

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: AppConstants.spacingSm),
        Wrap(
          spacing: AppConstants.spacingSm,
          runSpacing: AppConstants.spacingSm,
          children: children,
        ),
      ],
    );
  }
}

class _ColorSelector extends StatelessWidget {
  const _ColorSelector({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return _ChoiceWrap(
      label: label,
      children: [
        for (final option in CardTemplateCatalog.colors)
          ChoiceChip(
            avatar: CircleAvatar(backgroundColor: Color(option.value)),
            label: Text(option.id),
            selected: value == option.value,
            onSelected: (_) => onChanged(option.value),
          ),
      ],
    );
  }
}

class _EditableComicField {
  _EditableComicField({required this.type, required String value})
    : controller = TextEditingController(text: value);

  CardFieldType type;
  final TextEditingController controller;

  void dispose() => controller.dispose();
}

class _ComicFieldEditor extends StatefulWidget {
  const _ComicFieldEditor({
    required this.fields,
    required this.template,
    required this.onChanged,
  });

  final List<_EditableComicField> fields;
  final CardTemplate template;
  final VoidCallback onChanged;

  @override
  State<_ComicFieldEditor> createState() => _ComicFieldEditorState();
}

class _ComicFieldEditorState extends State<_ComicFieldEditor> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final available = CardTemplateCatalog.fieldOptions.where((option) {
      return !widget.fields.any((field) => field.type == option.type);
    }).toList();

    return Column(
      children: [
        for (var index = 0; index < widget.fields.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<CardFieldType>(
                    initialValue: widget.fields[index].type,
                    items: [
                      for (final option in CardTemplateCatalog.fieldOptions)
                        DropdownMenuItem(
                          value: option.type,
                          child: Text(option.label),
                        ),
                    ],
                    onChanged: (value) {
                      if (value == null ||
                          widget.fields.any((field) => field.type == value)) {
                        return;
                      }
                      setState(() => widget.fields[index].type = value);
                      widget.onChanged();
                    },
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: widget.fields[index].controller,
                    maxLength: widget.template.maxComicFieldLength,
                    decoration: InputDecoration(labelText: l10n.value),
                    onChanged: (_) => widget.onChanged(),
                  ),
                ),
                IconButton(
                  tooltip: l10n.moveUp,
                  onPressed: index == 0 ? null : () => _move(index, -1),
                  icon: const Icon(Icons.keyboard_arrow_up),
                ),
                IconButton(
                  tooltip: l10n.delete,
                  onPressed: () {
                    final removed = widget.fields.removeAt(index);
                    removed.dispose();
                    setState(() {});
                    widget.onChanged();
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed:
                widget.fields.length >= widget.template.maxComicFields ||
                    available.isEmpty
                ? null
                : () {
                    widget.fields.add(
                      _EditableComicField(
                        type: available.first.type,
                        value: '',
                      ),
                    );
                    setState(() {});
                    widget.onChanged();
                  },
            icon: const Icon(Icons.add),
            label: Text(l10n.addComicField),
          ),
        ),
      ],
    );
  }

  void _move(int index, int direction) {
    final target = index + direction;
    if (target < 0 || target >= widget.fields.length) {
      return;
    }
    final item = widget.fields.removeAt(index);
    widget.fields.insert(target, item);
    setState(() {});
    widget.onChanged();
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({
    required this.pendingPhoto,
    required this.existing,
    required this.rarity,
    required this.templateId,
    required this.frameId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.name,
    required this.health,
    required this.collectionNumber,
    required this.description,
    required this.fields,
  });

  final PendingCardPhoto? pendingPhoto;
  final ImageCardDetails? existing;
  final Rarity? rarity;
  final String templateId;
  final String frameId;
  final int primaryColor;
  final int secondaryColor;
  final String name;
  final int? health;
  final int? collectionNumber;
  final String description;
  final List<ComicFieldInput> fields;

  @override
  Widget build(BuildContext context) {
    final template = CardTemplateCatalog.templateById(templateId);
    final rarityColor = rarity == null
        ? Theme.of(context).colorScheme.outline
        : Color(rarity!.colorValue);
    final radius = frameId == 'snapshot' ? 2.0 : AppConstants.cardRadius;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: AspectRatio(
        aspectRatio: template.aspectRatio,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(primaryColor),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: rarityColor,
              width: frameId == 'badge' ? 5 : 3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name.trim().isEmpty ? context.l10n.name : name.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                    Text(
                      '${health ?? 0} HP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  flex: templateId == 'impact' ? 7 : 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppConstants.cardRadius,
                    ),
                    child: ColoredBox(
                      color: Colors.white.withValues(alpha: 0.16),
                      child: pendingPhoto != null
                          ? Image.file(
                              File(pendingPhoto!.imagePath),
                              fit: BoxFit.cover,
                            )
                          : existing == null
                          ? const Icon(
                              Icons.photo_outlined,
                              color: Colors.white,
                            )
                          : StoredMediaImage(
                              path: existing!.mediaAsset.relativePath,
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(secondaryColor),
                    borderRadius: BorderRadius.circular(
                      AppConstants.cardRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          rarity == null
                              ? Icons.auto_awesome_outlined
                              : rarityIconForId(rarity!.iconId),
                          color: Colors.black87,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            rarity?.name ?? context.l10n.rarity,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ),
                        Text(
                          '#${collectionNumber ?? 0}',
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
                if (description.trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    description.trim(),
                    maxLines: templateId == 'minimal' ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
                const SizedBox(height: 6),
                for (final field in fields.take(template.maxComicFields))
                  Text(
                    '${CardTemplateCatalog.labelForField(field.type)}: ${field.value.trim()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
