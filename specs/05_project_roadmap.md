# Project Roadmap: Tiny Experiments

This document breaks down the development of the Tiny Experiments app into Epics and granular Tasks. 

**How to use this in future sessions:**
Because this file is saved in the codebase, any future AI session will be able to read it. You do not need to paste massive prompts. Simply tell the AI:
> *"Let's work on Epic 1, Task 1.1 from the project roadmap."*
The AI will read this file, understand the overarching goal of the Epic, and execute the specific task.

---

## Epic 1: Core Architecture & Data Foundation
**Goal:** Scaffold the app structure, local database, and domain models.

*   **Task 1.1:** Scaffold the Flutter project architecture (`lib/core/`, `lib/features/`). Install foundational dependencies (`flutter_riverpod`, `fpdart`, `freezed`, `drift`, etc.) and wrap the app in `ProviderScope`.
*   **Task 1.2:** Set up the Drift database connection layer. Implement using `drift_flutter`'s `driftDatabase()` to automatically handle the Native and Wasm abstractions.
*   **Task 1.3:** Define the pure Domain Models using Freezed (`Pact`, `Trial`, `Reflection`, `SlotState`) and their associated Enums (`PactCadence`, `PactStatus`, etc.).
*   **Task 1.4:** Define the Data Layer Schema. Create the Drift table classes (`Pacts`, `Trials`, `Reflections`) that map to the domain models, and run the code generator.
*   **Task 1.5:** Implement the Repository layer. Define the abstract `PactRepository` interface and write its concrete Drift implementation (handling the mapping between Drift's generated classes and our Freezed domain models).
*   **Task 1.6:** Scaffold the foundational Use Cases (e.g., `CreatePactUseCase`, `GenerateTrialScheduleUseCase`) that will bridge our UI state and the Repository.

## Epic 2: Navigation, Theming, and Dashboard UI
**Goal:** Establish app routing, visual identity, and the core 3-region Dashboard structure.

*   **Task 2.1:** Configure `go_router` with the main navigation shell. The app uses a single main screen (Dashboard), avoiding standard tab bars.
*   **Task 2.2:** Establish the global `ThemeData`. Define a curated, warm color palette for PACTs and configure typography to make the app feel premium.
*   **Task 2.3:** Build the Dashboard's 3-region layout shell: Possibility Space (top ~55%), PACT Card Carousel (middle ~35%), and Footer (bottom ~10%).
*   **Task 2.4:** Implement the "Possibility Space" canvas. Create the animated dots (pulsing Slot dots, drifting Backlog dots) and the tap-to-create empty state logic shown in the sketch.
*   **Task 2.5:** Build the horizontally swipeable "PACT Card" UI component containing the PACT Name, Progress Chart grid, and the prominent Circular Check-in Button.
*   **Task 2.6:** Implement the floating Action Button (hamburger icon) in the footer that opens a bottom sheet for navigation to the Backlog, Pause Drawer, Archive, and Settings.

## Epic 3: The PACT Creation Flow
**Goal:** Build the multi-step creation wizard and trial generation logic.

*   **Task 3.1:** Build the multi-step PACT creation UI (using a `PageView` for Hypothesis, Action/Duration/Cadence, If/Then, and Temperature).
*   **Task 3.2:** Implement the domain logic that takes the form data and generates the full schedule of `Trial` records and `Reflection` checkpoints (midpoint/endpoint).
*   **Task 3.3:** Integrate the form submission to save the newly created PACT and its generated trials to the Drift database.

## Epic 4: Tracking & Daily Check-ins
**Goal:** Build the core loop for logging daily activity and enforcing constraints.

*   **Task 4.1:** Update the Dashboard Riverpod providers to fetch real Active PACTs from the database and display today's pending trials.
*   **Task 4.2:** Implement the one-tap interaction on the Dashboard to mark a pending trial as "Completed" or "Skipped", updating the database.
*   **Task 4.3:** Implement the "Double-Skip" domain logic: if a user skips two consecutive trials, intercept the standard skip action and trigger an immediate Reflection prompt.

## Epic 5: Reflections & The Pause Drawer
**Goal:** Handle check-ins, pausing, and resuming experiments.

*   **Task 5.1:** Build the Reflection UI flow. Present this UI when a scheduled reflection is due or a double-skip occurs, capturing the user's decision to Persist, Pause, or Pivot.
*   **Task 5.2:** Implement the "Pause" action: update the database to move the PACT to the "Pause Drawer" and free up its active slot. Build the Pause Drawer UI.
*   **Task 5.3:** Build the "Resume" flow from the Pause Drawer. Allow the user to adjust the cadence or remaining trials before generating new trial records and restarting the PACT.

## Epic 6: Curiosity Backlog & Archiving
**Goal:** Facilitate idea capture and experiment closure.

*   **Task 6.1:** Build the Curiosity Backlog UI—an ultra-low-friction text input to capture a raw idea without structured fields.
*   **Task 6.2:** Build the promotion flow: tapping a Backlog item pre-fills the PACT Creation form (Epic 3) and deletes the backlog entry upon successful creation.
*   **Task 6.3:** Implement the Archive UI for completed PACTs. Enforce the rule that an active PACT cannot be marked as "Abandoned" until the user has logged a minimum of 10 completed trials.

## Epic 7: Notifications & Onboarding
**Goal:** Re-engagement, user education, and app polish.

*   **Task 7.1:** Integrate `flutter_local_notifications` to schedule local reminders for daily check-ins and reflection prompts.
*   **Task 7.2:** Build a beautiful, concise Onboarding flow that explains the Tiny Experiments philosophy (showing up over outcomes) to first-time users.
*   **Task 7.3:** Build the Settings page, allowing users to override their personal slot limit and toggle the auto-archive behavior for paused PACTs.
