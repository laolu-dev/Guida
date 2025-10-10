import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';

final loginController =
    AsyncNotifierProvider<LoginNotifier, User?>(LoginNotifier.new);

final createAccountController =
    AsyncNotifierProvider.autoDispose<CreateAccountNotifier, User?>(
        CreateAccountNotifier.new);

final resetLinkController =
    AsyncNotifierProvider.autoDispose<ResendLinkNotifier, void>(
        ResendLinkNotifier.new);
