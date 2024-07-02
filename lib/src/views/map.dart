import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ionicons/ionicons.dart';

import '../../constants/color.dart';
import '../../constants/constants.dart';
import '../../util/helpers.dart';
import '../controllers/providers.dart';
import '../widgets/button.dart';
import '../widgets/modals.dart';
import '../widgets/search_address_delegate.dart';
import '../widgets/textfield.dart';
import '../widgets/view_widget.dart';

class GuidaMapView extends ConsumerStatefulWidget {
  const GuidaMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuidaMapViewState();
}

class _GuidaMapViewState extends ConsumerState<GuidaMapView> {
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

    ref.listen(userLocationController, (_, state) {
      state.when(
        data: (location) => _controlCamera(location.destination),
        error: (error, stacktrace) => _showAlert("$error"),
        loading: () {},
      );
    });

    return ViewWidget(
      viewBody: SizedBox(
        height: 1.sh,
        width: 1.sh,
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
                  width: 2,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 64.h, bottom: 16.h),
                  color: GuidaColors.grey.withOpacity(.7),
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
                                  MapTextField(
                                    controller: _from,
                                    hint: "From:",
                                    onTap: () async {
                                      final location = await showSearch<String>(
                                        context: context,
                                        delegate: AddressSearch(),
                                        query: userLocation.value?.address,
                                      );
                                      setState(() => _from.text = "$location");
                                    },
                                  ),
                                  SizedBox(height: 16.h),
                                  MapTextField(
                                    controller: _to,
                                    hint: "To:",
                                    onTap: () async {
                                      final location = await showSearch(
                                        context: context,
                                        delegate: AddressSearch(),
                                      );
                                      setState(() => _to.text = "$location");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                MapViewButton(
                                  icon: Ionicons.add_outline,
                                  onTap: () => _controller
                                      .animateCamera(CameraUpdate.zoomIn()),
                                ),
                                SizedBox(height: 8.h),
                                MapViewButton(
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
                      Visibility(
                        visible: userLocation.hasValue,
                        child: Text(
                          "Distance: ${userLocation.value?.distance}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MapViewButton(
                            icon: Ionicons.walk_outline,
                            // onTap: () => Helpers.showGuidaModal(
                            //     context, const WalkModal()),
                          ),
                          const RSizedBox(width: 6),
                          MapViewButton(
                            icon: Ionicons.car_outline,
                            onTap: () => Helpers.showGuidaModal(
                                context, const CarModal()),
                          ),
                          const RSizedBox(width: 6),
                          MapViewButton(
                            icon: Ionicons.locate,
                            onTap: userLocation.value != null
                                ? () => _focusOnUser(
                                      userLocation
                                          .value!.currentLocation.latitude,
                                      userLocation
                                          .value!.currentLocation.longitude,
                                    )
                                : () => _showAlert(
                                    "Cannot determine user location"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: REdgeInsets.only(bottom: 42, left: 24, right: 24),
                  child: GuidaButton(
                    name: "Go",
                    action: userLocation.isLoading ? null : () => _mapRoute(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _focusOnUser(double lat, double lng) async {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18.0,
        ),
      ),
    );
  }

  void _mapRoute() {
    if (_to.text.isNotEmpty) {
      ref
          .read(userLocationController.notifier)
          .placeDestinationMarker(_to.text);
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
