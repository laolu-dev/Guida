import 'package:json_annotation/json_annotation.dart';

import '../formatting/formatting.dart';
import '../sub_string/substring.dart';
import '../terms/terms.dart';

part 'place_metadata.g.dart';

@JsonSerializable(explicitToJson: true)
class PlaceMetadata {
  const PlaceMetadata({
    required this.description,
    required this.reference,
    required this.placeId,
    required this.structuredFormatting,
    required this.types,
    required this.terms,
    required this.matchedSubstrings,
  });

  final String description;

  final String reference;

  @JsonKey(name: 'place_id')
  final String placeId;

  @JsonKey(name: 'structured_formatting')
  final Formatting structuredFormatting;

  final List<String> types;

  final List<Terms> terms;

  @JsonKey(name: 'matched_substrings')
  final List<SubString> matchedSubstrings;

  factory PlaceMetadata.fromJson(Map<String, dynamic> json) =>
      _$PlaceMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceMetadataToJson(this);
}
