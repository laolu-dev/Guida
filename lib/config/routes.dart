import 'package:flutter/material.dart';
import 'package:guida/src/models/location/location_model.dart';

import '../constants/route_names.dart';
import '../src/models/department/department_model.dart';
import '../src/views/authentication/login.dart';
import '../src/views/authentication/signup.dart';
import '../src/views/directions.dart';
import '../src/views/faculties.dart';
import '../src/views/locations.dart';
import '../src/views/map.dart';

class GuidaRoutes {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case GuidaRouteString.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case GuidaRouteString.signup:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case GuidaRouteString.faculties:
        return MaterialPageRoute(builder: (context) => const FacultiesView());
      case GuidaRouteString.locations:
        return MaterialPageRoute(
          builder: (context) =>
              LocationsView(department: settings.arguments as DepartmentModel),
        );
      case GuidaRouteString.directions:
        return MaterialPageRoute(
          builder: (context) =>
              DirectionsView(location: settings.arguments as LocationModel),
        );
      case GuidaRouteString.mapView:
        return MaterialPageRoute(builder: (context) => const GuidaMapView());
    }
    return null;
  }
}
