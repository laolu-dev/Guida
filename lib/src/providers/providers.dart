import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/enums.dart';
import 'package:guida/src/providers/auth_controller.dart';
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

final resetPasswordViewController =
    AutoDisposeNotifierProvider<ResetPasswordViewNotifier, ResetPasswordView>(
        ResetPasswordViewNotifier.new);

final rememberMeController =
    NotifierProvider<RememberMeNotifier, bool>(RememberMeNotifier.new);
