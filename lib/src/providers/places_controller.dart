import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/services/dio.dart';
import 'package:guida/src/models/places_model.dart';

class PlacesNotifier extends FamilyAsyncNotifier<PlacesModel?, String> {
  @override
  FutureOr<PlacesModel?> build(arg) => null;

  void getPlaces(String input) async {
    state = const AsyncLoading();
    try {
      final response = await GuidaApiService.dio.get(
        "?input=$input&key=${GuidaConstants.getApiKey()}&sessiontoken=",
      );
      state = AsyncData(PlacesModel.fromJson(response.data));
    } catch (e) {
      state = AsyncError("$e", StackTrace.current);
    }
  }
}
