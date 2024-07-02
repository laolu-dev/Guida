import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place/place_model/places_model.dart';
import '../models/user_location.dart';
import 'auth_controller.dart';
import 'map_controller.dart';
import 'places_controller.dart';

final loginController =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, User?>(LoginNotifier.new);

final createAccountController =
    AutoDisposeAsyncNotifierProvider<CreateAccountNotifier, User?>(
        CreateAccountNotifier.new);

final resetLinkController =
    AutoDisposeAsyncNotifierProvider<ResendLinkNotifier, void>(
        ResendLinkNotifier.new);

final userLocationController =
    AutoDisposeAsyncNotifierProvider<UserLocationNotifier, UserLocation>(
        UserLocationNotifier.new);

final placesController =
    AsyncNotifierProviderFamily<PlacesNotifier, PlacesModel?, String>(
        PlacesNotifier.new);
