// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation {
  final Set<Marker> markers;
  final String address;
  final List<LatLng> routeCoordinates;
  final LatLng currentLocation;
  final LatLng? destination;

  UserLocation({
    required this.markers,
    required this.address,
    required this.routeCoordinates,
    required this.currentLocation,
    this.destination,
  });

  @override
  String toString() {
    return 'UserLocation(markers: $markers, address: $address, routeCoordinates: $routeCoordinates, currentLocation: $currentLocation, destination: $destination)';
  }

  @override
  bool operator ==(covariant UserLocation other) {
    if (identical(this, other)) return true;

    return setEquals(other.markers, markers) &&
        other.address == address &&
        listEquals(other.routeCoordinates, routeCoordinates) &&
        other.currentLocation == currentLocation &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    return markers.hashCode ^
        address.hashCode ^
        routeCoordinates.hashCode ^
        currentLocation.hashCode ^
        destination.hashCode;
  }

  UserLocation copyWith({
    Set<Marker>? markers,
    String? address,
    List<LatLng>? routeCoordinates,
    LatLng? currentLocation,
    LatLng? destination,
  }) {
    return UserLocation(
      markers: markers ?? this.markers,
      address: address ?? this.address,
      routeCoordinates: routeCoordinates ?? this.routeCoordinates,
      currentLocation: currentLocation ?? this.currentLocation,
      destination: destination ?? this.destination,
    );
  }
}
