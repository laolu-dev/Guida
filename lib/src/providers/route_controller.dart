import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/enums.dart';
import 'package:guida/constants/routes.dart';

class RouteNotifier extends Notifier<String> {
  @override
  build() => GuidaRouteString.login;
}

class ResetPasswordViewNotifier extends AutoDisposeNotifier<ResetPasswordView> {
  @override
  build() => ResetPasswordView.sendLink;

  void changeView(ResetPasswordView newPage) => state = newPage;
}
