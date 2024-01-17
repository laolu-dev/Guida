import 'package:geolocator/geolocator.dart';
import 'package:guida/app/error/app_error.dart';

class GeolocatorService {
  const GeolocatorService._internal();

  static const GeolocatorService _instance = GeolocatorService._internal();
  static GeolocatorService get instance => _instance;

  Future<void> init() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    switch (isEnabled) {
      case true:
        final permissions = await Geolocator.checkPermission();
        switch (permissions) {
          case LocationPermission.denied:
            await Geolocator.requestPermission();
          case LocationPermission.deniedForever:
            throw AppError.deniedLocationPermission();
          default:
            null;
        }
      case false:
        throw AppError.locationServiceDisabled(
            "Location Services is not enabled");
    }
  }

  Future<Position> getCurrentLocation() async =>
      await Geolocator.getCurrentPosition();
}
