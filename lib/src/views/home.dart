import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/src/bloc/events.dart';
import 'package:guida/src/bloc/geolocator_bloc.dart';
import 'package:guida/src/bloc/state.dart';

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
    // final geolocator = BlocProvider.of<GeolocatorBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Guida"),
      ),
      body: Column(
        children: [
          Flexible(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(target: LatLng(0, 0)),
              onCameraMove: (postion) {},
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                // _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
    
          await _controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(3.444, 10.222),
                zoom: 20
              ),
            ),
          );
        },
        child: const Icon(Icons.location_on),
      ),
    );
  }
}
