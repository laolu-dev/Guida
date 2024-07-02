import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Location {
  final String name;
  final String? imageUrl;
  final double latitude;
  final double longitude;
  final List<String> directions;

  Location({
    required this.name,
    this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.directions,
  });

  Location copyWith({
    String? name,
    String? imageUrl,
    double? latitude,
    double? longitude,
    List<String>? directions,
  }) {
    return Location(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      directions: directions ?? this.directions,
    );
  }

  @override
  String toString() {
    return 'Location(name: $name, imageUrl: $imageUrl, latitude: $latitude, longitude: $longitude, directions: $directions)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.imageUrl == imageUrl &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.directions, directions);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imageUrl.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        directions.hashCode;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'directions': directions,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      directions: List<String>.from((map['directions'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}
