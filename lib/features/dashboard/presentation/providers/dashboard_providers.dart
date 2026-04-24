import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features/pact/domain/models/slot_state.dart';
import '../../../../features/pact/domain/use_cases/get_slot_availability_use_case.dart';

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
