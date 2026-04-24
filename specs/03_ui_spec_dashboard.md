# UI Design Spec: Dashboard (Home Screen)

**Feature:** `dashboard`
**Version:** 0.2 (Draft)
**Last Updated:** 2026-04-21
**Depends on:** `pact`, `backlog`, `tracking`, `reflection`

---

## 1. Philosophy

The home screen is the emotional core of the app. Its job is not to show a to-do list — it is to evoke a sense of **open possibility** and make the daily check-in feel effortless. A user should be able to open the app, check in, and close it in under 10 seconds. Everything else is secondary.

The visual language of the screen should communicate the app's philosophy without text: curiosity is spacious, possibility is abundant, commitment is focused.

---

## 2. Screen Structure

The screen is divided into three vertical regions:

```
┌─────────────────────────────────┐
│                                 │
│       POSSIBILITY SPACE         │  ~55% of screen height
│   (dots: slots + backlog)       │
│                                 │
├─────────────────────────────────┤
│   ← PACT CARD CAROUSEL →        │  ~35% of screen height
│   [ name | chart | check-in ]   │
│         • • •  (page dots)      │
├─────────────────────────────────┤
│           ≡  (action btn)       │  ~10% of screen height
└─────────────────────────────────┘
```

There is no navigation bar. There are no tabs. The entire app is navigated from this single screen and the action button.

---

## 3. Possibility Space

### 3.1 Overview

The upper portion of the home screen is an open canvas populated by two types of dots. They coexist in the same space organically — not on a grid, not in rows. The layout should feel like a light scatter, not a list.

### 3.2 Slot Dots (Large)

Slot dots represent the user's earned capacity for active experimentation.

| State | Visual |
|---|---|
| **Empty slot** | Large dot, muted/gray, soft glow, gently pulsing animation |
| **Active slot** | Large dot, vivid color (unique per PACT), steady or slow-breathing animation |
| **Locked slot** | Not visible — locked slots do not appear in the space at all |

- Maximum of 4 slot dots ever visible (reflecting the hard progression cap)
- A brand-new user sees exactly **one** large dot — gray, pulsing, waiting
- New slot dots appear as they are unlocked through progression — their arrival could be a small celebratory animation (dot materializes / blooms into place)
- Each active slot dot's color corresponds to the color identity of the PACT occupying it, creating a visual link between the dot and the card below
- Slot dots are **tappable**:
  - Empty slot dot → opens PACT creation flow
  - Active slot dot → opens a PACT summary / breakdown view (post-MVP: quick stats, session history at a glance)

### 3.3 Backlog Dots (Small)

Backlog dots represent captured ideas that are not yet active experiments.

| State | Visual |
|---|---|
| **Backlog item** | Small dot, desaturated/dim color, slow drift animation |

- No hard limit on count — the space can hold many backlog dots
- Their smaller size and lower visual weight ensures they do not compete with slot dots for attention
- The organic scatter means many backlog dots feel like stars or ambient particles rather than a list of obligations — reinforcing that there is no pressure to act on them
- Backlog dots are **tappable** → opens the backlog item detail, with options to promote to PACT or edit/delete the idea
- If a user has no backlog items and no active PACTs, the space is mostly empty — intentionally. The emptiness is an invitation, not a failure state.

### 3.4 Animation Principles

The possibility space is alive. Dots move continuously and independently, giving the screen an organic, breathing quality even when nothing is happening. This is not decorative — it reinforces the idea that curiosity is always in motion.

**Dot movement:**
- All dots drift slowly and continuously through the space, each on its own independent path and rhythm. Slot dots move more slowly and with more gravitas than backlog dots. Backlog dots are lighter, more restless.
- Dots do not leave a defined boundary region — they wander within the possibility space and gently curve back inward if they approach the edges.
- Dots do not collide or repel each other; they pass through loosely, like particles in a slow current.

