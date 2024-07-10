// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRouteState {
  final double distance;
  final double bearing;
  final LatLng location;

  MapRouteState({
    required this.distance,
    required this.bearing,
    required this.location,
  });

  MapRouteState copyWith({
    double? distance,
    double? bearing,
    LatLng? location,
  }) {
    return MapRouteState(
      distance: distance ?? this.distance,
      bearing: bearing ?? this.bearing,
      location: location ?? this.location,
    );
  }

  @override
  String toString() => 'MapRouteState(distance: $distance, bearing: $bearing, location: $location)';

  @override
  bool operator ==(covariant MapRouteState other) {
    if (identical(this, other)) return true;
  
    return 
      other.distance == distance &&
      other.bearing == bearing &&
      other.location == location;
  }

  @override
  int get hashCode => distance.hashCode ^ bearing.hashCode ^ location.hashCode;
}
