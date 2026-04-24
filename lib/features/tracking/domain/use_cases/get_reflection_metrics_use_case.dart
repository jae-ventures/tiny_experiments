import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/reflection.dart';
import '../models/reflection_metrics.dart';

final getReflectionMetricsUseCaseProvider =
    Provider<GetReflectionMetricsUseCase>((_) => const GetReflectionMetricsUseCase());

class GetReflectionMetricsUseCase {
  const GetReflectionMetricsUseCase();

  ReflectionMetrics execute(List<Reflection> reflections) {
    final withTemp = reflections.where((r) => r.temperature != null).toList()
      ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

    final double? averageTemp = withTemp.isEmpty
        ? null
        : withTemp
                .map((r) => r.temperature!.index.toDouble())
                .reduce((a, b) => a + b) /
            withTemp.length;

    final temperatureOverTime = withTemp
        .map((r) => TemperatureDataPoint(r.loggedAt, r.temperature!))
        .toList();

    final intentionCount = reflections.where((r) => r.intention != null).length;
    final formalCount = reflections.where((r) => r.kind == ReflectionKind.formal).length;

    return ReflectionMetrics(
      averageTemperature: averageTemp,
      temperatureOverTime: temperatureOverTime,
      intentionCount: intentionCount,
      formalReflectionCount: formalCount,
    );
  }
}
