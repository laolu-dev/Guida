// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faculty_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacultyModel _$FacultyModelFromJson(Map<String, dynamic> json) => FacultyModel(
      faculty: json['faculty'] as String,
      departments: (json['departments'] as List<dynamic>)
          .map((e) => DepartmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FacultyModelToJson(FacultyModel instance) =>
    <String, dynamic>{
      'faculty': instance.faculty,
      'departments': instance.departments.map((e) => e.toJson()).toList(),
    };
