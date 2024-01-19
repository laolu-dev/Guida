import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  GoogleMapController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(6.5158, 3.3898),
                zoom: 15
              ),
              myLocationEnabled: true,
              onCameraMove: (postion) {},
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
