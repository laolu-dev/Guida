
import 'package:json_annotation/json_annotation.dart';

import '../location/location_model.dart';

part 'department_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DepartmentModel {
  final String department;
  final List<LocationModel> locations;

  const DepartmentModel({required this.department, required this.locations});

  factory DepartmentModel.fromJson(Map<String, dynamic> json) =>
      _$DepartmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentModelToJson(this);
}
