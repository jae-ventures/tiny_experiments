import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../features/pact/domain/models/pact.dart';
import '../providers/dashboard_providers.dart';
import 'pact_card.dart';

// ── Public widget ─────────────────────────────────────────────────────────────

/// Middle region (~35% of screen). Horizontally swipeable PACT card carousel.
///
/// Reads [activePactsProvider] and delegates to [_ActiveCarousel] when PACTs
/// exist, or [_EmptyStateCard] when the user has no active experiments yet.
///
/// Spec refs: 03_ui_spec_dashboard.md §4, §6
class PactCardCarousel extends ConsumerWidget {
  const PactCardCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activePactsAsync = ref.watch(activePactsProvider);

    return activePactsAsync.when(
      data: (pacts) {
        if (pacts.isEmpty) return const _EmptyStateCard();

        // Sort by creation date so slot colors are consistent with PossibilitySpace.
        final sorted = List<Pact>.from(pacts)
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

        return _ActiveCarousel(
          key: ValueKey(sorted.length),
          pacts: sorted,
        );
      },
      loading: () => const _LoadingCard(),
      error: (err, _) => const _EmptyStateCard(),
    );
  }
}

// ── Active carousel ───────────────────────────────────────────────────────────

class _ActiveCarousel extends StatefulWidget {
  final List<Pact> pacts;

  const _ActiveCarousel({super.key, required this.pacts});

  @override
  State<_ActiveCarousel> createState() => _ActiveCarouselState();
}

class _ActiveCarouselState extends State<_ActiveCarousel> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: widget.pacts.length,
            itemBuilder: (context, i) => PactCard(
              pact: widget.pacts[i],
              slotIndex: i,
            ),
          ),
        ),
        // Page indicator dots — only shown when there are multiple PACTs.
        if (widget.pacts.length > 1)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _PageIndicator(
              count: widget.pacts.length,
              currentIndex: _currentPage,
            ),
          ),
      ],
    );
  }
}

// ── Page indicator ────────────────────────────────────────────────────────────

class _PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _PageIndicator({required this.count, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        final dotColor = isActive
            ? AppColors.pactPalette[i % AppColors.pactPalette.length]
            : AppColors.onSurfaceDim;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 16 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

/// Shown when the user has no active PACTs and no backlog (spec §6).
class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.outline),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tap the dot above to begin',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppColors.onBackground,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                'your first experiment',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurface,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Loading state ─────────────────────────────────────────────────────────────

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.outline),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }
}
