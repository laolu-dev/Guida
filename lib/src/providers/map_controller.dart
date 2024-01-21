import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:guida/src/models/position_model.dart';
import 'package:guida/src/providers/providers.dart';

class CurrentLocationNotifier extends AsyncNotifier<PositionModel?> {
  @override
  FutureOr<PositionModel?> build() async {
    try {
      final userPosition = await Geolocator.getCurrentPosition();
      return PositionModel(
          latitude: userPosition.latitude, longitude: userPosition.longitude);
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }
}

class MarkersNotifier extends Notifier<Set<Marker>> {
  @override
  build() {
    Set<Marker> markers = {};
    final location = ref.watch(currentLocationController).value;
    final currentLocationMarker = Marker(
      markerId: const MarkerId("Current Location"),
      infoWindow: const InfoWindow(title: "You"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position:
          LatLng(location?.latitude ?? 0.00, location?.longitude ?? 0.000),
    );
    markers.add(currentLocationMarker);
    return markers;
  }

  void addMarker(LatLng coordinates) {
    final newMarker = Marker(
      markerId: const MarkerId("Marker"),
      infoWindow: const InfoWindow(title: "You"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: LatLng(coordinates.latitude, coordinates.longitude),
    );
    state.add(newMarker);
  }
}

class AddressNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() async {
    try {
      final location = ref.watch(currentLocationController).value;
      List<Placemark> p = await placemarkFromCoordinates(
          location?.latitude ?? 0.00, location?.longitude ?? 0.00);
      Placemark place = p[0];
      return "${place.subThoroughfare},${place.thoroughfare}";
    } catch (e) {
      debugPrint("$e");
      return "";
    }
  }

}
