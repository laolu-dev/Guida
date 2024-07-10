import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../src/models/faculty/faculty_model.dart';

class GuidaConstants {
  static const String placesApiUrl = String.fromEnvironment("placesApiUrl");
  static String getApiKey() {
    if (Platform.isAndroid) {
      return const String.fromEnvironment("androidApiKey");
    } else if (Platform.isIOS) {
      return const String.fromEnvironment("iosApiKey");
    } else {
      return "";
    }
  }

  static const String sheetBaseUrl = String.fromEnvironment("googleSheetUrl");
  static const String sheetId = String.fromEnvironment("sheetId");
  static const String deploymentID = String.fromEnvironment("deploymentId");

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
