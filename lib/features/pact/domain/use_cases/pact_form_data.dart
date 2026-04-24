import '../models/pact.dart';

class PactFormData {
  final String action;
  final PactCadence cadence;
  final int durationTrials;
  final DateTime startDate;
  final String? ifCondition;
  final String? thenAction;
  final String? hypothesis;
  final CuriosityTemperature? temperature;
  final int? reflectionIntervalTrials;

  const PactFormData({
    required this.action,
    required this.cadence,
    required this.durationTrials,
    required this.startDate,
    this.ifCondition,
    this.thenAction,
    this.hypothesis,
    this.temperature,
    this.reflectionIntervalTrials,
  });
}
