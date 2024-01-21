import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/src/models/position_model.dart';

import 'package:guida/src/providers/auth_controller.dart';
import 'package:guida/src/providers/map_controller.dart';

import 'package:guida/src/providers/route_controller.dart';

final routeController =
    NotifierProvider<RouteNotifier, String>(RouteNotifier.new);

final loginController =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, User?>(LoginNotifier.new);

final createAccountController =
    AutoDisposeAsyncNotifierProvider<CreateAccountNotifier, User?>(
        CreateAccountNotifier.new);

final resetLinkController =
    AutoDisposeAsyncNotifierProvider<ResendLinkNotifier, User?>(
        ResendLinkNotifier.new);

final rememberMeController =
    NotifierProvider<RememberMeNotifier, bool>(RememberMeNotifier.new);

final markerController =
    NotifierProvider<MarkersNotifier, Set<Marker>>(MarkersNotifier.new);

final currentLocationController =
    AsyncNotifierProvider<CurrentLocationNotifier, PositionModel?>(
        CurrentLocationNotifier.new);

final addressController =
    AsyncNotifierProvider<AddressNotifier, String>(AddressNotifier.new);
