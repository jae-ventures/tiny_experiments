import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/dashboard_providers.dart';

// ── Public sheet widget ───────────────────────────────────────────────────────

/// Modal bottom sheet opened by the ≡ action button.
///
/// Provides access to all secondary navigation destinations:
///   - Curiosity Backlog (Epic 6)
///   - Pause Drawer (Epic 4)
///   - Archive (Epic 5)
///   - Settings
///
/// The Pause Drawer item shows a badge count when paused PACTs exist, so the
/// user knows something is waiting without having to navigate there first.
///
/// Spec ref: 03_ui_spec_dashboard.md §5
class ActionBottomSheet extends ConsumerWidget {
  const ActionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pausedCount =
        ref.watch(pausedPactCountProvider).asData?.value ?? 0;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DragHandle(),
          const SizedBox(height: 4),
          // ── Navigation items ───────────────────────────────────────────────
          _NavItem(
            icon: Icons.explore_rounded,
            label: 'Curiosity Backlog',
            // Stub screen — full implementation in Epic 6.
            onTap: () => _navigate(context, AppRoutes.backlog),
          ),
          _NavItem(
            icon: Icons.pause_circle_outline_rounded,
            label: 'Pause Drawer',
            badgeCount: pausedCount > 0 ? pausedCount : null,
            // Stub screen — full implementation in Epic 4.
            onTap: () => _navigate(context, AppRoutes.pauseDrawer),
          ),
          _NavItem(
            icon: Icons.inventory_2_outlined,
            label: 'Archive',
            // Stub screen — full implementation in Epic 5.
            onTap: () => _navigate(context, AppRoutes.archive),
          ),
          _NavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            onTap: () => _navigate(context, AppRoutes.settings),
          ),
          // Bottom safe-area padding so items aren't obscured on notched devices.
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12),
        ],
      ),
    );
  }

  /// Dismisses the sheet first, then pushes the route. The two calls are
  /// synchronous frame-ops so no timing gap is visible to the user.
  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop();
    context.push(route);
  }
}

// ── Drag handle ───────────────────────────────────────────────────────────────

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Container(
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.outline,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

// ── Nav item ──────────────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int? badgeCount;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: [
            // Leading icon
            Icon(icon, color: AppColors.onSurface, size: 22),
            const SizedBox(width: 16),
            // Label
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.onBackground,
                    ),
              ),
            ),
            // Paused-PACT badge (Pause Drawer only)
            if (badgeCount != null) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  '$badgeCount',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            // Trailing chevron
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.onSurfaceDim,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
