# Tiny Experiments — Project Specification

**Version:** 0.3 (Draft)
**Last Updated:** 2026-04-21
**Status:** In Progress

---

## 1. Vision

Tiny Experiments is a mobile-first (iOS, Android) and web app that helps users explore their curiosities through structured, low-pressure experiments called **PACTs**. It sits at the intersection of *Tiny Experiments* (Anne-Laure Le Cunff) and *Atomic Habits* (James Clear) — prioritizing systems and curiosity over rigid goal-setting and outcome pressure.

The core philosophy: **just show up**. There is no pressure to perform. The repeatable trials of a PACT generate observable data that helps users make better decisions about what to persist with, pause, or pivot away from.

---

## 2. Core Concepts

### 2.1 What is a PACT?

A PACT is a short-term, repeatable commitment that frames a curiosity or hypothesis as something you can act on and observe. It is **not** a habit and **not** a goal.

**Format:** `I will <action> for <duration>.`

A well-formed PACT is:

- **Exciting** — No need for a life-long purpose. There is meaning behind every PACT.
- **Actionable** — You can get started quickly without breaking the bank.
- **Continuous / Repeatable** — PACTs can be performed daily, weekly, or bi-weekly (cadence is set per PACT).
- **Trackable** — Not measurable in an outcome sense, but observable and countable.
- **Imaginative / Curious** — Can be small or ambitious, related to any part of life.

PACTs optionally include an **implementation intention** in the form: `If — then —` to anchor the activity to a context or trigger.

### 2.2 The Experiment Lifecycle

```
Curiosity → Hypothesis → PACT → Trials → Reflection → Decision
                                                          ↓
                                             Persist | Pause | Pivot
```

Each trial is a single instance of showing up for a PACT. Trials accumulate into a trackable record that surfaces patterns over time.

### 2.3 The Curiosity–Fiery Spectrum

PACTs can range from cold curiosity (low investment, exploratory) to fiery passion (high investment, deeply motivating). The app should not enforce where on this spectrum a PACT sits — it's informational, helping users calibrate their own commitment levels.

```
Curiosity/Cold ←————————————— PACT ——————————————→ Fiery
```

### 2.4 Progression System (Slots)

To align with the principle of "think tiny," users begin with a single active PACT slot. New slots unlock progressively as experiments are completed. This prevents overcommitment and the effort paradox (where harder-seeming commitments are chosen to feel productive but are less likely to be completed).

**Slot progression:**

| Total Completed PACTs | Active Slots Unlocked |
|---|---|
| 0 | 1 |
| 3 | 2 |
| 10 | 3 |
| 20 | 4 (maximum) |

The cap of 4 simultaneous active PACTs is intentional and permanent for v1.0. It is a feature, not a limitation. Future versions may explore higher limits as an optional setting.

Within the cap, users may configure a **personal active limit** (1 up to their unlocked maximum) in Settings. This allows someone who has unlocked 3 slots but wants to focus on just 1 to enforce that constraint on themselves.

### 2.5 The Curiosity Backlog

Ideas arrive faster than we can commit to them. The **Curiosity Backlog** is a low-friction drawer where users can capture PACT ideas without activating them. There is no limit on backlog entries.

Backlog items are lightweight — a title or rough idea is enough. When a slot becomes available (or the user is ready to commit), they can promote a backlog item into a full PACT through the standard creation flow, with the rough idea pre-filled as a starting point.

The backlog is not a queue or a to-do list. It is a curiosity sketchbook. There is no pressure to act on anything in it.

### 2.6 The Pause Drawer

When a user pauses a PACT at a reflection point, it moves into the **Pause Drawer** and immediately frees its active slot. A paused PACT is neither failed nor abandoned — it is resting.

Paused PACTs are surfaced again on a gentle schedule:

- After **1 month** — a soft prompt: *"You paused this experiment a while ago. Curious to revisit it?"*
- After **3 months** — a second prompt
- After **6 months** — a final prompt

At any prompt, the user can:
- **Resume** — pick up the PACT (see §2.7 for resume behavior)
- **Archive** — acknowledge it and move on
- **Dismiss** — snooze the prompt without taking action

