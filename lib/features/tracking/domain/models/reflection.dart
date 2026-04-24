import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tiny_experiments/features/pact/domain/models/pact.dart';

part 'reflection.freezed.dart';

enum ReflectionKind {
  informal,   // logged from card footer, anytime
  formal,     // triggered by schedule or double-skip detection
}

enum ReflectionDecision {
  persist,  // continue as-is
  pause,    // move to Pause Drawer, free the slot
  pivot,    // end this PACT, optionally begin a successor
}

@freezed
abstract class Reflection with _$Reflection {
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
