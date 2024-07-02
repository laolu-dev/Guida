import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/src/models/faculty.dart';
import '../../services/dio.dart';

class _LocationDataNotifier extends AsyncNotifier<List<Faculty>> {
  @override
  Future<List<Faculty>> build() async {
    state = const AsyncLoading();
    try {
      final response =
          await GuidaSheetAPI.dio.get("${GuidaConstants.deploymentID}/exec");

      debugPrint(response.data);
      state = AsyncData([Faculty.fromJson(response.data["data"])]);
      return state.value!;
    } catch (e) {
      state = AsyncError("$e", StackTrace.current);
      return [];
    }
  }
}

final locationDataController =
    AsyncNotifierProvider<_LocationDataNotifier, List<Faculty>>(
        _LocationDataNotifier.new);
