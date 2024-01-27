import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guida/src/models/user_location.dart';

import 'package:guida/src/providers/auth_controller.dart';
import 'package:guida/src/providers/map_controller.dart';

import 'package:guida/src/providers/route_controller.dart';

final navigatorKey =
    Provider<GlobalKey<NavigatorState>>((ref) => GlobalKey<NavigatorState>());

final routeController =
    NotifierProvider<RouteNotifier, String>(RouteNotifier.new);

final loginController =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, User?>(LoginNotifier.new);

final createAccountController =
    AutoDisposeAsyncNotifierProvider<CreateAccountNotifier, User?>(
        CreateAccountNotifier.new);

final resetLinkController =
    AutoDisposeAsyncNotifierProvider<ResendLinkNotifier, void>(
        ResendLinkNotifier.new);

final rememberMeController =
    NotifierProvider<RememberMeNotifier, bool>(RememberMeNotifier.new);

final userLocationController =
    AutoDisposeAsyncNotifierProvider<UserLocationNotifier, UserLocation>(
        UserLocationNotifier.new);