**Auto-archive after 6 months is optional.** Users can toggle this behavior in Settings. When disabled, the PACT remains in the Pause Drawer indefinitely and prompts cease after the 6-month one. When enabled (the default), the PACT is automatically archived after the 6-month prompt if no action is taken.

Paused PACTs do **not** count against active slots.

### 2.7 Resuming a Paused PACT

When a user resumes a paused PACT, the original trial history is fully preserved and visible in the tracker. The resumed session is treated as a new chapter of the same experiment — distinguished visually by a different color band in the trial calendar, so the user can clearly see where one session ended and the next began.

Before restarting, the user may optionally adjust:
- Cadence (daily / weekly / bi-weekly)
- Number of remaining trials
- The if-then implementation intention

The hypothesis and core action statement are not editable after creation, as they define the identity of the experiment. Changes significant enough to warrant a new hypothesis should be started as a new PACT (pivot), optionally referencing the original.

---

## 3. Target Platforms

| Platform | Priority | Notes |
|---|---|---|
| Android | P0 | Primary mobile target |
| iOS | P0 | Primary mobile target |
| Web (PWA-style) | P1 | Flutter web build; same codebase |

---

## 4. Technical Stack

| Concern | Choice |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Riverpod (with code generation) |
| Local Database | Drift (SQLite; WASM on web) |
| Routing | go_router |
| Data Modeling | Freezed (sealed states, immutable entities) |
| Architecture | Layered (Domain / Data / Presentation) + Feature-first folders |
| Error Handling | Result type via `fpdart` |
| Notifications | `flutter_local_notifications` |
| Home Screen Widgets | `home_widget` package (Android + iOS) |

### 4.1 Local-First Principles

All data is stored locally on the device. The app must be fully functional with no network connection. An optional sync layer (e.g., PowerSync or Supabase) may be added in a future version without changes to the domain or presentation layers — sync would write to the local DB, and the UI observes reactive streams from Drift.

### 4.2 Platform Abstraction

Database connection is platform-specific and resolved via conditional Dart imports:

- **Mobile:** `NativeDatabase` (sqlite3)
- **Web:** `WasmDatabase` (sql.js / WASM backend)

---

## 5. Architecture Overview

```
lib/
├── core/
│   ├── database/          # Drift AppDatabase, connection factory
│   ├── router/            # go_router config
│   └── theme/             # ThemeData, color tokens, typography
├── features/
│   ├── pact/              # PACT creation, editing, detail
│   ├── tracking/          # Daily check-in, trial logging
│   ├── reflection/        # Scheduled reflections, persist/pause/pivot
│   ├── dashboard/         # Home screen, active PACTs, slot overview
│   ├── backlog/           # Curiosity backlog drawer
│   ├── pause_drawer/      # Paused PACTs, re-engagement prompts
│   └── onboarding/        # First-run education about PACTs
└── main.dart
```

Each feature follows the internal structure:

```
features/<n>/
├── data/
│   ├── drift/             # Table definitions, DAOs
│   └── <n>_repository_impl.dart
├── domain/
│   ├── <entity>.dart
│   ├── <n>_repository.dart   # Abstract interface
│   └── use_cases/
└── presentation/
    ├── <n>_page.dart
    ├── <n>_provider.dart     # Riverpod AsyncNotifier
    └── widgets/
```

---

## 6. Key Design Constraints

These constraints directly reflect the philosophy of Tiny Experiments and Atomic Habits:

1. **Slot Progression** — Users begin with 1 active PACT slot. Additional slots unlock at 3, 10, and 20 completed PACTs, reaching a hard maximum of 4. This is enforced in the domain layer. A personal limit setting (1 up to unlocked max) is available in Settings.

2. **No Double-Skip Rule** — Missing a single trial is acceptable and expected. Missing two consecutive trials triggers a reflection prompt — not a punishment, but a signal to check in on the PACT. The app frames this constructively.

3. **Think Tiny** — PACT creation UX must actively encourage small, specific commitments. There is no enforced maximum duration, but advisory guidance is surfaced in the UI:
   - 10–40 trials — good for new or unfamiliar ideas
   - ~30 trials — familiar territory
   - ~90 trials — ongoing improvement
   - A gentle, non-blocking nudge is shown for durations that extend beyond one year.

