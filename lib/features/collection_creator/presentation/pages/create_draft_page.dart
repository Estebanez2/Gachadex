import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/localization/app_localizations.dart';
import '../../../../app/router/app_routes.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';
import '../controllers/collection_draft_controller.dart';

class CreateDraftPage extends ConsumerStatefulWidget {
  const CreateDraftPage({super.key});

  @override
  ConsumerState<CreateDraftPage> createState() => _CreateDraftPageState();
}

class _CreateDraftPageState extends ConsumerState<CreateDraftPage> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _create();
    });
  }

  Future<void> _create() async {
    final projectId = await ref
        .read(createDraftControllerProvider.notifier)
        .create();
    if (mounted && projectId != null) {
      context.go(AppRoutes.createProjectPath(projectId.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(createDraftControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.createCollection)),
      body: SafeArea(
        child: state.when(
          data: (_) => AppLoadingView(message: l10n.saving),
          loading: () => AppLoadingView(message: l10n.saving),
          error: (error, stackTrace) => AppErrorView(
            title: l10n.screenErrorTitle,
            description: l10n.saveError,
            onRetry: _create,
          ),
        ),
      ),
    );
  }
}
