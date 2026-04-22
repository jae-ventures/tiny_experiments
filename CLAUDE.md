# Tiny Experiments — Agent Instructions

## Project Overview
### 1. Vision
Tiny Experiments is a mobile-first (iOS, Android) and web app that helps users explore their curiosities through structured, low-pressure experiments called PACTs. It sits at the intersection of Tiny Experiments (Anne-Laure Le Cunff) and Atomic Habits (James Clear) — prioritizing systems and curiosity over rigid goal-setting and outcome pressure.
The core philosophy: just show up. There is no pressure to perform. The repeatable trials of a PACT generate observable data that helps users make better decisions about what to persist with, pause, or pivot away from.

## Architecture Rules
- Layered architecture: Domain → Data → Presentation. Never import data or presentation from domain.
- Feature-first folder structure under lib/features/
- All domain entities use Freezed. Run build_runner after any entity change.
- All state management via Riverpod with code generation (@riverpod annotation).
- Repository pattern: abstract interface in domain/, implementation in data/.
- Error handling via Result type (fpdart). No raw exceptions across layer boundaries.
- Derived metrics are NEVER stored in the database. Compute from raw Trial/Reflection records.

## Code Generation
After modifying any file with @freezed, @riverpod, or Drift table definitions:
  dart run build_runner build --delete-conflicting-outputs

## Database
- Drift for all local persistence. See lib/core/database/ for AppDatabase.
- Platform-specific connection: NativeDatabase on mobile, WasmDatabase on web.
- All tables defined in features/<name>/data/drift/<name>_tables.dart

## Key Domain Rules (non-negotiable)
- Trials are generated in full at PACT creation and stored immediately.
- TrialStatus.skipped is ONLY set by AutoSkipDetectionUseCase, never by user action.
- The 10-trial minimum gate uses completedCount (completed + late), not skippedCount.
- CardHealthState is derived, never stored.
- Slot progression: 1 slot at start, unlock at 3/10/20 completed PACTs, hard cap of 4.

## Specs
All design decisions live in /specs/. Read the relevant spec before implementing any feature.
- 01_project_spec.md — vision, constraints, stack
- 02_feature_spec_pact.md — PACT entity, creation, slot system
- 03_ui_spec_dashboard.md — home screen, dot system, card anatomy
- 04_feature_spec_tracking.md — Trial, Reflection, auto-skip, card health