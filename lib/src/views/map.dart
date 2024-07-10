import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/src/controllers/map_route_controller.dart';

import '../../constants/color.dart';
import '../../constants/constants.dart';
import '../../constants/enums.dart';
import '../../util/helpers.dart';
import '../controllers/map_controller.dart';
import '../widgets/button.dart';
import '../widgets/dialog.dart';
import 'search_places.dart';
import '../widgets/textfield.dart';
import '../widgets/view_widget.dart';

class GuidaMapView extends ConsumerStatefulWidget {
  const GuidaMapView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GuidaMapViewState();
}

class _GuidaMapViewState extends ConsumerState<GuidaMapView>
    with SingleTickerProviderStateMixin {
  late GoogleMapController _controller;
  late AnimationController _animController;
  late bool _startedRoute;
  late final TextEditingController _to;

  @override
  void initState() {
    super.initState();
    _startedRoute = false;
    _animController = AnimationController(vsync: this);
    _to = TextEditingController();
  }

  @override
  void dispose() {
    _to.dispose();
    _animController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationStateController);
    final mapRouteState = ref.watch(mapRouteStateController);

    ref.listen(locationStateController, (_, state) {
      state.when(
        data: (location) {
          if (location.destination != null) {
            _controller.animateCamera(
              CameraUpdate.newLatLngBounds(location.bounds!, 50),
            );
          }
        },
        error: (error, stacktrace) =>
            Helpers.showInAppAlertError(context, "$error"),
        loading: () {},
      );
    });

    ref.listen(mapRouteStateController, (_, state) {
      if (state?.location != null) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: state!.location, zoom: 18.5, bearing: state.bearing),
          ),
        );
      }
    });

    return ViewWidget(
      viewBody: SizedBox(
        height: 1.sh,
        child: GoogleMap(
          myLocationEnabled: true,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            zoom: 18,
            target:
                locationState.value?.currentLocation ?? GuidaConstants.unilag,
          ),
          markers: locationState.value?.markers ?? {},
          polylines: locationState.value?.route ?? {},
          onMapCreated: (controller) => _controller = controller,
          cameraTargetBounds: CameraTargetBounds(locationState.value?.bounds),
        ),
      ),
      bottomSheet: BottomSheet(
        showDragHandle: true,
        backgroundColor: GuidaColors.grey,
        onClosing: () {},
        builder: (context) {
          return locationState.value?.distance != null &&
                  locationState.value?.distance != 0
              ? Padding(
                  padding: REdgeInsets.only(bottom: 48, left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Distance:",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Helpers.distanceCalculator(
                                locationState.value!.distance),
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (mapRouteState != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Distance Travelled:",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                Helpers.distanceCalculator(
                                  distanceTravelled(
                                      locationState.value!.distance,
                                      mapRouteState.distance),
                                ),
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _startedRoute
                                  ? null
                                  : () {
                                      _getTransportMode();
                                      ref
                                          .read(
                                              locationStateController.notifier)
                                          .start();
                                    },
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  color: _startedRoute
                                      ? GuidaColors.black.withOpacity(.2)
                                      : GuidaColors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 24.h),
                          OutlinedButton(
                            onPressed: () {
                              setState(() => _startedRoute = false);
                              ref
                                  .read(locationStateController.notifier)
                                  .cancel();
                              ref.invalidate(mapRouteStateController);
                              ref.invalidate(locationStateController);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: GuidaColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MapTextField(
                      controller: _to,
                      hint: "Enter your destination",
                      onTap: () async {
                        final location = await showSearch(
                          context: context,
                          delegate: SearchPlacesView(),
                        );
                        setState(() => _to.text = "$location");
                      },
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding:
                          REdgeInsets.only(bottom: 48, left: 16, right: 16),
                      child: GuidaButton(
                        name: "Draw Route",
                        action:
                            locationState.isLoading ? null : () => _mapRoute(),
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }

  void _mapRoute() {
    if (_to.text.isNotEmpty) {
      ref
          .read(locationStateController.notifier)
          .placeDestinationMarker(_to.text);
    } else {
      Helpers.showInAppAlertError(context, "Enter your destination");
    }
  }

  void _getTransportMode() async {
    final result = await showAdaptiveDialog<TransportMode>(
      context: context,
      builder: (context) => const TransportDialog(),
    );
    ref.read(locationStateController.notifier).setMode(result!);
    setState(() => _startedRoute = true);
  }

  double distanceTravelled(double start, double end) {
    return (start - end);
  }
}
