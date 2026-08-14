import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

abstract final class AppTheme {
  static const _seed = Color(0xFF007C6F);
  static const _coral = Color(0xFFB95D4F);
  static const _gold = Color(0xFF8A6D00);

  static ThemeData light() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.light,
        ).copyWith(
          secondary: _coral,
          tertiary: _gold,
          surface: const Color(0xFFFBFCFA),
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: const Color(0xFFF3F7F3),
          surfaceContainer: const Color(0xFFEDF3EF),
          surfaceContainerHigh: const Color(0xFFE7EEE9),
          surfaceContainerHighest: const Color(0xFFE0E9E4),
        );

    return _buildTheme(scheme);
  }

  static ThemeData dark() {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF65DCCA),
          secondary: const Color(0xFFFFB4A8),
          tertiary: const Color(0xFFE9C95C),
          surface: const Color(0xFF0F1513),
          surfaceContainerLowest: const Color(0xFF101614),
          surfaceContainerLow: const Color(0xFF161D1A),
          surfaceContainer: const Color(0xFF1B2420),
          surfaceContainerHigh: const Color(0xFF22302A),
          surfaceContainerHighest: const Color(0xFF293831),
        );

    return _buildTheme(scheme);
  }

  static ThemeData _buildTheme(ColorScheme scheme) {
    final textTheme = Typography.material2021(
      platform: TargetPlatform.android,
    ).black.apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        height: 72,
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.secondaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelMedium?.copyWith(
            color: selected ? scheme.onSecondaryContainer : scheme.onSurface,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.controlRadius),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.controlRadius),
          ),
          side: BorderSide(color: scheme.outline),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.controlRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.controlRadius),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.controlRadius),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        selectedColor: scheme.secondaryContainer,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.controlRadius),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        dividerColor: scheme.outlineVariant,
        indicatorColor: scheme.primary,
        labelColor: scheme.primary,
        unselectedLabelColor: scheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800),
        unselectedLabelStyle: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingXs,
        ),
        iconColor: scheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: scheme.primaryContainer,
          selectedForegroundColor: scheme.onPrimaryContainer,
          side: BorderSide(color: scheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.controlRadius),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onInverseSurface,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.cardRadius),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
