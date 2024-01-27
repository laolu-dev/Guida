import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GuidaMapRoute {
  final String duration;
  final String distance;

  GuidaMapRoute({
    required this.duration,
    required this.distance,
  });

  GuidaMapRoute copyWith({
    String? duration,
    String? distance,
  }) {
    return GuidaMapRoute(
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
    );
  }

  @override
  String toString() =>
      'GuidaMapRoute(duration: $duration, distance: $distance)';

  @override
  bool operator ==(covariant GuidaMapRoute other) {
    if (identical(this, other)) return true;

    return other.duration == duration && other.distance == distance;
  }

  @override
  int get hashCode => duration.hashCode ^ distance.hashCode;
}
