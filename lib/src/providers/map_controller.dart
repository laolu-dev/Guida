import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/constants/constants.dart';

import 'package:guida/src/models/user_location.dart';

class UserLocationNotifier extends AutoDisposeAsyncNotifier<UserLocation> {
  @override
  FutureOr<UserLocation> build() async {
    final userLocation = UserLocation(
      markers: {},
      address: "",
      routeCoordinates: [],
      currentLocation: GuidaConstants.unilag,
    );

    try {
      BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(12, 12)), "assets/user.png");

      final position = await Geolocator.getCurrentPosition();

      final userMarker = Marker(
        markerId: const MarkerId("Current Location"),
        infoWindow: const InfoWindow(title: "You"),
        icon: markerbitmap,
        position: LatLng(position.latitude, position.longitude),
      );

      List<Placemark> p = await placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: "en_NG");

      return userLocation.copyWith(
        markers: {userMarker},
        address: "${p.first.name}, ${p.first.street}",
        currentLocation: LatLng(position.latitude, position.longitude),
      );
    } catch (e) {
      debugPrint("$e");
      state = AsyncError("$e", StackTrace.current);
      return userLocation;
    }
  }

  void placeDestinationMarker(String destination) async {
    final oldState = state.value!;
    state = const AsyncLoading();

    try {
      final endCoordinates =
          await locationFromAddress(destination, localeIdentifier: 'en_NG');

      if (oldState.markers.length > 1) {
        oldState.markers.remove(oldState.markers.last);
      }

      state = AsyncData(
        oldState.copyWith(
          destination: LatLng(
            endCoordinates.first.latitude,
            endCoordinates.first.longitude,
          ),
          markers: {
            ...oldState.markers,
            _addMarker(
              destination,
              endCoordinates.first.latitude,
              endCoordinates.first.longitude,
            ),
          },
        ),
      );
    } catch (e) {
      state = AsyncError("Marker error: $e", StackTrace.current);
    }
  }

  void drawRoute() async {
    final oldState = state.value!;
    state = const AsyncLoading();

    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GuidaConstants.getApiKey(),
        PointLatLng(
          oldState.currentLocation.latitude,
          oldState.currentLocation.longitude,
        ),
        PointLatLng(
          oldState.markers.last.position.latitude,
          oldState.markers.last.position.longitude,
        ),
      );

      debugPrint(GuidaConstants.getApiKey());
      if (result.points.isNotEmpty) {
        points.clear();
        for (var coordinates in result.points) {
          points.add(LatLng(
            coordinates.latitude,
            coordinates.longitude,
          ));
        }
      }
      state = AsyncData(oldState.copyWith(routeCoordinates: [...points]));
    } catch (e) {
      state = AsyncError("Marker error: $e", StackTrace.current);
    }
  }

  Marker _addMarker(String id, double lat, double lng) {
    return Marker(
      markerId: MarkerId("Marker $id"),
      infoWindow: const InfoWindow(title: "Your destination"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(lat, lng),
    );
  }
}