**Tap and hold — freeze:**
- A tap-and-hold gesture anywhere in the possibility space **pauses all dot movement** for the duration of the hold, plus a brief settle period after release (~1–2 seconds). During the pause, dots sit still and the space feels considered and calm — like catching a thought mid-flight.
- This also serves as a practical affordance: if a user wants to tap a small backlog dot precisely, holding first freezes the field so the target is stationary.
- On release, dots resume movement with a gentle ease-in, as if waking back up.

**Specific dot animations:**
- **Empty slot dots** — slow pulse (scale ~1.0 → 1.08, ~3s loop) with a faint radial glow; drift is the slowest of all dots
- **Active slot dots** — gentle breathing at a slightly different rhythm, color-filled; drift is slow and deliberate
- **Backlog dots** — faster drift relative to slot dots, subtly flickering opacity to feel like distant lights
- **New slot unlock** — dot blooms into existence from 0 scale with a brief radial burst, then joins the drift
- **New PACT created** — when the user returns to the dashboard after creation, the slot dot that now represents the new PACT plays a brief "arrival" flash: it pulses once through its full palette color (scale 1.0 → 1.15 → 1.0, opacity 1.0 → 0.6 → 1.0, ~600 ms). This confirms which dot is "theirs" and which color belongs to the new experiment. The animation plays once on first render after navigation and does not repeat.
- **PACT completion** — slot dot pulses brightly through its PACT color once, then fades to gray and resumes its empty idle state

All animations must respect the system-level `reduceMotion` accessibility setting. When enabled, all drift and pulse animations are replaced with static positions and states. The tap-and-hold freeze gesture is also disabled in this mode.

### 3.5 Tapping Empty Space

Tapping anywhere in the possibility space that is not a dot triggers PACT creation if a slot is available, or surfaces a "no slots available" message (with a brief explanation of the progression system) if all slots are filled. This makes the entire upper zone feel interactive and alive.

---

## 4. PACT Card Carousel

### 4.1 Overview

The lower section of the home screen shows a horizontally swipeable carousel of active PACT cards. Only active PACTs appear here — one card per active PACT, in order of creation date. A new user with one active PACT sees one card and no swipe affordance.

Page indicator dots sit below the carousel. They are minimal — small, not labeled.

### 4.2 Card Anatomy

Each card contains:

```
┌──────────────────────────────────────┐
│  PACT Name               [color dot] │  ← Header
├─────────────────┬────────────────────┤
│                 │                    │
│  Progress Chart │    Check-in        │  ← Body
│  (trial grid /  │    Button          │
│   calendar)     │    (circle)        │
│                 │                    │
├─────────────────┴────────────────────┤
│  [ Reflect ]                         │  ← Footer
└──────────────────────────────────────┘
```

**Header**
- PACT name (truncated if long, full name on tap/detail view)
- Small colored dot matching the slot dot in the possibility space above — creates visual continuity between the two zones
- **Color is auto-assigned** from a curated palette at PACT creation time. The palette should be warm, distinct, and non-clinical — colors that feel personal rather than categorical. No two currently active PACTs share the same color; if the palette is exhausted (max 4 active), colors cycle. User color selection may be unlocked as a progression reward in a future version.

**Progress Chart (left body)**

The card chart is a compact **preview** of the fuller date-connected chart shown on the PACT detail screen. Same visual language, lower resolution — a density indicator that earns a tap.

- A compact `Wrap` grid of 10×10 px cells, one per scheduled trial
- Each cell uses a shape and color to communicate status:

| Trial status | Shape | Color |
|---|---|---|
| Completed | Circle (filled) | PACT's palette color |
| Late | Circle (filled) | PACT color at 65% opacity |
| Skipped | Square or diamond | Muted amber — desaturated, clearly "off" without being alarming |
| Pending — due today / overdue | Circle (outline only) | PACT color stroke |
| Pending — future | Circle (faint outline) | PACT color at ~15% opacity |

- Sessions from a resumed PACT are shown in a **lighter tint** of the PACT's color, creating visible color-banding between original and resumed sessions
- The chart is not interactive from the card view — tapping it opens the full PACT detail screen where each dot is date-labeled and larger

