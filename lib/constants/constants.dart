import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static const LatLng carParkOne = LatLng(6.5167, 3.3850);
}

// final List<Faculty> facultiesData = [
//   Faculty(
//     name: "Engineering",
//     departments: [
//       Department(
//         name: "Mechanical",
//         destination: [
//           Location(
//             name: "Room 115",
//             latitude: 30,
//             longitude: 40,
//             imageUrl:
//                 "https://cdn.pixabay.com/photo/2018/07/13/19/56/st-peters-church-3536449_1280.jpg",
//             directions: ["Go Right", "Go straight", "Walk for 200m"],
//           ),
//           Location(
//             name: "Room 256",
//             latitude: 30,
//             longitude: 40,
//             imageUrl:
//                 "https://cdn.pixabay.com/photo/2023/05/04/20/37/colourful-7971057_1280.jpg",
//             directions: [],
//           ),
//           Location(
//             name: "Room 257",
//             latitude: 30,
//             longitude: 40,
//             imageUrl:
//                 "https://cdn.pixabay.com/photo/2023/12/08/05/41/cat-8436848_1280.jpg",
//             directions: [],
//           )
//         ],
//       )
//     ],
//   )
// ];
