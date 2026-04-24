import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Upper region (~55% of screen). Houses animated slot and backlog dots.
/// Content implemented in Task 2.4.
class PossibilitySpace extends StatelessWidget {
  const PossibilitySpace({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant),
        ),
      ),
      child: Center(
        child: Text(
          'Possibility Space',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceDim,
              ),
        ),
      ),
    );
  }
}
