# Feature Spec: Tracking

**Feature:** `tracking`
**Version:** 0.2 (Draft)
**Last Updated:** 2026-04-21
**Depends on:** `pact` (entities, repository), core database

---

## 1. Overview

The tracking feature is responsible for everything that happens *during* a PACT — logging trials, recording reflections (both informal and formal), detecting skip patterns, and computing the derived metrics that make a PACT's history meaningful.

It is deliberately separated from the `pact` feature, which handles creation and lifecycle transitions. Tracking is the ongoing heartbeat of an active experiment; the PACT feature is its skeleton.

### Design Principles

- **Open for extension, closed for modification** — `Trial` and `Reflection` are stable, lean domain entities. New metrics, new reflection types, and new streak statistics are added as new use cases that read from the existing data, not as changes to the core entities.
- **Derived metrics are never stored** — streak counts, completion rates, and longitudinal stats are computed on demand from the raw trial and reflection records. This keeps the data model honest and avoids synchronization bugs.
- **Scheduled date is ground truth** — a trial's `scheduledDate` is immutable. A user may log it late; the logged timestamp records when they did so, but the scheduled date anchors all streak and completion calculations.
- **Off-cadence activity is welcome** — reflections may be recorded on any day, regardless of whether a trial was due. This data is stored and surfaced in history.
- **Sessions are first-class** — because PACTs can be paused and resumed, all trials and reflections carry a session number. This enables color-banding in the UI and meaningful segmentation in history views.
- **Skipping is passive, not chosen** — a trial is marked skipped automatically when its window closes. Users are never asked to declare a skip; the system detects it. This removes guilt from the act of not showing up and keeps the data honest.
- **Card health is ambient, not alarming** — behavioral patterns surface through visual character on the PACT card, not through warnings or scores. The UI signals something worth noticing; the user decides whether to act.

---

## 2. Domain Model

### 2.1 Entity: `Trial`

A single scheduled instance of showing up for a PACT. Trials are generated in full at PACT creation (and at each resume) and stored immediately, so the complete expected schedule is always available offline.

```dart
@freezed
class Trial with _$Trial {
  const factory Trial({
    required String id,                 // UUID
    required String pactId,
    required int sessionNumber,         // 1 = original, 2 = first resume, etc.
    required int sequenceIndex,         // position in full trial schedule (1-based)
    required DateTime scheduledDate,    // immutable ground truth for this trial slot
    required TrialStatus status,        // pending | completed | skipped | late
    required DateTime createdAt,        // when this trial record was generated
    DateTime? completedAt,              // when the user actually logged it (may differ from scheduledDate)
    String? note,                       // optional free-text note logged at check-in
  }) = _Trial;
}
```

**Notes on fields:**

- `sessionNumber` — increments each time a PACT is resumed from pause. All trials generated at creation are session 1. A resume generates new trials as session 2, and so on.
- `sequenceIndex` — the trial's absolute position across all sessions (e.g., trial 14 of 30 total). Useful for progress display ("you're nearly halfway") and for placing reflection checkpoints.
- `status: late` — a distinct state for a trial whose `scheduledDate` has passed but was logged after the fact. Counts as completed for all metric purposes but is visually distinct in the progress chart, acknowledging that life happens without penalizing the user.
- `completedAt` vs `scheduledDate` — these can and often will diverge. A user who logs yesterday's trial today has `scheduledDate = yesterday`, `completedAt = today`. Streak calculations use `scheduledDate`; display timestamps use `completedAt`.

### 2.2 Enum: `TrialStatus`

```dart
enum TrialStatus {
  pending,    // scheduled, not yet due or window not yet closed
  completed,  // logged on or before scheduledDate
  late,       // logged after scheduledDate has passed (within grace window)
  skipped,    // automatically applied when the trial window closes without a log
}
```

The distinction between `completed` and `late` is display-only — both count equally for the 10-trial minimum, completion rate, and streak calculations. `skipped` is **never set by the user directly** — it is written by the `AutoSkipDetectionUseCase` when it determines the trial window has elapsed. This keeps the semantics clean: a skip is something that happened to a trial, not something a user chose.

### 2.3 Entity: `Reflection`

A reflection captures how a PACT is feeling at a moment in time. Reflections are not limited to formal scheduled checkpoints — they may be logged at any time from the card footer, making them a continuous signal rather than just a milestone marker.

