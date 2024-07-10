import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_controller.dart';

final loginController =
    AutoDisposeAsyncNotifierProvider<LoginNotifier, User?>(LoginNotifier.new);

final createAccountController =
    AutoDisposeAsyncNotifierProvider<CreateAccountNotifier, User?>(
        CreateAccountNotifier.new);

final resetLinkController =
    AutoDisposeAsyncNotifierProvider<ResendLinkNotifier, void>(
        ResendLinkNotifier.new);


