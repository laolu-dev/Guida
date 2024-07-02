import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/constants.dart';
import '../../services/dio.dart';

import 'package:uuid/uuid.dart';

import '../models/place/place_model/places_model.dart';

class PlacesNotifier extends FamilyAsyncNotifier<PlacesModel?, String> {
  @override
  FutureOr<PlacesModel?> build(arg) async {
    final String token = const Uuid().v4();
    state = const AsyncLoading();
    try {
      final response = await GuidaMapAPI.dio.get(
          "?input=$arg&key=${GuidaConstants.getApiKey()}&sessiontoken=$token");
          
      state = AsyncData(PlacesModel.fromJson(response.data));
      return PlacesModel.fromJson(response.data);
    } catch (e) {
      state = AsyncError("$e", StackTrace.current);
      return null;
    }
  }
}
