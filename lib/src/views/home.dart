import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/constants/color.dart';
import 'package:guida/constants/constants.dart';
import 'package:guida/services/dio.dart';
import 'package:guida/src/models/places_model.dart';
import 'package:guida/src/providers/providers.dart';
import 'package:guida/src/widgets/button.dart';

import 'package:guida/src/widgets/textfield.dart';
import 'package:guida/src/widgets/view_widget.dart';

import 'package:guida/util/helpers.dart';
import 'package:ionicons/ionicons.dart';
import 'package:uuid/uuid.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late GoogleMapController _controller;
  late final TextEditingController _from;
  late final TextEditingController _to;
  bool _showListOne = false;
  late String sessionToken = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    _from = TextEditingController();
    _to = TextEditingController();

    _to.addListener(() => _searchPlaces());
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
                            MapTextField(
                              controller: _from,
                              hint: "From:",
                              onTap: () => setState(() {
                                _showListOne = !_showListOne;
                              }),
                            ),
                            // _showListOne
                            //     ? Flexible(
                            //         child: ListView.builder(
                            //           itemCount: ref
                            //               .watch(placesController(_from.text))
                            //               .value
                            //               ?.predictions
                            //               .length,
                            //           itemBuilder: (context, index) {
                            //             return ListTile(
                            //                 title: Text(
                            //               "${ref.watch(placesController(_from.text)).value?.predictions[index].description}",
                            //             ));
                            //           },
                            //         ),
                            //       )
                            //     : const SizedBox(),
                            SizedBox(height: 16.h),
                            // ref.watch(placesController(_to.text)).hasValue
                            //     ? Flexible(
                            //         child: ListView.builder(
                            //           itemCount: ref
                            //               .watch(placesController(_to.text))
                            //               .value
                            //               ?.predictions
                            //               .length,
                            //           itemBuilder: (context, index) {
                            //             return ListTile(
                            //               title: Text(
                            //                 "${ref.watch(placesController(_from.text)).value?.predictions[index].description}",
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       )
                            //     : const SizedBox(),
                            MapTextField(controller: _to, hint: "To:"),
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
                    const RSizedBox(width: 6),
                    GuidaMapButton(
                      icon: Ionicons.car_outline,
                      onTap: () {},
                    ),
                    const RSizedBox(width: 6),
                    GuidaMapButton(
                      icon: Ionicons.bus_outline,
                      onTap: () {},
                    ),
                    const RSizedBox(width: 6),
                    GuidaMapButton(
                      icon: Ionicons.locate,
                      onTap: userLocation.value != null
                          ? () => _moveCameraToUser(
                                userLocation.value!.currentLocation.latitude,
                                userLocation.value!.currentLocation.longitude,
                              )
                          : () => _showAlert("Cannot determine user location"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Flexible(
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
                Padding(
                padding: REdgeInsets.only(top: .66.sh, left: 20, right: 20),
                  child: GuidaButton(
                    name: "Go",
                    action: userLocation.isLoading
                        ? null
                        : () {
                            _changeCameraToDestination();
                            _controlCamera(userLocation.value!.destination);
                          },
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

  void _searchPlaces() async {
    try {
      final response = await GuidaApiService.dio.get(
        "?input=${_to.text}&key=${GuidaConstants.getApiKey()}&sessiontoken=$sessionToken",
      );
      var a = PlacesModel.fromJson(response.data);
      debugPrint(a.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showAlert(String message) {
    Helpers.showInAppAlertError(context, message);
  }
}