**Check-in Button (right body)**
- A prominent circular button — the primary affordance of the entire app
- States:
  - **Pending** (trial due today) → filled, colored, inviting
  - **Done** (already checked in today) → checked state, subdued, satisfied
  - **Not due today** → grayed out, not tappable (cadence-aware)
  - **Overdue** (a past trial was auto-skipped and a late log is possible) → a subtle indicator that something was missed; tapping logs the most recent overdue trial as `late`
- A single tap logs the trial as completed. No confirmation dialog.
- Skipping is never a user action — it is detected automatically in the background (see tracking spec §6.3).

**Reflection Footer**
- Always visible, regardless of whether a trial is due today. Curiosity doesn't follow a schedule — an observation on an off-day is data too, and the app should welcome it. A user who did extra practice on a rest day, had an unexpected insight, or simply wants to note how they're feeling about an experiment should never be blocked from recording that.
- The footer is visually quieter than the check-in button but never hidden or collapsed.
- Contains two elements:

  1. **Curiosity temperature selector** — a compact representation of the cold → fiery spectrum. Could be rendered as a small horizontal slider, a row of 3–5 icons (❄️ · · 🔥), or a tap-to-cycle control. Tap to rate how this experiment is feeling today. The selected value is stored on the reflection entry and visualized over time in the PACT detail view.

  2. **Quick note field** — a short text input or tap-to-open note area. Offers optional template prompts on focus:
     - `+` What's working
     - `-` What isn't
     - `→` What to try next

     The plus/minus/next format borrows from retrospective practice and maps naturally to the experiment mindset. Notes are stored as a `note` field on the `Trial` entity if logged same-day as a check-in, or as a standalone `Reflection` entry if logged on a non-trial day. Off-cadence reflections are valuable — they are stored and visible in the PACT history regardless of trial status.

- Reflection entries from the footer are **informal and always optional** — distinct from the scheduled formal reflection prompts (persist/pause/pivot), which appear as a modal or dedicated screen when triggered by the trial schedule or double-skip detection.

### 4.3 Card Health Dots

Each PACT card has a layer of small floating dots that live in the card's background space — distinct from the possibility space dots above, and distinct from the progress chart. They are ambient and decorative in a healthy state, but shift character as the PACT's behavioral pattern changes.

Their visual state is driven entirely by the `CardHealthState` enum computed in the tracking domain (see tracking spec §3.4). The UI maps each state to a specific dot count, movement character, and animation style. **Transitions between states are gradual** — interpolated over several seconds rather than snapping, reflecting the rolling-window nature of the underlying data.

---

**State: `neutral`**

The experiment is ticking along. Dots are present and alive but undemanding.

- **Count:** 6 dots
- **Size:** small, uniform
- **Color:** a very low-opacity tint of the PACT's assigned color
- **Movement:** slow, independent drift — each dot wanders on its own gentle path with no particular relationship to the others. Similar in character to the backlog dots in the possibility space, but smaller and more transparent.
- **Feel:** calm background texture. The user notices them without thinking about them.

---

**State: `drifting`** *(skip ratio ≥ 0.5 in rolling window)*

Skipping is becoming a pattern. Something about this experiment may be worth reflecting on.

- **Count:** 4 dots (fewer — the space feels emptier, slightly sparse)
- **Size:** slightly larger than neutral — they take up more visual presence despite being fewer
- **Color:** higher opacity than neutral; desaturated, cooler tone within the PACT's color family
- **Movement:** faster, more erratic. Each dot changes direction more frequently and unpredictably. The overall impression is restless and unsettled — not alarming, but clearly not calm. There is no coordination between dots; they avoid each other loosely.
- **Feel:** mild visual friction. The user may not consciously register *why* the card feels different, but something feels off. This is intentional — it nudges curiosity without using words.

---

**State: `flowing`** *(≥ 3 unscheduled completions in rolling window)*

The user is showing up beyond what they committed to. This experiment has momentum.

