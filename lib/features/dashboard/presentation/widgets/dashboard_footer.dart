import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/dashboard_providers.dart';
import 'action_bottom_sheet.dart';

/// Bottom region (~10% of screen height).
///
/// Contains a single tappable ≡ (hamburger) button that opens the action
/// bottom sheet — the app's only secondary navigation surface.
///
/// A small indicator dot appears on the button when paused PACTs are waiting,
/// giving the user a passive signal without being intrusive.
///
/// Spec ref: 03_ui_spec_dashboard.md §5
class DashboardFooter extends ConsumerWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPaused =
        (ref.watch(pausedPactCountProvider).asData?.value ?? 0) > 0;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openSheet(context, ref),
      child: Container(
        width: double.infinity,
        color: AppColors.background,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Text(
                '≡',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.onSurfaceDim,
                    ),
              ),
              // Passive indicator dot — visible when paused PACTs are waiting.
              if (hasPaused)
                Positioned(
                  top: -2,
                  right: -10,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSheet(BuildContext context, WidgetRef ref) {
    // Refresh the paused count just before the sheet opens so the badge is
    // always current — no stale reads from a long-idle session.
    ref.invalidate(pausedPactCountProvider);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const ActionBottomSheet(),
    );
  }
}
