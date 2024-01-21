import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/src/providers/providers.dart';
import 'package:guida/src/widgets/button.dart';

import 'package:guida/src/widgets/textfield.dart';
import 'package:guida/src/widgets/view_widget.dart';
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
    final markers = ref.watch(markerController);
    return ViewWidget(
      viewBody: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
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
                              MapTextField(controller: _from),
                              SizedBox(height: 16.h),
                              MapTextField(controller: _to)
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
                        zoom: 16, target: GuidaConstants.unilag),
                    markers: markers,
                    mapType: MapType.satellite,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    onMapCreated: (controller) {
                      _controller = controller;
                      _from.text =
                          ref.watch(addressController).value ?? "From:";
                    },

                    // cameraTargetBounds: CameraTargetBounds(
                    //   LatLngBounds(
                    //     southwest: LatLng(03.2343, 06.2135),
                    //     northeast: LatLng(6.5158, 3.3898),
                    //   ),
                    // ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16, right: 16.w, top: .62.sh),
                    child: Row(
                      children: [
                        Expanded(
                          child: GuidaButton(
                            name: "Go",
                            action: () {},
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GuidaMapButton(
                          icon: Ionicons.locate,
                          onTap: _moveCameraToUser,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _moveCameraToUser() async {
    final currentPosition = ref.read(currentLocationController).value!;
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 17.0,
        ),
      ),
    );
  }

  void _getCoordinatesFromAddress() async {
    final coordinates = await locationFromAddress(_to.text);
  }
}
