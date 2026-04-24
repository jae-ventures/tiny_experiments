import 'package:freezed_annotation/freezed_annotation.dart';

part 'pact.freezed.dart';

enum PactCadence { daily, weekly, biweekly }

enum PactStatus { active, paused, completed, abandoned }

// Maps to the Curiosity–Fiery spectrum
enum CuriosityTemperature { cold, warm, fiery }

@freezed
abstract class Pact with _$Pact {
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
