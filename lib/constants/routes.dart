import 'package:flutter/material.dart';
import 'package:guida/src/views/home.dart';
import 'package:guida/src/views/login.dart';
import 'package:guida/src/views/routes_pages.dart';
import 'package:guida/src/views/signup.dart';

class GuidaRouteString {
  static const String home = "/";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String routeInformation = "/route_information";
}

class GuidaRoutes {
  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case GuidaRouteString.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case GuidaRouteString.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case GuidaRouteString.signup:
        return MaterialPageRoute(builder: (context) => const SignupView());
      case GuidaRouteString.routeInformation:
        return MaterialPageRoute(builder: (context) => const RoutesView());
      default:
        return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }
}
