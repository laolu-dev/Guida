// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      timestamp: json['timestamp'] as String,
      wing: json['wing'] as String,
      name: json['name'] as String,
      directions: json['directions'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'wing': instance.wing,
      'name': instance.name,
      'directions': instance.directions,
      'image': instance.image,
    };
