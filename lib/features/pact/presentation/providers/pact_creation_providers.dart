import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/models/pact.dart';
import '../../domain/use_cases/create_pact_use_case.dart';
import '../../domain/use_cases/get_slot_availability_use_case.dart';
import '../../domain/use_cases/pact_form_data.dart';

part 'pact_creation_providers.freezed.dart';

// ── Form state ────────────────────────────────────────────────────────────────

/// Immutable state for the 5-step PACT creation form.
///
/// [durationDays] is the user's raw input (number of days). [durationTrials]
/// is derived from that and [cadence]. [startDate] is snapped to the next
/// occurrence of [dayOfWeek] when a non-daily cadence is chosen.
@freezed
abstract class PactFormState with _$PactFormState {
  const factory PactFormState({
    @Default('') String hypothesis,
    @Default('') String action,
    @Default(30) int durationDays,
    @Default(PactCadence.daily) PactCadence cadence,
    int? dayOfWeek, // 1 = Mon … 7 = Sun; null means start today (daily)
    @Default('') String ifCondition,
    @Default('') String thenAction,
    CuriosityTemperature? temperature,
    @Default(false) bool showErrors,
  }) = _PactFormState;

  const PactFormState._();

  // ── Derived scheduling ────────────────────────────────────────────────────

  int get _cadenceIntervalDays => switch (cadence) {
        PactCadence.daily => 1,
        PactCadence.weekly => 7,
        PactCadence.biweekly => 14,
        PactCadence.monthly => 30,
      };

  /// Total number of trials (one per cadence interval within [durationDays]).
  int get durationTrials =>
      (durationDays / _cadenceIntervalDays).ceil().clamp(1, 9999);

  /// First trial date. For non-daily cadences the start date is snapped to
  /// the next occurrence of [dayOfWeek] (or today if that weekday is today).
  DateTime get startDate {
    final today = DateTime.now();
    final d = DateTime(today.year, today.month, today.day);
    if (cadence == PactCadence.daily || dayOfWeek == null) return d;
    final daysUntil = (dayOfWeek! - d.weekday + 7) % 7;
    return d.add(Duration(days: daysUntil));
  }

  /// Last trial date.
  DateTime get endDate =>
      startDate.add(Duration(days: _cadenceIntervalDays * (durationTrials - 1)));

  // ── Duration display ──────────────────────────────────────────────────────

  /// Human-readable experiment length (e.g. "≈ 1 month", "≈ 2 weeks, 3 days").
  String get durationLabel => _formatDays(durationDays);

  static String _formatDays(int days) {
    if (days <= 0) return '';
    if (days < 7) return '$days ${days == 1 ? 'day' : 'days'}';
    if (days < 30) {
      final w = days ~/ 7, r = days % 7;
      final s = '$w ${w == 1 ? 'week' : 'weeks'}';
      return r == 0 ? s : '$s, $r ${r == 1 ? 'day' : 'days'}';
    }
    if (days < 365) {
      final m = days ~/ 30, r = days % 30;
      final s = '$m ${m == 1 ? 'month' : 'months'}';
      return r == 0 ? s : '$s, $r ${r == 1 ? 'day' : 'days'}';
    }
    final y = days ~/ 365, rm = (days % 365) ~/ 30;
    final s = '$y ${y == 1 ? 'year' : 'years'}';
    return rm == 0 ? s : '$s, $rm ${rm == 1 ? 'month' : 'months'}';
  }

  // ── Validation ────────────────────────────────────────────────────────────

  bool get isActionValid => action.trim().length >= 5;
  bool get isDurationValid => durationDays >= 1;
  bool get isStep2Valid => isActionValid && isDurationValid;

  /// If/then is valid when both fields are filled or both are empty.
  bool get isIfThenValid =>
      (ifCondition.trim().isEmpty && thenAction.trim().isEmpty) ||
      (ifCondition.trim().isNotEmpty && thenAction.trim().isNotEmpty);
}

// ── Form notifier ─────────────────────────────────────────────────────────────

