import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/constants.dart';
import '../../services/dio.dart';

import 'package:uuid/uuid.dart';

import '../models/place/place_model/places_model.dart';

class _PlacesNotifier extends AsyncNotifier<PlacesModel?> {
  _PlacesNotifier(this.arg);

  final String arg;
  @override
  FutureOr<PlacesModel?> build() async {
    final String token = const Uuid().v4();
    state = const AsyncLoading();
    try {
      final response = await GuidaMapAPI.dio.get(
          "?input=$arg&components=country:ng&key=${GuidaConstants.getApiKey()}&sessiontoken=$token");

      state = AsyncData(PlacesModel.fromJson(response.data));
      return PlacesModel.fromJson(response.data);
    } catch (error, stack) {
      state = AsyncError("$error", stack);
      return null;
    }
  }
}

final placesController =
    AsyncNotifierProvider.family<_PlacesNotifier, PlacesModel?, String>(
        _PlacesNotifier.new);
