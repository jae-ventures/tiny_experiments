# Feature Spec: PACT Management

**Feature:** `pact`
**Version:** 0.1 (Draft)
**Last Updated:** 2026-04-21
**Depends on:** Core database setup, slot progression system

---

## 1. Overview

The PACT feature covers the full lifecycle of creating, viewing, editing, and closing a PACT. It is the central entity of the entire application. Every other feature (tracking, reflection, dashboard) depends on a PACT existing.

---

## 2. Domain Model

### 2.1 Entity: `Pact`

```dart
@freezed
class Pact with _$Pact {
  const factory Pact({
    required String id,               // UUID
    required String action,           // "I will <action>"
    required PactCadence cadence,     // daily | weekly | biweekly
    required int durationTrials,      // total number of trials committed to
    required DateTime startDate,
    required DateTime endDate,        // derived: startDate + trials × cadence
    required PactStatus status,       // active | paused | completed | abandoned
    required DateTime createdAt,
    String? ifCondition,              // "If <trigger>..."
    String? thenAction,               // "...then <action>"
    String? hypothesis,               // the user's stated curiosity or hypothesis
    CuriosityTemperature? temperature, // cold | warm | fiery
    int? reflectionIntervalTrials,    // how often to prompt reflection (default: midpoint)
  }) = _Pact;
}
```

### 2.2 Enums

```dart
enum PactCadence { daily, weekly, biweekly }

enum PactStatus { active, paused, completed, abandoned }

// Maps to the Curiosity–Fiery spectrum
enum CuriosityTemperature { cold, warm, fiery }
```

### 2.3 Entity: `Trial`

A single instance of showing up for a PACT on a scheduled day.

```dart
@freezed
class Trial with _$Trial {
  const factory Trial({
    required String id,
    required String pactId,
    required DateTime scheduledDate,
    required TrialStatus status,      // pending | completed | skipped
    DateTime? completedAt,
    String? note,                     // optional short note on completion
  }) = _Trial;
}

enum TrialStatus { pending, completed, skipped }
```

### 2.4 Entity: `Reflection`

A scheduled check-in tied to a PACT at defined intervals.

```dart
@freezed
class Reflection with _$Reflection {
  const factory Reflection({
    required String id,
    required String pactId,
    required DateTime scheduledDate,
    required ReflectionStatus status,
    DateTime? completedAt,
    String? feelingNote,              // How is this experiment feeling?
    ReflectionDecision? decision,     // persist | pause | pivot
    String? decisionNote,
  }) = _Reflection;
}

enum ReflectionStatus { pending, completed }
enum ReflectionDecision { persist, pause, pivot }
```

---

## 3. Repository Interface

```dart
// features/pact/domain/pact_repository.dart

abstract class PactRepository {
  // PACTs
  Stream<List<Pact>> watchActivePacts();
  Stream<List<Pact>> watchArchivedPacts();
  Future<Result<Pact, Failure>> getPactById(String id);
  Future<Result<Unit, Failure>> savePact(Pact pact);
  Future<Result<Unit, Failure>> updatePactStatus(String id, PactStatus status);
  Future<Result<Unit, Failure>> deletePact(String id);

  // Trials
  Stream<List<Trial>> watchTrialsForPact(String pactId);
  Future<Result<Unit, Failure>> logTrial(Trial trial);
  Future<Result<Unit, Failure>> skipTrial(String trialId);

  // Reflections
  Stream<List<Reflection>> watchReflectionsForPact(String pactId);
  Future<Result<Unit, Failure>> saveReflection(Reflection reflection);
}
```

---

## 4. Use Cases

| Use Case | Responsibility |
|---|---|
| `CreatePactUseCase` | Validates form, checks slot availability, generates trial schedule, persists PACT |
| `GetActivePactsUseCase` | Returns stream of active PACTs for dashboard |
| `PausePactUseCase` | Sets status to paused; optionally frees the slot |
| `ResumePactUseCase` | Sets status back to active; checks slot availability |
| `CompletePactUseCase` | Sets status to completed; triggers final reflection |
| `AbandonPactUseCase` | Sets status to abandoned; records pivot decision |
| `GenerateTrialScheduleUseCase` | Given a PACT, returns the full list of `Trial` objects across the duration |
| `CheckDoubleSkipUseCase` | Detects two consecutive skips and triggers reflection prompt |
| `GetSlotAvailabilityUseCase` | Returns current slot usage and capacity |

---

## 5. PACT Creation Flow

### 5.1 Steps

The creation flow is a multi-step form. Each step is a separate screen or animated page within a PageView. Progress is not lost if the user navigates back.

```
Step 1: Curiosity          "What are you curious about?"
         ↓                  Free-text hypothesis / question
Step 2: The PACT           "I will ______ for ______"
         ↓                  Action field + duration + cadence picker
Step 3: Implementation     Optional: "If ______ then ______"
   Intention               Anchors the PACT to a context or trigger
         ↓
Step 4: Temperature        Optional: Where does this sit on your curiosity spectrum?
         ↓                  Cold / Warm / Fiery selector
Step 5: Review + Confirm   Summary card; shows generated trial count and end date
```

### 5.2 Validation Rules

- Action field: required, minimum 5 characters
- Duration: required, expressed as number of trials (not raw days — cadence determines the calendar mapping)
  - Suggested guardrails shown as helper text (not enforced):
    - New/unfamiliar: 10–40 trials
    - Familiar idea: ~30 trials (1 month daily)
    - Ongoing improvement: ~90 trials (3 months daily)
- Cadence: required (daily / weekly / bi-weekly)
- Slot availability: if no slots are available, creation is blocked with a friendly explanation of the progression system — not an error state
- If-then: optional; if partially filled, validate both fields are present

