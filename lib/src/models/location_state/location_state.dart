// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationState {
  final double distance;
  final String address;
  final LatLng currentLocation;
  final LatLng? destination;
  final LatLngBounds? bounds;
  final Set<Marker> markers;
  final Set<Polyline> route;

  LocationState({
    required this.distance,
    required this.address,
    required this.currentLocation,
    this.destination,
    this.bounds,
    required this.markers,
    required this.route,
  });

  @override
  String toString() {
    return 'LocationState(distance: $distance, address: $address, currentLocation: $currentLocation, destination: $destination, bounds: $bounds, markers: $markers, route: $route)';
  }

  @override
  bool operator ==(covariant LocationState other) {
    if (identical(this, other)) return true;

    return other.distance == distance &&
        other.address == address &&
        other.currentLocation == currentLocation &&
        other.destination == destination &&
        other.bounds == bounds &&
        setEquals(other.markers, markers) &&
        setEquals(other.route, route);
  }

  @override
  int get hashCode {
    return distance.hashCode ^
        address.hashCode ^
        currentLocation.hashCode ^
        destination.hashCode ^
        bounds.hashCode ^
        markers.hashCode ^
        route.hashCode;
  }

  LocationState copyWith({
    double? distance,
    String? address,
    LatLng? currentLocation,
    LatLng? destination,
    LatLngBounds? bounds,
    Set<Marker>? markers,
    Set<Polyline>? route,
  }) {
    return LocationState(
      distance: distance ?? this.distance,
      address: address ?? this.address,
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
      bounds: bounds ?? this.bounds,
      markers: markers ?? this.markers,
      route: route ?? this.route,
    );
  }
}
