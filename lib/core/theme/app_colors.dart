import 'package:flutter/material.dart';

/// All color tokens for the app. Widgets should consume these constants
/// (or the theme's ColorScheme) rather than hardcoding hex values.
abstract final class AppColors {
  // ── Canvas ───────────────────────────────────────────────────────────────
  /// Main scaffold/background — near-black with warm undertones, not pure black.
  static const background = Color(0xFF0D0C0A);

  /// Card and bottom-sheet surface.
  static const surface = Color(0xFF1A1814);

  /// Slightly elevated surface (e.g., input fields, selected items).
  static const surfaceVariant = Color(0xFF252018);

  // ── Text ─────────────────────────────────────────────────────────────────
  /// Primary text on dark backgrounds — warm cream.
  static const onBackground = Color(0xFFEDE8DF);

  /// Secondary / subdued text.
  static const onSurface = Color(0xFFB0A898);

  /// Disabled / placeholder text.
  static const onSurfaceDim = Color(0xFF6A6057);

  // ── Borders & dividers ───────────────────────────────────────────────────
  static const outline = Color(0xFF3A3530);
  static const outlineVariant = Color(0xFF2A2520);

  // ── Primary action ───────────────────────────────────────────────────────
  /// Warm amber — used for primary buttons and the first PACT slot color.
  static const primary = Color(0xFFE8A53A);
  static const onPrimary = Color(0xFF1A0F00);

  // ── Semantic ─────────────────────────────────────────────────────────────
  static const error = Color(0xFFCF6679);
  static const onError = Color(0xFF1A0008);
  static const success = Color(0xFF7DB889);

  // ── PACT color palette ───────────────────────────────────────────────────
  /// Curated 4-color palette assigned to PACT slots in order.
  /// Warm, distinct, non-clinical — each feels personal rather than categorical.
  ///
  /// Usage: `AppColors.pactPalette[slotIndex]` (0-based, max index 3).
  static const pactPalette = [
    Color(0xFFE8A53A), // Amber   — warm gold
    Color(0xFFE06858), // Coral   — ember red
    Color(0xFF7DB889), // Sage    — soft green
    Color(0xFFB087C5), // Orchid  — muted violet
  ];

  /// Tinted/dimmed versions of the PACT palette for session color-banding
  /// (resumed sessions shown in a lighter tint of the PACT's color).
  static Color pactTint(int slotIndex) =>
      pactPalette[slotIndex % pactPalette.length].withValues(alpha: 0.45);
}
