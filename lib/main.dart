import 'package:flutter/material.dart';
import 'package:guida/app/guida.dart';
import 'package:guida/services/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GeolocatorService.instance.init();
  runApp(const GuidaApp());
}
