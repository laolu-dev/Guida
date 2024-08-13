import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../src/models/faculty/faculty_model.dart';

class GuidaConstants {
  static String getApiKey() {
    if (Platform.isAndroid) {
      return const String.fromEnvironment("GOOGLE_PLACES_ANDROID_APIKEY");
    } else if (Platform.isIOS) {
      return const String.fromEnvironment("GOOGLE_PLACES_IOS_APIKEY");
    } else {
      return "";
    }
  }

  static const String placesApiUrl =
      String.fromEnvironment("GOOGLE_PLACES_API_URL");
  static const String googleSheetApiUrl =
      String.fromEnvironment("GOOGLE_SHEET_API_URL");
  static const String googleSheetId = String.fromEnvironment("GOOGLE_SHEET_ID");
  static const String deploymentID = String.fromEnvironment("DEPLOYMENT_ID");

  static const LatLng unilag = LatLng(6.5166646, 3.38499846);
}

final List<FacultyModel> facultiesData = [
  const FacultyModel(
    faculty: "Law",
    departments: [],
  ),
  const FacultyModel(
    faculty: "Social Science",
    departments: [],
  ),
  const FacultyModel(
    faculty: "Environmental Science",
    departments: [],
  ),
  const FacultyModel(
    faculty: "Education",
    departments: [],
  ),
  const FacultyModel(
    faculty: "Science",
    departments: [],
  )
];
