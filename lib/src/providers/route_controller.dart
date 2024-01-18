import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/constants/routes.dart';

class RouteNotifier extends Notifier<String> {
  @override
  build() => GuidaRouteString.login;
}
