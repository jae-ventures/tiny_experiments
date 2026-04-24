import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Middle region (~35% of screen). Horizontally swipeable PACT cards.
/// Content implemented in Task 2.5.
class PactCardCarousel extends StatelessWidget {
  const PactCardCarousel({super.key});

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
          'PACT Card Carousel',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceDim,
              ),
        ),
      ),
    );
  }
}
