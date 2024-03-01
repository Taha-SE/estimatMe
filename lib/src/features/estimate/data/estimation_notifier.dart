import 'package:app/src/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/estimation_model.dart';

class EstimationNotifier extends StateNotifier<AsyncValue<Estimation?>> {
  final Dio dio = Dio();
  EstimationNotifier() : super(const AsyncValue.data(null));

  Future<void> estimateAge(String name) async {
    state = AsyncValue.loading();
    try {
      final response =
          await dio.get(Urls.agifyUrl, queryParameters: {'name': name});
      if (response.statusCode == 200) {
        final estimation = Estimation.fromMap(response.data);
        state = AsyncValue.data(estimation);
      } else {
        state = AsyncValue.error(
            'Failed to load age estimation', StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Failed to load age estimation: $e', stackTrace);
    }
  }

  void resetEstimation() {
    state = AsyncValue.data(null);
  }
}
