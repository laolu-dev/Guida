import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GuidaConstants {
  static String getApiKey() {
    if (Platform.isAndroid) {
      return dotenv.env["ANDROID_KEY"] ?? "No Android Key";
    } else if (Platform.isIOS) {
      return dotenv.env["APIKEY_iOS"] ?? "No iOS Key";
    }
    return "";
  }

  static const String baseUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  static const LatLng unilag = LatLng(6.5166646, 3.38499846);
  static const LatLng carParkOne = LatLng(6.5167, 3.3850);
}
