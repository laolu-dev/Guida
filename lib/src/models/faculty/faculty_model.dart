import 'package:json_annotation/json_annotation.dart';

import '../department/department_model.dart';

part 'faculty_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FacultyModel {
  final String faculty;
  final List<DepartmentModel> departments;

  const FacultyModel({required this.faculty, required this.departments});

  factory FacultyModel.fromJson(Map<String, dynamic> json) =>
      _$FacultyModelFromJson(json);

  Map<String, dynamic> toJson() => _$FacultyModelToJson(this);
}
