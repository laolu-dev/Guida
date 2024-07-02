// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'department.dart';

class Faculty {
  final String name;
  final List<Department> departments;

  Faculty({
    required this.name,
    required this.departments,
  });

  Faculty copyWith({
    String? name,
    List<Department>? departments,
  }) {
    return Faculty(
      name: name ?? this.name,
      departments: departments ?? this.departments,
    );
  }

  @override
  String toString() => 'Faculty(name: $name, departments: $departments)';

  @override
  bool operator ==(covariant Faculty other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.departments, departments);
  }

  @override
  int get hashCode => name.hashCode ^ departments.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'departments': departments.map((x) => x.toMap()).toList(),
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      name: map['name'] as String,
      departments: List<Department>.from(
        (map['departments'] as List<int>).map<Department>(
          (x) => Department.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source) as Map<String, dynamic>);
}
