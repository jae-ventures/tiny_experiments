import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import 'widgets/dashboard_footer.dart';
import 'widgets/pact_card_carousel.dart';
import 'widgets/possibility_space.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _DashboardLayout(),
      ),
    );
  }
}

class _DashboardLayout extends StatelessWidget {
  const _DashboardLayout();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalHeight = constraints.maxHeight;

        // Three-region proportions per spec §2
        final possibilityHeight = totalHeight * 0.55;
        final carouselHeight = totalHeight * 0.35;
        final footerHeight = totalHeight * 0.10;

        return Column(
          children: [
            SizedBox(
              height: possibilityHeight,
              child: const PossibilitySpace(),
            ),
            SizedBox(
              height: carouselHeight,
              child: const PactCardCarousel(),
            ),
            SizedBox(
              height: footerHeight,
              child: const DashboardFooter(),
            ),
          ],
        );
      },
    );
  }
}
