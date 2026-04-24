import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  /// The app's single dark theme. A light variant may be added post-MVP.
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: _colorScheme,
        textTheme: _textTheme,
        scaffoldBackgroundColor: AppColors.background,
        cardTheme: _cardTheme,
        appBarTheme: _appBarTheme,
        inputDecorationTheme: _inputDecorationTheme,
        filledButtonTheme: _filledButtonTheme,
        textButtonTheme: _textButtonTheme,
        dividerTheme: const DividerThemeData(
          color: AppColors.outlineVariant,
          space: 1,
          thickness: 1,
        ),
        splashColor: AppColors.primary.withValues(alpha: 0.08),
        highlightColor: AppColors.primary.withValues(alpha: 0.04),
      );

  // ── Color scheme ─────────────────────────────────────────────────────────

  static const _colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: Color(0xFF3A2800),
    onPrimaryContainer: Color(0xFFFFDEA0),
    secondary: Color(0xFFB087C5), // Orchid — used for secondary actions
    onSecondary: Color(0xFF1A0028),
    secondaryContainer: Color(0xFF2A1040),
    onSecondaryContainer: Color(0xFFE8D0F8),
    tertiary: Color(0xFF7DB889),
    onTertiary: Color(0xFF00200A),
    tertiaryContainer: Color(0xFF0A3018),
    onTertiaryContainer: Color(0xFFC0EED0),
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: Color(0xFF400010),
    onErrorContainer: Color(0xFFFFD0DA),
    surface: AppColors.surface,
    onSurface: AppColors.onBackground,
    onSurfaceVariant: AppColors.onSurface,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: AppColors.onBackground,
    onInverseSurface: AppColors.background,
    inversePrimary: Color(0xFF6A4000),
    surfaceTint: AppColors.primary,
  );

  // ── Typography ───────────────────────────────────────────────────────────
  // DM Serif Display for display/headline text — warm, literary, curious.
  // DM Sans for all body/UI text — clean, friendly, highly legible.

  static TextTheme get _textTheme {
    final base = GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme);

    return base.copyWith(
      // Display — PACT names in hero contexts, onboarding headlines
      displayLarge: GoogleFonts.dmSerifDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: AppColors.onBackground,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.dmSerifDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
        height: 1.15,
      ),
      displaySmall: GoogleFonts.dmSerifDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
        height: 1.2,
      ),
      // Headline — section headers, PACT card title
      headlineLarge: GoogleFonts.dmSerifDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.dmSerifDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
        height: 1.28,
      ),
      headlineSmall: GoogleFonts.dmSerifDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.onBackground,
        height: 1.33,
      ),
      // Title — card sub-headers, list item titles
      titleLarge: GoogleFonts.dmSans(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        color: AppColors.onBackground,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: AppColors.onBackground,
        height: 1.5,
      ),
      titleSmall: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.onBackground,
        height: 1.43,
      ),
      // Body — all regular text, note fields, reflection content
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: AppColors.onBackground,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: AppColors.onBackground,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: AppColors.onSurface,
        height: 1.33,
      ),
      // Label — chips, metadata, progress counts
      labelLarge: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: AppColors.onBackground,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.onSurface,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.onSurfaceDim,
        height: 1.45,
      ),
    );
  }

  // ── Component themes ─────────────────────────────────────────────────────

  static const _cardTheme = CardThemeData(
    color: AppColors.surface,
    shadowColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(color: AppColors.outlineVariant),
    ),
  );

  static AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          letterSpacing: 0,
          color: AppColors.onBackground,
        ),
      );

  static const _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceVariant,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.outline),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.outline),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.error),
    ),
    hintStyle: TextStyle(color: AppColors.onSurfaceDim),
    labelStyle: TextStyle(color: AppColors.onSurface),
  );

  static FilledButtonThemeData get _filledButtonTheme => FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size(double.infinity, 52),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      );

  static TextButtonThemeData get _textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
