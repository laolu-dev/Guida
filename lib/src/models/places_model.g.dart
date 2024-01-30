// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesModel _$PlacesModelFromJson(Map<String, dynamic> json) => PlacesModel(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => PlaceMetadata.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$PlacesModelToJson(PlacesModel instance) =>
    <String, dynamic>{
      'predictions': instance.predictions.map((e) => e.toJson()).toList(),
      'status': instance.status,
    };
