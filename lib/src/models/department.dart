// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'location_model.dart';

class Department {
  final String name;
  final List<Location> destinations;

  Department({
    required this.name,
    required this.destinations,
  });

  Department copyWith({
    String? name,
    List<Location>? destinations,
  }) {
    return Department(
      name: name ?? this.name,
      destinations: destinations ?? this.destinations,
    );
  }

  @override
  String toString() => 'Department(name: $name, destinations: $destinations)';

  @override
  bool operator ==(covariant Department other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.destinations, destinations);
  }

  @override
  int get hashCode => name.hashCode ^ destinations.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'destinations': destinations.map((x) => x.toMap()).toList(),
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      name: map['name'] as String,
      destinations: List<Location>.from(
        (map['destinations'] as List<int>).map<Location>(
          (x) => Location.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Department.fromJson(String source) =>
      Department.fromMap(json.decode(source) as Map<String, dynamic>);
}
