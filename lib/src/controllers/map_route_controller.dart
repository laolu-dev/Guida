import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/src/models/location_state/map_route_state.dart';

class _MapRouteStateNotifier extends Notifier<MapRouteState?> {
  @override
  build() => null;

  // void update(double distance, LatLng location, double bearing) {
  //   state =
  //       MapRouteState(distance: distance, location: location, bearing: bearing);
  // }
}

final mapRouteStateController =
    NotifierProvider<_MapRouteStateNotifier, MapRouteState?>(
        _MapRouteStateNotifier.new);
