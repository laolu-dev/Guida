import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/src/providers/providers.dart';
import 'package:guida/src/widgets/button.dart';

import 'package:guida/src/widgets/textfield.dart';
import 'package:guida/src/widgets/view_widget.dart';

import 'package:guida/util/helpers.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late GoogleMapController _controller;
  late final TextEditingController _from;
  late final TextEditingController _to;

  @override
  void initState() {
    super.initState();
    _from = TextEditingController();
    _to = TextEditingController();
  }

  @override
  void dispose() {
    _from.dispose();
    _to.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userLocation = ref.watch(userLocationController);
    return ViewWidget(
      viewBody: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 64.h, bottom: 16.h),
            color: GuidaColors.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.h, right: 12.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MapTextField(controller: _from, hint: "From:"),
                            SizedBox(height: 16.h),
                            MapTextField(controller: _to, hint: "To:")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GuidaMapButton(
                            icon: Ionicons.add_outline,
                            onTap: () => _controller
                                .animateCamera(CameraUpdate.zoomIn()),
                          ),
                          SizedBox(height: 8.h),
                          GuidaMapButton(
                            icon: Ionicons.remove_outline,
                            onTap: () => _controller
                                .animateCamera(CameraUpdate.zoomOut()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GuidaMapButton(
                      icon: Ionicons.walk_outline,
                      onTap: () {},
                    ),
                    SizedBox(width: 12.w),
                    GuidaMapButton(
                      icon: Ionicons.car_outline,
                      onTap: () {},
                    ),
                    SizedBox(width: 12.w),
                    GuidaMapButton(
                      icon: Ionicons.bus_outline,
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    zoom: 18,
                    target: GuidaConstants.unilag,
                  ),
                  myLocationEnabled: true,
                  mapToolbarEnabled: false,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: userLocation.value?.markers ?? {},
                  polylines: {
                    Polyline(
                      width: 5,
                      polylineId: const PolylineId("Route"),
                      points: userLocation.value?.routeCoordinates ?? [],
                      color: GuidaColors.black,
                    )
                  },
                  onMapCreated: (controller) {
                    _controller = controller;
                    _from.text = userLocation.value?.address ?? "";
                  },
                  // cameraTargetBounds: CameraTargetBounds(
                  //   LatLngBounds(
                  //     southwest: LatLng(03.2343, 06.2135),
                  //     northeast: LatLng(6.5158, 3.3898),
                  //   ),
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16.w, top: .62.sh),
                  child: Row(
                    children: [
                      Expanded(
                        child: GuidaButton(
                          name: "Go",
                          action: userLocation.isLoading
                              ? null
                              : () {
                                  _changeCameraToDestination();
                                  _controlCamera(
                                      userLocation.value!.destination);
                                },
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GuidaMapButton(
                          icon: Ionicons.locate,
                          onTap: userLocation.value != null
                              ? () => _moveCameraToUser(
                                    userLocation
                                        .value!.currentLocation.latitude,
                                    userLocation
                                        .value!.currentLocation.longitude,
                                  )
                              : () =>
                                  _showAlert("Cannot determine user location"))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _moveCameraToUser(double lat, double lng) async {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18.0,
        ),
      ),
    );
  }

  void _changeCameraToDestination() {
    if (_to.text.isNotEmpty) {
      ref
          .read(userLocationController.notifier)
          .placeDestinationMarker(_to.text);
      ref.read(userLocationController.notifier).drawRoute();
    } else {
      Helpers.showInAppAlertError(context, "Enter your destination");
    }
  }

  void _controlCamera(LatLng? destination) {
    if (destination != null) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: destination, zoom: 17.0),
        ),
      );
    }
  }

  void _showAlert(String message) {
    Helpers.showInAppAlertError(context, message);
  }
}
