import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/localization/app_localizations.dart';
import '../../../app/router/app_routes.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/widgets/app_error_view.dart';

class ControlledErrorPage extends StatelessWidget {
  const ControlledErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final failure = ErrorMapper.toFailure(
      AppException(
        code: 'controlled_error',
        safeMessage: l10n.controlledErrorDescription,
      ),
      fallbackMessage: l10n.screenErrorTitle,
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.controlledError)),
      body: SafeArea(
        child: AppErrorView(
          title: l10n.screenErrorTitle,
          description: failure.safeMessage,
          onRetry: () => context.goNamed(AppRoutes.homeName),
        ),
      ),
    );
  }
}
