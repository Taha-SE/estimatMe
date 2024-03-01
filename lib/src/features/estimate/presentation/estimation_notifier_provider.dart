import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/estimation_notifier.dart';
import '../domain/estimation_model.dart';

final estimationNotifierProvider =
    StateNotifierProvider<EstimationNotifier, AsyncValue<Estimation?>>((ref) {
  return EstimationNotifier();
});