```dart
@freezed
class Reflection with _$Reflection {
  const factory Reflection({
    required String id,                       // UUID
    required String pactId,
    required int sessionNumber,               // mirrors the session of the current trial run
    required ReflectionKind kind,             // informal | formal
    required DateTime loggedAt,               // when this reflection was recorded
    required DateTime createdAt,
    CuriosityTemperature? temperature,        // cold | warm | fiery (the spectrum rating)
    String? note,                             // free-text (supports +/−/→ template)
    String? intention,                        // optional: "I want to try..." — a lightweight course correction
    ReflectionDecision? decision,             // persist | pause | pivot (formal only)
    String? decisionNote,                     // context on the decision (formal only)
    String? linkedTrialId,                    // if logged same-day as a trial, links to it
  }) = _Reflection;
}
```

**Notes on fields:**

- `kind: informal` — logged from the card footer at any time. May have temperature, note, and/or intention. Never has a decision.
- `kind: formal` — triggered by the scheduled reflection prompt or double-skip detection. Always has a decision (persist/pause/pivot). May also have temperature, note, and intention.
- `intention` — a lightweight, optional course correction distinct from the formal decision. Examples: *"I want to do this earlier in the morning"*, *"I'll try reducing from daily to every other day"*. It is not enforced by the app — it is a personal signal the user sets for themselves, visible in their history as a milestone marker. Differentiates from a free note by having semantic meaning: it is forward-looking.
- `linkedTrialId` — when a reflection is logged on the same day as a check-in, it is associated with that trial. On off-cadence days, this is null. This enables the history view to show trial + reflection together in a timeline.
- `temperature` — optional on both kinds. A user who just wants to check in and move on is not required to rate.

### 2.4 Enum: `ReflectionKind`

```dart
enum ReflectionKind {
  informal,   // logged from card footer, anytime
  formal,     // triggered by schedule or double-skip detection
}
```

### 2.5 Enum: `ReflectionDecision`

```dart
enum ReflectionDecision {
  persist,  // continue as-is
  pause,    // move to Pause Drawer, free the slot
  pivot,    // end this PACT, optionally begin a successor
}
```

---

## 3. Derived Metrics

All metrics below are **computed on demand** from the raw `Trial` and `Reflection` records. They are never stored in the database. Each is implemented as a pure function or use case that accepts a list of trials/reflections and returns a value.

This approach means adding a new metric is always additive — a new function with no schema changes.

### 3.1 Trial Metrics

| Metric | Definition | Notes |
|---|---|---|
| `completedCount` | Trials with status `completed` or `late` | Used for 10-trial minimum gate |
| `skippedCount` | Trials with status `skipped` | — |
| `loggedCount` | `completedCount + skippedCount` | Total trials touched by the user |
| `pendingCount` | Trials with status `pending` | Remaining scheduled trials |
| `completionRate` | `completedCount / loggedCount` | 0.0–1.0; null if no trials logged yet |
| `currentSkipStreak` | Consecutive `skipped` trials counting back from the most recent logged trial | Resets to 0 on any `completed` or `late` trial |
| `longestSkipStreak` | The highest `currentSkipStreak` value ever reached in the PACT's history | High-water mark across all sessions |
| `skipStreakCount` | Number of distinct skip streaks (runs of ≥1 consecutive skips) in history | Answers "how many times did I fall off?" |
| `daysSinceLastActivity` | Calendar days between today and the most recent `completedAt` or `late` trial | Null if no completions yet |
| `isOverdue` | `expectedEndDate < today && pendingCount > 0` | Triggers the overdue reminder |

### 3.2 Reflection Metrics

| Metric | Definition | Notes |
|---|---|---|
| `averageTemperature` | Mean of all `temperature` values across reflections that have one | Expressed as a float on the cold(0)→fiery(2) scale |
| `temperatureOverTime` | Ordered list of `(loggedAt, temperature)` pairs | Used to draw the curiosity arc chart in PACT detail |
| `intentionCount` | Number of reflections where `intention` is non-null | A proxy for how much active course-correction has happened |
| `formalReflectionCount` | Reflections with `kind == formal` | — |

### 3.4 Card Health State

The card health state is a derived enum that summarises the PACT's recent behavioral pattern into one of three values. It is consumed directly by the dashboard UI to determine the visual character of the floating dots on the PACT card.

```dart
enum CardHealthState {
  neutral,   // normal engagement — dots are calm and present
  drifting,  // skipping is becoming a pattern — dots are fewer and agitated
  flowing,   // extra unscheduled trials are being logged — dots are more and harmonious
}
```

**Computed by `GetCardHealthStateUseCase`** from two inputs:

