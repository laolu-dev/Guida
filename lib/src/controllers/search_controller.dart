import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/src/models/location/location_model.dart';

class _SearchNotifier extends Notifier<List<LocationModel>> {
  @override
  build() => [];

  void addSearch(LocationModel location) {
    state = [...state, location];
  }

  void clearAll() => state.clear();
}

final searchController =
    NotifierProvider<_SearchNotifier, List<LocationModel>>(_SearchNotifier.new);
