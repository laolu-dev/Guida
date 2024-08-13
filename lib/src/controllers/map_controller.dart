import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guida/constants/enums.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/constants/images.dart';
import 'package:guida/src/controllers/map_route_controller.dart';

import 'package:guida/util/helpers.dart';
import '../models/location_state/location_state.dart';

class _LocationStateNotifier extends AutoDisposeAsyncNotifier<LocationState> {
  @override
  FutureOr<LocationState> build() async {
    final init = await Geolocator.getLastKnownPosition();
    final userLocation = LocationState(
      distance: 0,
      address: "",
      markers: {},
      route: {},
      currentLocation:
          LatLng(init?.latitude ?? 6.5166646, init?.longitude ?? 3.38499846),
    );

    try {
      final Position position = await Geolocator.getCurrentPosition();
      final Uint8List image = await Helpers.getBytesFromAssets(Images.user);

      final userMarker = Helpers.configureMarker(
          "You", position.latitude, position.longitude, image, "You");

      debugPrint("Current position: ${position.toString()}");

      List<Placemark>? p = await Helpers.getCurrentAddress(
          position.latitude, position.longitude);

      debugPrint(p?.first.toString());

      return userLocation.copyWith(
        markers: {userMarker},
        address:
            "${p?.first.name} ${p?.first.street} ${p?.first.thoroughfare} ${p?.first.locality} ${p?.first.subAdministrativeArea}",
        currentLocation: LatLng(position.latitude, position.longitude),
      );
    } catch (e) {
      debugPrint(e.toString());
      state = AsyncError("$e", StackTrace.current);
      return userLocation;
    }
  }

  void placeDestinationMarker(String address) async {
    state = const AsyncLoading();
    final oldState = state.value!;
    List<LatLng> routes = [];
    Uint8List destinationImage =
        await Helpers.getBytesFromAssets('assets/pin.png');

    try {
      final destination = await locationFromAddress(address);

      routes = await Helpers.drawRouteLine(
        oldState.currentLocation.latitude,
        oldState.currentLocation.longitude,
        destination.first.latitude,
        destination.first.longitude,
      );

      if (oldState.markers.length > 1 && oldState.route.isNotEmpty) {
        oldState.markers.remove(oldState.markers.last);
        oldState.route.clear();
      }

      double minY =
          (oldState.currentLocation.latitude <= destination.first.latitude)
              ? oldState.currentLocation.latitude
              : destination.first.latitude;
      double minX =
          (oldState.currentLocation.longitude <= destination.first.longitude)
              ? oldState.currentLocation.longitude
              : destination.first.longitude;

      double maxY =
          (oldState.currentLocation.latitude <= destination.first.latitude)
              ? destination.first.latitude
              : oldState.currentLocation.latitude;
      double maxX =
          (oldState.currentLocation.longitude <= destination.first.longitude)
              ? destination.first.longitude
              : oldState.currentLocation.longitude;

      state = AsyncData(
        oldState.copyWith(
          destination:
              LatLng(destination.first.latitude, destination.first.longitude),
          distance: Helpers.calculateDistance(
              oldState.currentLocation.latitude,
              oldState.currentLocation.longitude,
              destination.first.latitude,
              destination.first.longitude),
          bounds: LatLngBounds(
            northeast: LatLng(maxY, maxX),
            southwest: LatLng(minY, minX),
          ),
          markers: {
            ...oldState.markers,
            Helpers.configureMarker("Destination", destination.first.latitude,
                destination.first.longitude, destinationImage),
          },
          route: {
            Helpers.configureRouteLine("route", routes),
          },
        ),
      );
    } catch (e) {
      debugPrint("$e");
      state = AsyncError("Marker error: $e", StackTrace.current);
    }
  }

  void setMode(TransportMode mode) async {
    final oldState = state.value!;

    final Uint8List image = await Helpers.getBytesFromAssets(switch (mode) {
      TransportMode.walking => Images.walking,
      TransportMode.car => Images.car,
    });

    oldState.markers.removeWhere((marker) => marker.markerId.value == "You");

    final userMarker = Helpers.configureMarker(
      "Current Location",
      oldState.currentLocation.latitude,
      oldState.currentLocation.longitude,
      image,
      "You",
    );

    state = AsyncData(
      state.value!.copyWith(markers: {...oldState.markers, userMarker}),
    );
  }

  void start() async {
    final oldState = state.value!;

    Geolocator.getPositionStream().listen((position) async {
      double distance = Helpers.calculateDistance(
          position.latitude,
          position.longitude,
          state.value!.destination!.latitude,
          state.value!.destination!.longitude);

      double bearing = Helpers.calculateBearing(
          position.latitude,
          position.longitude,
          state.value!.destination!.latitude,
          state.value!.destination!.longitude);

      debugPrint("New Position: ${position.toString()}");
      debugPrint("New Distance: ${distance.toString()}");

      List<LatLng> routes = await Helpers.drawRouteLine(
          position.latitude,
          position.longitude,
          state.value!.destination!.latitude,
          state.value!.destination!.longitude);

      if (oldState.route.isNotEmpty) {
        oldState.route.clear();
      }

      final mode = ref.read(transportModeController);
      final Uint8List image = await Helpers.getBytesFromAssets(switch (mode) {
        TransportMode.walking => Images.walking,
        TransportMode.car => Images.car,
      });

      oldState.markers.first.copyWith(
        iconParam: BytesMapBitmap(image),
        positionParam: LatLng(position.latitude, position.longitude),
      );

      state = AsyncData(state.value!.copyWith(
        markers: {...oldState.markers},
        route: {Helpers.configureRouteLine("route", routes)},
      ));

      ref.read(mapRouteStateController.notifier).update(
            distance,
            LatLng(position.latitude, position.longitude),
            bearing,
          );
    });
  }

  void cancel() async {
    await Geolocator.getPositionStream().listen((positon) {}).cancel();
  }
}

final locationStateController =
    AutoDisposeAsyncNotifierProvider<_LocationStateNotifier, LocationState>(
        _LocationStateNotifier.new);

final transportModeController =
    StateProvider<TransportMode>((ref) => TransportMode.walking);