1. **Skip ratio over a rolling window** — the proportion of trials that were auto-skipped within the most recent N trials, where N is determined by cadence:
   - Daily PACT → rolling window of 7 trials
   - Weekly PACT → rolling window of 4 trials
   - Bi-weekly PACT → rolling window of 4 trials

   | Skip ratio | State contribution |
   |---|---|
   | ≥ 0.5 (half or more skipped) | `drifting` |
   | < 0.5 | No skip signal |

2. **Extra trial count** — the number of trials logged on days that were not scheduled (off-cadence completions). These are logged voluntarily and represent engagement beyond the commitment. A user who is daily-scheduled but also shows up on weekends is exhibiting flow behavior.

   | Extra trials in rolling window | State contribution |
   |---|---|
   | ≥ 3 unscheduled completions | `flowing` |
   | < 3 | No flow signal |

**Resolution when both signals are absent:** `neutral`.

**Resolution when signals conflict** (e.g., some skips and some extra trials in the same window): `neutral` — mixed signals are not worth amplifying visually.

**State transitions are gradual.** The health state does not snap on a single event. The rolling window naturally smooths the signal — a single skip in an otherwise healthy window will not tip the state to `drifting`. This gradual quality is mirrored in the UI animation transitions (see dashboard UI spec §4.3).

The `skipStreakHistory` is a derived list of value objects, each representing one contiguous skip run:

```dart
@freezed
class SkipStreakRecord with _$SkipStreakRecord {
  const factory SkipStreakRecord({
    required int length,              // number of consecutive skips
    required DateTime startDate,      // scheduledDate of first skip in run
    required DateTime endDate,        // scheduledDate of last skip in run
    required String endedBy,          // 'completion' | 'pact_paused' | 'pact_ended'
  }) = _SkipStreakRecord;
}
```

This is computed by scanning the ordered trial list and grouping consecutive skips. It is the richest longitudinal view of a user's relationship with a PACT.

---

## 4. Repository Interface

The tracking repository follows the same pattern as the PACT repository — abstract interface in the domain layer, Drift implementation in the data layer. The interface is intentionally narrow: it owns trial and reflection persistence, nothing else.

```dart
// features/tracking/domain/tracking_repository.dart

abstract class TrackingRepository {
  // Trials
  Stream<List<Trial>> watchTrialsForPact(String pactId);
  Future<Result<Trial, Failure>> getTrialById(String id);
  Future<Result<Unit, Failure>> logTrial({
    required String trialId,
    required DateTime completedAt,
    String? note,
  });
  Future<Result<Unit, Failure>> skipTrial(String trialId);
  Future<Result<Unit, Failure>> undoTrialLog(String trialId); // revert to pending within same calendar day

  // Reflections
  Stream<List<Reflection>> watchReflectionsForPact(String pactId);
  Future<Result<Unit, Failure>> saveReflection(Reflection reflection);
  Future<Result<Unit, Failure>> updateReflection(Reflection reflection); // for editing same-day entries only
}
```

**Interface decisions:**

- `logTrial` takes a `trialId` (not PACT id) — the trial record already exists in the database as `pending`; logging is an update, not an insert.
- `undoTrialLog` is scoped to same-day only, enforced in the use case layer. This allows accidental check-ins to be corrected without corrupting historical data.
- `saveReflection` is an insert; `updateReflection` allows editing a reflection logged earlier today. Older reflections are immutable.

---

## 5. Use Cases

Use cases are single-responsibility classes in the domain layer. They orchestrate calls to the repository and apply business rules. They never touch Flutter or the database directly.

| Use Case | Responsibility |
|---|---|
| `LogTrialUseCase` | Validates the trial is pending and due (or overdue), sets status to `completed` or `late`, records `completedAt` |
| `AutoSkipDetectionUseCase` | Runs on app open and optionally on a background schedule; scans all active PACTs for trials whose window has closed without a log and marks them `skipped`; emits a notification if any were newly skipped |
| `UndoTrialLogUseCase` | Reverts a same-day log to `pending`; only valid within the same calendar day |
| `CheckDoubleSkipUseCase` | After auto-skip detection, scans the two most recent trials per PACT; if both are `skipped`, emits a trigger for a formal reflection prompt |
| `GetCardHealthStateUseCase` | Computes `CardHealthState` (neutral / drifting / flowing) from the rolling window skip ratio and extra trial count for a given PACT |
| `SaveInformalReflectionUseCase` | Validates and persists an informal reflection from the card footer |
| `SaveFormalReflectionUseCase` | Validates and persists a formal reflection; if decision is `pause` or `pivot`, delegates lifecycle transition to `PactRepository` |
| `GetTrialMetricsUseCase` | Returns the full set of derived trial metrics for a given PACT |
| `GetReflectionMetricsUseCase` | Returns derived reflection metrics (temperature arc, intention count, etc.) |
| `GetSkipStreakHistoryUseCase` | Scans the trial list and returns the ordered `SkipStreakRecord` list |
| `GetTodaysTrialUseCase` | Returns the `Trial` record due today for a given PACT, or null if none is scheduled |
| `GetCompletedTrialCountUseCase` | Returns `completedCount` for the 10-trial minimum gate check |

