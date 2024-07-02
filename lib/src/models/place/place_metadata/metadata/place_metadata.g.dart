// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceMetadata _$PlaceMetadataFromJson(Map<String, dynamic> json) =>
    PlaceMetadata(
      description: json['description'] as String,
      reference: json['reference'] as String,
      placeId: json['place_id'] as String,
      structuredFormatting: Formatting.fromJson(
          json['structured_formatting'] as Map<String, dynamic>),
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      terms: (json['terms'] as List<dynamic>)
          .map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchedSubstrings: (json['matched_substrings'] as List<dynamic>)
          .map((e) => SubString.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceMetadataToJson(PlaceMetadata instance) =>
    <String, dynamic>{
      'description': instance.description,
      'reference': instance.reference,
      'place_id': instance.placeId,
      'structured_formatting': instance.structuredFormatting.toJson(),
      'types': instance.types,
      'terms': instance.terms.map((e) => e.toJson()).toList(),
      'matched_substrings':
          instance.matchedSubstrings.map((e) => e.toJson()).toList(),
    };
