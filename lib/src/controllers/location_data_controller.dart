import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/src/models/faculty/faculty_model.dart';
import '../../services/dio.dart';

class _LocationDataNotifier extends AsyncNotifier<List<FacultyModel>?> {
  @override
  Future<List<FacultyModel>?> build() async {
    state = const AsyncLoading();
    List<FacultyModel> mockData = facultiesData;

    try {
      final response =
          await GuidaSheetAPI.dio.get("${GuidaConstants.deploymentID}/exec");

      final data = <FacultyModel>[
        for (var i in response.data["data"]) FacultyModel.fromJson(i)
      ];

      mockData = [...data, ...mockData];
      state = AsyncData(mockData);

      return mockData;
    } catch (e) {
      debugPrint("Error: ${e.toString()} \n StackTrace: ${StackTrace.current}");
      state = AsyncError("$e", StackTrace.current);
      return mockData;
    }
  }
}

final locationDataController =
    AsyncNotifierProvider<_LocationDataNotifier, List<FacultyModel>?>(
        _LocationDataNotifier.new);