---

## 6. Check-in Flow

The check-in is the most frequent interaction in the app. It must be fast, unambiguous, and forgiving.

### 6.1 Happy Path

1. User taps the check-in button on a PACT card
2. `GetTodaysTrialUseCase` confirms a pending trial exists for today
3. `LogTrialUseCase` is called:
   - If `today == scheduledDate` → status set to `completed`
   - If `today > scheduledDate` (logged late) → status set to `late`
4. Check-in button transitions to its "done" state
5. If a note or temperature is present in the reflection footer, `SaveInformalReflectionUseCase` is called with `linkedTrialId` set to this trial's id
6. No confirmation dialog. No celebration modal (unless this trial crosses the 10-trial threshold or completes the PACT — those warrant a moment)

### 6.2 Logging a Late Trial

If a user opens the app and a previous day's trial is still `pending` (they forgot to log it), the check-in button should surface this. The card might show "Yesterday" or the specific date as a subtle label. Tapping logs it as `late`.

The app does not attempt to log multiple overdue trials in one tap — only the most recent overdue trial is surfaced at a time. The user may log each one in sequence if they choose.

### 6.3 Automatic Skip Detection

Skipping is never a user action. It is detected automatically by `AutoSkipDetectionUseCase`, which runs:

- On every app open
- Optionally via a background task on supported platforms (Android WorkManager, iOS Background App Refresh), best-effort — not guaranteed

**Detection logic:**

For each active PACT, the use case scans all `pending` trials whose `scheduledDate` is before today. The "trial window" for a given trial is the period between its `scheduledDate` and the next trial's `scheduledDate` (or today, for the most recent one). If the window has fully elapsed and the trial is still `pending`, it is marked `skipped`.

```
trialWindow = nextTrial.scheduledDate - thisTrial.scheduledDate
if today >= thisTrial.scheduledDate + trialWindow && trial.status == pending:
  trial.status = skipped
```

For the last pending trial (no next trial to reference), the window is defined as one cadence period past the `scheduledDate`.

After detection runs, `CheckDoubleSkipUseCase` is called for each PACT where at least one new skip was recorded. If two or more consecutive skips are found, a formal reflection prompt is queued.

**Notification:** If any trials were newly skipped during detection, the user receives a soft notification per affected PACT: *"You missed a session of [PACT name]. How is it feeling?"* — not accusatory, just a gentle nudge toward awareness. Tapping the notification deep-links to the PACT card.

### 6.4 Undo

Tapping an already-completed check-in button on the same calendar day surfaces an undo option. `UndoTrialLogUseCase` reverts the trial to `pending`. This handles accidental taps.

Undo is not available once the calendar day has changed.

---

## 7. Reflection Flow

### 7.1 Informal Reflection (Card Footer)

Always available. No preconditions.

1. User taps the temperature selector → cycles or slides to a value; stored immediately on change (debounced ~500ms)
2. User taps the note field → keyboard opens with template prompts (`+`, `-`, `→`) as quick-insert chips
3. User sets an intention → a secondary text field below the note, prefaced with "I want to…" as placeholder text
4. On dismissal or navigation away, `SaveInformalReflectionUseCase` is called if any field is non-empty
5. If a trial was logged today, the reflection is linked to it via `linkedTrialId`

Multiple informal reflections on the same day for the same PACT are allowed but the app will nudge toward editing the existing one rather than creating a new entry (surfaced as "update your earlier note?" on re-open).

### 7.2 Formal Reflection (Scheduled or Triggered)

Presented as a full-screen modal or dedicated route. Triggered by:
- Reaching a scheduled reflection checkpoint (defined per PACT in trials)
- Double-skip detection