### 5.3 Trial Schedule Generation

On confirmation, the app generates all `Trial` records for the PACT immediately and stores them locally. This allows the tracking feature to function fully offline without re-deriving schedules.

```
trialDates = [startDate]
for i in 1..<durationTrials:
  trialDates.append(trialDates.last + cadenceOffset)
```

Where `cadenceOffset` is 1 day (daily), 7 days (weekly), or 14 days (bi-weekly).

Reflection checkpoints are inserted into the schedule at the midpoint and endpoint of the trial list. Additional intervals may be user-configured.

---

## 6. Slot Progression System

### 6.1 Rules

- Initial slots: **3**
- Slots unlock after completing whole PACTs (reaching `completed` status)
- Suggested progression (open question — subject to change):

| Completed PACTs | Total Slots Unlocked |
|---|---|
| 0 | 3 |
| 2 | 4 |
| 5 | 5 |
| 10 | 6 |
| 20 | 7 |

- Paused PACTs **do** consume a slot (open question — see project spec)
- Abandoned PACTs do **not** count toward completion unlock

### 6.2 Slot State Model

```dart
@freezed
class SlotState with _$SlotState {
  const factory SlotState({
    required int totalSlots,
    required int usedSlots,
    required int completedPactCount,
    required int? pactsUntilNextSlot,  // null if at max
  }) = _SlotState;

  int get availableSlots => totalSlots - usedSlots;
  bool get hasAvailableSlot => availableSlots > 0;
}
```

---

## 7. Double-Skip Detection

When a trial is marked as skipped:

1. Check the previous scheduled trial for the same PACT
2. If it is also `skipped`, trigger a reflection prompt immediately (not on schedule)
3. The prompt frames this as curiosity, not failure: *"You've missed two sessions of this PACT. How is it feeling? Do you want to persist, pause, or pivot?"*
4. The user's response is recorded as an unscheduled `Reflection`

This logic lives in `CheckDoubleSkipUseCase` and is called by the tracking feature after every skip action.

---

## 8. PACT Status Transitions

```
           ┌─────────────┐
           │   ACTIVE    │
           └──────┬──────┘
         ┌────────┼────────┐
         ↓        ↓        ↓
      PAUSED  COMPLETED  ABANDONED
         │
         ↓
      ACTIVE (resume)
```

- `active → paused`: User manually pauses, or double-skip reflection leads to pause decision
- `active → completed`: All trials are logged (completed or skipped) and final reflection is done
- `active → abandoned`: User chooses "pivot" at any reflection point, or manually abandons
- `paused → active`: User resumes; checks slot availability first

---

## 9. Drift Schema (Data Layer)

```dart
// features/pact/data/drift/pact_tables.dart

class Pacts extends Table {
  TextColumn get id => text()();
  TextColumn get action => text()();
  TextColumn get cadence => textEnum<PactCadence>()();
  IntColumn get durationTrials => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get status => textEnum<PactStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn? get ifCondition => text().nullable()();
  TextColumn? get thenAction => text().nullable()();
  TextColumn? get hypothesis => text().nullable()();
  TextColumn? get temperature => textEnum<CuriosityTemperature>().nullable()();
  IntColumn? get reflectionIntervalTrials => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Trials extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  DateTimeColumn get scheduledDate => dateTime()();
  TextColumn get status => textEnum<TrialStatus>()();
  DateTimeColumn? get completedAt => dateTime().nullable()();
  TextColumn? get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Reflections extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  DateTimeColumn get scheduledDate => dateTime()();
  TextColumn get status => textEnum<ReflectionStatus>()();
  DateTimeColumn? get completedAt => dateTime().nullable()();
  TextColumn? get feelingNote => text().nullable()();
  TextColumn? get decision => textEnum<ReflectionDecision>().nullable()();
  TextColumn? get decisionNote => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

---

## 10. Riverpod Providers (Presentation Layer)

```dart
// features/pact/presentation/pact_provider.dart

@riverpod
Stream<List<Pact>> activePacts(ActivePactsRef ref) {
  return ref.watch(pactRepositoryProvider).watchActivePacts();
}

@riverpod
class CreatePactNotifier extends _$CreatePactNotifier {
  @override
  CreatePactState build() => const CreatePactState.idle();

  Future<void> submit(PactFormData form) async {
    state = const CreatePactState.loading();
    final result = await ref.read(createPactUseCaseProvider).execute(form);
    state = result.fold(
      (failure) => CreatePactState.error(failure.message),
      (_) => const CreatePactState.success(),
    );
  }
}

@freezed
class CreatePactState with _$CreatePactState {
  const factory CreatePactState.idle() = _Idle;
  const factory CreatePactState.loading() = _Loading;
  const factory CreatePactState.success() = _Success;
  const factory CreatePactState.error(String message) = _Error;
}
```

---

## 11. Notifications

PACT creation triggers scheduling of local notifications via `flutter_local_notifications`:

- A daily reminder at the user's preferred time (global setting) for each active PACT
- A reflection prompt notification when a reflection checkpoint is reached
- A double-skip alert when two consecutive trials are missed
- Notifications are rescheduled when a PACT is paused, resumed, or completed

Notification payloads include the `pactId` so the app deep-links directly to the relevant PACT on tap.

---

## 12. Open Questions

- Should the if-then implementation intention be surfaced in the notification text? ("It's time to write — your PACT triggers when you sit down with coffee.")
- Should users be able to edit a PACT after creation, or only create new ones (to preserve experiment integrity)?
- What happens to pending trials when a PACT is paused — are they rescheduled, or does the end date extend?
- Is the curiosity temperature editable after creation, or locked at creation time?
