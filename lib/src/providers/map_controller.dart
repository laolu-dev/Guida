import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      Uint8List image = await _getBytesFromAssets('assets/user.png');
      final position = await Geolocator.getCurrentPosition();

      final userMarker = Marker(
        markerId: const MarkerId("Current Location"),
        infoWindow: const InfoWindow(title: "You"),
        icon: BitmapDescriptor.fromBytes(image),
        position: LatLng(position.latitude, position.longitude),
      );

      List<Placemark>? p =
          await _getUserCurrentAddress(position.latitude, position.longitude);

      return userLocation.copyWith(
        markers: {userMarker},
        address: "${p?.first.name}, ${p?.first.street}",
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

    Uint8List image = await _getBytesFromAssets('assets/pin.png');
    List<LatLng> routes = [];

    try {
      final targetLocation =
          await locationFromAddress(destination, localeIdentifier: 'en_NG');

      routes = await _drawRouteLine(
        oldState.currentLocation.latitude,
        oldState.currentLocation.longitude,
        targetLocation.first.latitude,
        targetLocation.first.longitude,
      );

      if (oldState.markers.length > 1 && oldState.routeCoordinates.isNotEmpty) {
        oldState.markers.remove(oldState.markers.last);
        oldState.routeCoordinates.clear();
      }

      state = AsyncData(
        oldState.copyWith(
          destination: LatLng(
            targetLocation.first.latitude,
            targetLocation.first.longitude,
          ),
          markers: {
            ...oldState.markers,
            _addMarker(
              destination,
              targetLocation.first.latitude,
              targetLocation.first.longitude,
              image,
            ),
          },
          routeCoordinates: routes,
        ),
      );
      debugPrint(routes.toString());
    } catch (e) {
      state = AsyncError("Marker error: $e", StackTrace.current);
    }
  }

  Future<Uint8List> _getBytesFromAssets(String imagePath) async {
    ByteData imageData = await rootBundle.load(imagePath);
    ui.Codec codec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetHeight: 100,
      targetWidth: 100,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<List<Placemark>?> _getUserCurrentAddress(
      double lat, double lng) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(lat, lng, localeIdentifier: "en_NG");

      return placemarks;
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  Future<List<LatLng>> _drawRouteLine(
      double startLat, double startLng, double endLat, double endLng) async {
    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        GuidaConstants.getApiKey(),
        PointLatLng(startLat, startLng),
        PointLatLng(endLat, endLng),
      );

      if (result.points.isNotEmpty) {
        for (var coordinates in result.points) {
          points.add(LatLng(coordinates.latitude, coordinates.longitude));
        }
      }

      return points;
    } catch (e) {
      debugPrint("$e");
      return [];
    }
  }

  Marker _addMarker(String id, double lat, double lng, Uint8List image) {
    return Marker(
      markerId: MarkerId("Marker $id"),
      infoWindow: const InfoWindow(title: "Your destination"),
      icon: BitmapDescriptor.fromBytes(image),
      position: LatLng(lat, lng),
    );
  }
}
