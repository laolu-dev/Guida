import 'dart:ui' as ui;

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/color.dart';
import '../constants/constants.dart';
import '../src/widgets/loading_widget.dart';

final navigatorKey =
    Provider<GlobalKey<NavigatorState>>((ref) => GlobalKey<NavigatorState>());

class Helpers {
  static Future<Uint8List> getBytesFromAssets(String imagePath) async {
    ByteData imageData = await rootBundle.load(imagePath);

    ui.Codec codec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetHeight: 28,
      targetWidth: 28,
    );

    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  static double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng)
        .roundToDouble();
  }

  static Marker configureMarker(
    String id,
    double lat,
    double lng,
    Uint8List image, [
    String? infoWindow,
  ]) {
    return Marker(
      markerId: MarkerId(id),
      infoWindow: InfoWindow(title: infoWindow ?? "Your destination"),
      icon: BitmapDescriptor.bytes(image),
      position: LatLng(lat, lng),
    );
  }

  static Polyline configureRouteLine(String polylineId, List<LatLng> points) {
    return Polyline(
      width: 6,
      polylineId: PolylineId(polylineId),
      points: points,
      color: GuidaColors.red.withOpacity(.7),
    );
  }

  static String distanceCalculator(double distance) {
    return switch (distance) {
      >= 1000 => "${(distance / 1000).toStringAsFixed(2)}km",
      < 1000 => "${(distance).toStringAsFixed(0)}m",
      _ => "",
    };
  }

  static double calculateBearing(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    return Geolocator.bearingBetween(startLat, startLng, endLat, endLng);
  }

  static Future<List<Placemark>?> getCurrentAddress(
      double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      return placemarks;
    } catch (e) {
      debugPrint("$e");
      return null;
    }
  }

  static Future<List<LatLng>> drawRouteLine(
      double startLat, double startLng, double endLat, double endLng) async {
    List<LatLng> points = [];
    PolylinePoints polylinePoints = PolylinePoints();

    try {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(startLat, startLng),
          destination: PointLatLng(endLat, endLng),
          mode: TravelMode.walking,
        ),
        googleApiKey: GuidaConstants.getApiKey(),
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

  static logout() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasCleared = await prefs.clear();
    debugPrint("Successfully cleared user data: $hasCleared");
  }

  static String modifyGoogleDriveLink(String originalLink) {
    // Check if the link is a valid Google Drive link
    if (!originalLink.contains('drive.google.com')) {
      throw ArgumentError('Invalid Google Drive link');
    }

    // Extract the file ID from the original link
    final regex = RegExp(r'id=([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(originalLink);
    if (match == null) {
      throw ArgumentError('No file ID found in the link');
    }

    final fileId = match.group(1);

    // Construct the new link suitable for Image.network
    final viewLink = 'https://drive.google.com/uc?export=view&id=$fileId';

    return viewLink;
  }

  static IconData? getDirectionIcon(String direction) {
    IconData? icon;

    final Map<String, IconData> icons = {
      "turn left": Icons.turn_left,
      "turn right": Icons.turn_right,
      "straight": Icons.straight,
      "shift right": Icons.roundabout_right,
      "shift left": Icons.roundabout_left
    };

    for (var i in icons.keys) {
      if (direction.toLowerCase().contains(i.toLowerCase())) {
        icon = icons[i]!;
      }
    }
    return icon;
  }

  static void navigateTo(WidgetRef ref, String destination, {Object? args}) {
    ref
        .read(navigatorKey)
        .currentState
        ?.pushNamed(destination, arguments: args);
  }

  static void navigateBack(WidgetRef ref) {
    ref.read(navigatorKey).currentState?.pop();
  }

  static void dropKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void showGuidaModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      backgroundColor: GuidaColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: MediaQuery.of(context).viewInsets,
          child: child,
        );
      },
    );
  }

  static void showGuidaLoadingModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.white,
      builder: (context) => const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center, child: Loading()),
        ],
      ),
    );
  }

  static void showInAppAlertInfo(BuildContext context, String dsc) {
    CherryToast.info(
      title: Text(
        "Info",
        style: TextStyle(
          color: GuidaColors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 500),
    ).show(context);
  }

  static void showInAppAlertSuccess(BuildContext context, String dsc) {
    CherryToast.success(
      title: Text(
        "Success",
        style: TextStyle(color: GuidaColors.black),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 1800),
      animationDuration: const Duration(milliseconds: 400),
    ).show(context);
  }

  static void showInAppAlertError(BuildContext context, String dsc) {
    CherryToast.error(
      title: Text(
        "Error",
        style: TextStyle(color: GuidaColors.black),
      ),
      description: Text(
        dsc,
        style: TextStyle(color: GuidaColors.black),
      ),
      toastDuration: const Duration(milliseconds: 1800),
      animationDuration: const Duration(milliseconds: 400),
    ).show(context);
  }
}
