import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';
import '../../../pact/data/repositories/drift_pact_repository.dart';
import '../../../tracking/data/repositories/drift_tracking_repository.dart';
import '../models/pact.dart';
import '../pact_repository.dart';
import '../../../tracking/domain/tracking_repository.dart';
import 'generate_trial_schedule_use_case.dart';
import 'get_slot_availability_use_case.dart';
import 'pact_form_data.dart';

final createPactUseCaseProvider = Provider<CreatePactUseCase>((ref) {
  return CreatePactUseCase(
    ref.watch(pactRepositoryProvider),
    ref.watch(trackingRepositoryProvider),
    ref.watch(generateTrialScheduleUseCaseProvider),
    ref.watch(getSlotAvailabilityUseCaseProvider),
  );
});

class CreatePactUseCase {
  final PactRepository _pactRepo;
  final TrackingRepository _trackingRepo;
  final GenerateTrialScheduleUseCase _generateSchedule;
  final GetSlotAvailabilityUseCase _getSlotAvailability;

  const CreatePactUseCase(
    this._pactRepo,
    this._trackingRepo,
    this._generateSchedule,
    this._getSlotAvailability,
  );

  Future<Either<Failure, Pact>> execute(PactFormData form) async {
    // Validate required fields
    if (form.action.trim().length < 5) {
      return left(const Failure('Action must be at least 5 characters'));
    }
    if (form.ifCondition != null && form.thenAction == null ||
        form.thenAction != null && form.ifCondition == null) {
      return left(const Failure('Both if-condition and then-action must be provided together'));
    }

    // Check slot availability
    Failure? failure;
    final slotResult = await _getSlotAvailability.execute();
    slotResult.fold((f) => failure = f, (_) {});
    if (failure != null) return left(failure!);

    final slotState = slotResult.fold((_) => throw StateError(''), (s) => s);
    if (!slotState.hasAvailableSlot) {
      return left(const Failure('No available PACT slots. Complete an existing PACT to unlock more.'));
    }

    // Build the Pact entity
    final now = DateTime.now();
    final startDate = DateTime(form.startDate.year, form.startDate.month, form.startDate.day);
    final endDate = _computeEndDate(startDate, form.cadence, form.durationTrials);

    final pact = Pact(
      id: const Uuid().v4(),
      action: form.action.trim(),
      cadence: form.cadence,
      durationTrials: form.durationTrials,
      startDate: startDate,
      endDate: endDate,
      status: PactStatus.active,
      createdAt: now,
      ifCondition: form.ifCondition?.trim(),
      thenAction: form.thenAction?.trim(),
      hypothesis: form.hypothesis?.trim(),
      temperature: form.temperature,
      reflectionIntervalTrials: form.reflectionIntervalTrials,
    );

    // Persist PACT
    final saveResult = await _pactRepo.savePact(pact);
    saveResult.fold((f) => failure = f, (_) {});
    if (failure != null) return left(failure!);

    // Generate and persist all trial records
    final trials = _generateSchedule.execute(pact);
    final trialsResult = await _trackingRepo.saveTrials(trials);
    trialsResult.fold((f) => failure = f, (_) {});
    if (failure != null) return left(failure!);

    return right(pact);
  }

  DateTime _computeEndDate(DateTime startDate, PactCadence cadence, int durationTrials) {
    final offsetDays = switch (cadence) {
      PactCadence.daily => 1,
      PactCadence.weekly => 7,
      PactCadence.biweekly => 14,
    };
    return startDate.add(Duration(days: offsetDays * (durationTrials - 1)));
  }
}