4. **Outputs over Outcomes** — Tracking records whether you showed up, not whether you hit a metric. There are no performance scores.

5. **Cadence Flexibility** — PACTs can be daily, weekly, or bi-weekly. Cadence is set per PACT at creation and may be adjusted when resuming from a pause. The trial scheduler accounts for cadence when determining what is "due today."

6. **Reflection Cadence is Per PACT** — Users set their preferred reflection interval when creating a PACT (e.g., every 7 trials, every 14 trials, or at the midpoint only). There is no app-level default override. This allows a daily PACT to reflect weekly while a bi-weekly PACT reflects monthly — whatever feels right for the experiment.

7. **Minimum Trials Before Exit** — A PACT cannot be abandoned until at least 10 **completed** trials have been logged. Skipped trials do not count toward this minimum, as they do not represent genuine engagement with the experiment. The abandon option is simply absent in the UI until this threshold is met.

8. **Completion Defined by Trials, Not Time** — A PACT is complete when all scheduled trials have been logged. If the expected end date passes with trials still remaining, the user receives a gentle reminder that the experiment is still open. There is no penalty for finishing late. Life happens.

9. **Paused PACTs Free Their Slot Immediately** — Pausing is a first-class decision. Paused PACTs enter the Pause Drawer, release their active slot, and are revisited via prompts at 1, 3, and 6 months. Auto-archive after 6 months is on by default but can be disabled in Settings.

10. **Backlog Items Stay Minimal** — A backlog entry requires only a title. No structured fields, no cadence, no duration. The intent is zero friction for capturing a fleeting idea. Structure is added only when the idea is promoted to a full PACT.

---

## 7. Feature Scope

### MVP (v1.0)

- PACT creation with structured form (action, duration, cadence, reflection interval, optional if-then)
- Active PACT dashboard with slot and personal limit indicator
- Daily check-in: one-tap trial logging
- Trial calendar view per PACT with session color-banding (original vs resumed sessions)
- Scheduled reflection prompts per PACT at user-defined intervals
- Double-skip reflection trigger
- Persist / Pause / Pivot decision at reflection
- Curiosity Backlog drawer — title-only capture, promote to PACT when ready
- Pause Drawer — paused PACTs with re-engagement prompts at 1 / 3 / 6 months
- Resume flow — preserve history, optional adjustment of cadence / remaining trials / if-then
- PACT archive (completed PACTs; auto-archived paused PACTs if setting enabled)
- Minimum 10 completed-trial gate before abandon is available
- Overdue reminder when expected end date passes with trials remaining
- Local notifications for check-in reminders, reflection prompts, and pause re-engagement
- Settings: personal active PACT limit; auto-archive toggle for paused PACTs
- Onboarding flow explaining the PACT framework

### Post-MVP

- Home screen widgets (Android Glance, iOS WidgetKit via `home_widget`)
- Curiosity journal (freeform notes attached to a PACT or individual trial)
- Export / data portability (JSON or CSV)
- Optional cloud sync
- PACT templates / inspiration library
- Pivot flow: pre-fill new PACT creation from a completed reflection decision

---

## 8. Open Questions

- At what reflection interval options should the UI offer? (e.g., every 5 / 7 / 10 / 14 trials, or fully free-entry?) A small fixed set likely reduces friction more than an open number field.
- Should a "pivot" decision in the reflection flow automatically open the PACT creation form with fields pre-filled from the original, to make it easy to start a successor experiment?
- When a PACT is resumed and the user adjusts the number of remaining trials, does the new trial count stack on top of the original schedule (preserving total intended trials) or replace the remaining ones?
- Should the Pause Drawer prompts be delivered as push notifications, in-app banners, or both? Given the gentle nature of the prompts, in-app-only may be more appropriate to avoid feeling nagged.

---

## 9. Non-Goals (v1.0)

- Social / sharing features
- AI-generated PACT suggestions
- Outcome tracking or quantitative goal measurement
- Gamification beyond slot progression (no points, badges, leaderboards)
- Multi-user / collaborative PACTs
- More than 4 simultaneous active PACTs
