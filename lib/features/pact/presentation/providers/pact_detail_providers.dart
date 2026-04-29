import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/dashboard/presentation/providers/dashboard_providers.dart';
import '../../data/repositories/drift_pact_repository.dart';
import '../../domain/models/pact.dart';

// ── Single-PACT loader ────────────────────────────────────────────────────────

/// Loads a single PACT by ID for the detail screen.
///
/// Uses a one-shot [FutureProvider] rather than a stream because the repository
/// only exposes stream APIs for collections. PACT data is effectively immutable
/// on the detail screen (editing is not allowed — see spec §13); the trial list
/// is the live reactive surface, handled separately by [trialsForPactProvider].
///
/// Auto-disposes so the cached result is cleared when the screen is popped.
final pactDetailProvider =
    FutureProvider.autoDispose.family<Pact?, String>((ref, pactId) async {
  final result = await ref.read(pactRepositoryProvider).getPactById(pactId);
  return result.fold((_) => null, (p) => p);
});

// ── Slot / color index ────────────────────────────────────────────────────────

/// Returns the slot index (0–3) for a PACT — used to derive its palette color.
///
/// Looks up the PACT's position in [activePactsProvider], which is the same
/// ordering used by the dashboard carousel. Falls back to 0 for PACTs that are
/// no longer active (paused / completed) so the detail screen still shows
/// a sensible color rather than crashing.
final pactSlotIndexProvider =
    Provider.autoDispose.family<int, String>((ref, pactId) {
  final pacts = ref.watch(activePactsProvider).asData?.value ?? [];
  final idx = pacts.indexWhere((p) => p.id == pactId);
  return idx < 0 ? 0 : idx;
});
