import 'package:tiny_experiments/features/pact/domain/models/pact.dart';

class TemperatureDataPoint {
  final DateTime loggedAt;
  final CuriosityTemperature temperature;

  const TemperatureDataPoint(this.loggedAt, this.temperature);
}

class ReflectionMetrics {
  final double? averageTemperature;
  final List<TemperatureDataPoint> temperatureOverTime;
  final int intentionCount;
  final int formalReflectionCount;

  const ReflectionMetrics({
    required this.averageTemperature,
    required this.temperatureOverTime,
    required this.intentionCount,
    required this.formalReflectionCount,
  });
}