- **Count:** 10 dots (more — the space feels full and alive)
- **Size:** small, uniform — same as neutral
- **Color:** full PACT color at moderate opacity — vivid but not overwhelming
- **Movement:** dots move in loose coordination, drifting in roughly the same direction at roughly the same speed, with small individual variations. The overall impression is a gentle current or slow murmuration. No dot perfectly mirrors another, but they feel aware of each other.

  **Implementation note for the coding agent:** Achieve this coordinated drift by giving each dot a shared base velocity vector that shifts slowly over time (e.g., rotating direction every 8–12 seconds), with each dot adding a small independent offset to that vector. This is simpler than a full flocking algorithm but produces a similar cohesive visual result. No dot-to-dot collision detection is needed — dots may overlap freely.

- **Feel:** harmonious and flowing. Noticeably different from neutral but not distracting. Worth a moment of curiosity — is the cadence right? Should this become something more committed?

---

**Transition behavior**

When `CardHealthState` changes (e.g., from `neutral` to `drifting`), the dot layer transitions gradually:

1. Dot count interpolates over ~3 seconds (dots fade in or out smoothly — never pop)
2. Movement character interpolates over ~5 seconds (speed and coordination shift gradually)
3. Color/opacity interpolates over ~4 seconds

These durations ensure the shift is perceptible but never jarring. A user glancing at their card daily will notice the change over a couple of sessions, not in a single moment.

All card health dot animations must respect `reduceMotion`. When enabled: dots are static, count still reflects the health state, color/opacity still applies, but no movement or transition animation occurs.

---

## 5. Action Button

A single floating or docked button (hamburger / ≡ icon) in the footer region. Opens a bottom sheet or side drawer containing:

- **Curiosity Backlog** — full list of backlog items, with ability to add, edit, promote, or delete
- **Pause Drawer** — paused PACTs, with re-engagement prompts surfaced at the top if any are due
- **Archive** — completed and archived PACTs, read-only
- **Settings** — personal PACT limit, notification preferences, auto-archive toggle, theme
- **Account** (post-MVP)

The action button is the only navigation surface in the app. Everything exploratory or administrative lives here. The home screen itself stays purely focused on the present moment.

---

## 6. Empty States

| Condition | Possibility Space | Card Carousel |
|---|---|---|
| No active PACTs, no backlog | One large gray pulsing dot | Prompt card: "Tap the dot above to begin your first experiment" |
| No active PACTs, has backlog | One gray dot + small backlog dots | Prompt card: "You have ideas waiting — tap a dot to bring one to life" |
| All slots filled, has backlog | All slot dots colored, backlog dots present | Cards for all active PACTs; no empty-space tap affordance |
| All slots filled, no backlog | All slot dots colored, no small dots | Cards only |

Empty state copy should always be curious and inviting, never clinical or task-oriented.

---

## 7. Home Screen Widget

The widget is a simplified version of the PACT card, designed for the Android Glance / iOS WidgetKit surfaces.

**Small widget (single PACT):**
- PACT name
- Check-in button (deep-links into app on tap)
- No progress chart

**Medium widget (up to 2 PACTs):**
- Two rows, each with PACT name + check-in button

The progress chart is omitted from all widget sizes — the widget's only job is to surface the check-in action without opening the app. The possibility space and reflection footer are also omitted.

Widget state refreshes on a schedule and after any in-app check-in action.

---

## 8. Open Questions

- **Swipe-up on card for contextual actions** — deferred for later design iteration. The gesture is promising (pause, view detail, abandon) but the specific actions and their visual treatment need more thought. The concern to resolve: swipe-up conflicts with natural scroll behavior on some devices, so the gesture direction and threshold need to be intentional. An alternative is a long-press on the card body.
- **Dot layout persistence** — dots drift continuously (alive at all times), but their starting positions on first launch should be defined. Stored per-device so the space feels personal and consistent across sessions, not randomly reshuffled each open.
- Should the informal reflection footer temperature rating be pre-populated with the temperature set at PACT creation, or always start neutral and require an explicit selection each time?
