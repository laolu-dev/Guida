import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guida/src/providers/route_controller.dart';

final routeProvider =
    NotifierProvider<RouteNotifier, String>(RouteNotifier.new);