class PactFormNotifier extends Notifier<PactFormState> {
  @override
  PactFormState build() => const PactFormState();

  void updateHypothesis(String v) =>
      state = state.copyWith(hypothesis: v, showErrors: false);
  void updateAction(String v) =>
      state = state.copyWith(action: v, showErrors: false);
  void updateDurationDays(int v) =>
      state = state.copyWith(durationDays: v, showErrors: false);

  void updateCadence(PactCadence v) {
    // Default to today's weekday when switching to a non-daily cadence so the
    // day-of-week row has a sensible pre-selection.
    final dow =
        v == PactCadence.daily ? null : (state.dayOfWeek ?? DateTime.now().weekday);
    state = state.copyWith(cadence: v, dayOfWeek: dow, showErrors: false);
  }

  void updateDayOfWeek(int v) => state = state.copyWith(dayOfWeek: v);
  void updateIfCondition(String v) =>
      state = state.copyWith(ifCondition: v, showErrors: false);
  void updateThenAction(String v) =>
      state = state.copyWith(thenAction: v, showErrors: false);
  void updateTemperature(CuriosityTemperature? v) =>
      state = state.copyWith(temperature: v);

  /// Called when the user taps Next on a step — reveals inline error messages.
  void markValidationAttempted() => state = state.copyWith(showErrors: true);
}

/// Auto-disposes when the creation screen is dismissed so the form resets
/// on every new creation flow.
final pactFormNotifierProvider =
    NotifierProvider.autoDispose<PactFormNotifier, PactFormState>(
  PactFormNotifier.new,
);

// ── Creation status ───────────────────────────────────────────────────────────

sealed class CreatePactStatus {
  const CreatePactStatus();
}

final class CreatePactIdle extends CreatePactStatus {
  const CreatePactIdle();
}

final class CreatePactLoading extends CreatePactStatus {
  const CreatePactLoading();
}

final class CreatePactSuccess extends CreatePactStatus {
  final Pact pact;
  const CreatePactSuccess(this.pact);
}

final class CreatePactError extends CreatePactStatus {
  final String message;
  const CreatePactError(this.message);
}

// ── Creation notifier ─────────────────────────────────────────────────────────

class CreatePactNotifier extends Notifier<CreatePactStatus> {
  late final CreatePactUseCase _useCase;

  @override
  CreatePactStatus build() {
    _useCase = ref.read(createPactUseCaseProvider);
    return const CreatePactIdle();
  }

  Future<void> submit(PactFormState formState) async {
    if (state is CreatePactLoading) return;
    state = const CreatePactLoading();

    final form = PactFormData(
      action: formState.action.trim(),
      cadence: formState.cadence,
      durationTrials: formState.durationTrials,
      startDate: formState.startDate,
      ifCondition: formState.ifCondition.trim().isEmpty
          ? null
          : formState.ifCondition.trim(),
      thenAction: formState.thenAction.trim().isEmpty
          ? null
          : formState.thenAction.trim(),
      hypothesis: formState.hypothesis.trim().isEmpty
          ? null
          : formState.hypothesis.trim(),
      temperature: formState.temperature,
    );

    final result = await _useCase.execute(form);
    state = result.fold(
      (f) => CreatePactError(f.message),
      (pact) => CreatePactSuccess(pact),
    );
  }
}

final createPactNotifierProvider =
    NotifierProvider.autoDispose<CreatePactNotifier, CreatePactStatus>(
  CreatePactNotifier.new,
);

// ── Preview color ─────────────────────────────────────────────────────────────

/// The palette color the new PACT will receive, based on the current number
/// of active slots. Used on the Step 5 review card for an accurate preview.
final nextPactColorProvider = FutureProvider.autoDispose<Color>((ref) async {
  final result = await ref.read(getSlotAvailabilityUseCaseProvider).execute();
  final usedSlots = result.fold((_) => 0, (s) => s.usedSlots);
  return AppColors.pactPalette[usedSlots % AppColors.pactPalette.length];
});
