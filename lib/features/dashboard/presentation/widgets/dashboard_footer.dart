import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Bottom region (~10% of screen). Houses the hamburger action button.
/// Content implemented in Task 2.6.
class DashboardFooter extends StatelessWidget {
  const DashboardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      child: Center(
        child: Text(
          '≡',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.onSurfaceDim,
              ),
        ),
      ),
    );
  }
}
