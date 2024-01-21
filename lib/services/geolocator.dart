import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guida/src/models/position_model.dart';

class GeolocatorService {
  const GeolocatorService._internal();
  static const GeolocatorService _instance = GeolocatorService._internal();
  static GeolocatorService get instance => _instance;

  void init() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    switch (isEnabled) {
      case true:
        _checkPermissions();
        break;
      case false:
        await Geolocator.openLocationSettings();
        break;
    }
  }

  void _checkPermissions() async {
    final permissions = await Geolocator.checkPermission();
    switch (permissions) {
      case LocationPermission.denied:
        await Geolocator.requestPermission();
      case LocationPermission.deniedForever:
        await Geolocator.openAppSettings();
      default:
        null;
    }
  }
}
