import 'package:flutter/widgets.dart';

abstract final class AppConstants {
  static const appName = 'Gachadex';
  static const restorationScopeId = 'gachadex_app';

  static const spacingXs = 4.0;
  static const spacingSm = 8.0;
  static const spacingMd = 16.0;
  static const spacingLg = 24.0;
  static const spacingXl = 32.0;

  static const cardRadius = 8.0;
  static const controlRadius = 8.0;
  static const maxContentWidth = 560.0;

  static const elevationShadowBlur = 18.0;
  static const elevationShadowOffset = Offset(0, 8);

  static const shortAnimationDuration = Duration(milliseconds: 180);
  static const mediumAnimationDuration = Duration(milliseconds: 260);
  static const longAnimationDuration = Duration(milliseconds: 420);

  static const pagePadding = EdgeInsets.all(spacingMd);
}
