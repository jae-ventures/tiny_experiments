import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot_state.freezed.dart';

@freezed
class SlotState with _$SlotState {
  const factory SlotState({
    required int totalSlots,
    required int usedSlots,
    required int completedPactCount,
    required int? pactsUntilNextSlot,  // null if at max
  }) = _SlotState;

  const SlotState._();

  int get availableSlots => totalSlots - usedSlots;
  bool get hasAvailableSlot => availableSlots > 0;
}