Steps:
1. Prompt: *"How is this experiment feeling?"* — temperature selector (required for formal)
2. Prompt: *"Any notes?"* — free text with template chips (optional)
3. Prompt: *"Anything you want to try differently?"* — intention field (optional)
4. Prompt: *"What would you like to do?"* — Persist / Pause / Pivot (required for formal)
5. If Pivot: optional note about what the pivot is toward; optionally opens PACT creation pre-filled with the current PACT's hypothesis as a starting point
6. `SaveFormalReflectionUseCase` persists the entry; delegates lifecycle transition if pause/pivot

---

## 8. Drift Schema (Data Layer)

```dart
// features/tracking/data/drift/tracking_tables.dart

class Trials extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  IntColumn get sessionNumber => integer()();
  IntColumn get sequenceIndex => integer()();
  DateTimeColumn get scheduledDate => dateTime()();
  TextColumn get status => textEnum<TrialStatus>()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn? get completedAt => dateTime().nullable()();
  TextColumn? get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Reflections extends Table {
  TextColumn get id => text()();
  TextColumn get pactId => text().references(Pacts, #id)();
  IntColumn get sessionNumber => integer()();
  TextColumn get kind => textEnum<ReflectionKind>()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn? get temperature => textEnum<CuriosityTemperature>().nullable()();
  TextColumn? get note => text().nullable()();
  TextColumn? get intention => text().nullable()();
  TextColumn? get decision => textEnum<ReflectionDecision>().nullable()();
  TextColumn? get decisionNote => text().nullable()();
  TextColumn? get linkedTrialId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
```

---

## 9. Riverpod Providers (Presentation Layer)

```dart
// features/tracking/presentation/tracking_provider.dart

// Reactive stream of all trials for a PACT — UI observes this directly
@riverpod
Stream<List<Trial>> trialsForPact(TrialsForPactRef ref, String pactId) {
  return ref.watch(trackingRepositoryProvider).watchTrialsForPact(pactId);
}

// Today's trial for the check-in button state
@riverpod
Future<Trial?> todaysTrial(TodaysTrialRef ref, String pactId) {
  return ref.watch(getTodaysTrialUseCaseProvider(pactId)).execute();
}

// Derived metrics — recomputed when trial stream changes
@riverpod
Future<TrialMetrics> trialMetrics(TrialMetricsRef ref, String pactId) async {
  final trials = await ref.watch(trialsForPact(pactId).future);
  return ref.read(getTrialMetricsUseCaseProvider).execute(trials);
}

// Card health state — drives floating dot animation character on the PACT card
@riverpod
Future<CardHealthState> cardHealthState(CardHealthStateRef ref, String pactId) async {
  final trials = await ref.watch(trialsForPact(pactId).future);
  return ref.read(getCardHealthStateUseCaseProvider).execute(trials);
}

// Check-in action notifier
@riverpod
class CheckInNotifier extends _$CheckInNotifier {
  @override
  CheckInState build(String pactId) => const CheckInState.idle();

  Future<void> logTrial(String trialId) async { ... }
  Future<void> skipTrial(String trialId) async { ... }
  Future<void> undoLog(String trialId) async { ... }
}

@freezed
class CheckInState with _$CheckInState {
  const factory CheckInState.idle() = _Idle;
  const factory CheckInState.loading() = _Loading;
  const factory CheckInState.success() = _Success;
  const factory CheckInState.doubleSkipDetected() = _DoubleSkipDetected; // emitted by AutoSkipDetectionUseCase after detection
  const factory CheckInState.error(String message) = _Error;
}
```

The `doubleSkipDetected` state signals to the UI that a formal reflection prompt should be surfaced immediately — the UI layer observes this state and routes accordingly without the tracking domain knowing anything about navigation.

---

## 10. Open Questions

- Should late trials (`completedAt > scheduledDate`) have a configurable grace window, or is "any day" acceptable? A 3-day window might discourage logging trials from months ago retroactively, but enforcing this may feel punitive.
- Should the informal reflection's temperature field be pre-populated from the PACT's creation temperature, or always start unset and require explicit input? (Noted in dashboard spec — resolution here would close it.)
- When a PACT is resumed, should the `sequenceIndex` continue from the last session (e.g., session 2 starts at index 16 of 30) or restart from 1 for the new session? Continuing gives a unified "trial N of total" display; restarting gives cleaner per-session progress. The `sessionNumber` field handles segmentation either way.
- Should `intention` entries from informal reflections surface anywhere beyond the PACT detail history? A dedicated "intentions" view across all PACTs could be a meaningful motivational artifact post-MVP.
- Should the auto-skip detection background task be user-configurable (opt out), or always run silently? Given the local-first, low-pressure philosophy, making it opt-out feels appropriate.
