import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/pact/data/repositories/drift_pact_repository.dart';
import '../../../../features/pact/domain/models/pact.dart';
import '../../../../features/pact/domain/models/slot_state.dart';
import '../../../../features/pact/domain/use_cases/get_active_pacts_use_case.dart';
import '../../../../features/pact/domain/use_cases/get_slot_availability_use_case.dart';
import '../../../../features/tracking/data/repositories/drift_tracking_repository.dart';
import '../../../../features/tracking/domain/models/trial.dart';

// ── Slot availability ─────────────────────────────────────────────────────────

/// Default state for a brand-new user: 1 slot, nothing active.
const _kNewUserSlotState = SlotState(
  totalSlots: 1,
  usedSlots: 0,
  completedPactCount: 0,
  pactsUntilNextSlot: 3,
);

/// Provides current slot availability for the dashboard.
///
/// TODO (Epic 3): Make this reactive by watching the active pacts stream so
/// the Possibility Space updates immediately when a PACT is created or completed.
final slotStateProvider = FutureProvider<SlotState>((ref) async {
  final result = await ref.read(getSlotAvailabilityUseCaseProvider).execute();
  return result.fold((_) => _kNewUserSlotState, (s) => s);
});

// ── Paused PACT count ─────────────────────────────────────────────────────────

/// Count of currently paused PACTs — used to badge the Pause Drawer item in
/// the action bottom sheet. Invalidated / re-fetched whenever the sheet opens
/// (via [ref.invalidate]) so the count is always fresh.
///
/// TODO: replace with a reactive stream once watchPausedPacts is added to
/// PactRepository (Epic 4 — pause flow).
final pausedPactCountProvider = FutureProvider<int>((ref) async {
  final result = await ref
      .read(pactRepositoryProvider)
      .countPactsByStatus(PactStatus.paused);
  return result.fold((_) => 0, (n) => n);
});

// ── Active PACTs ──────────────────────────────────────────────────────────────

/// Live stream of all active PACTs, sorted by the use case (creation order).
/// Rebuilds the carousel automatically when a PACT is created, paused, or completed.
final activePactsProvider = StreamProvider<List<Pact>>((ref) {
  return ref.watch(getActivePactsUseCaseProvider).execute();
});

// ── Trials per PACT ───────────────────────────────────────────────────────────

/// All trials for a given PACT id — reactive Drift stream.
///
/// Auto-updates when a trial is logged, skipped, or undone, so the check-in
/// button and progress chart refresh without any manual invalidation.
final trialsForPactProvider =
    StreamProvider.family<List<Trial>, String>((ref, pactId) {
  return ref.watch(trackingRepositoryProvider).watchTrialsForPact(pactId);
});
