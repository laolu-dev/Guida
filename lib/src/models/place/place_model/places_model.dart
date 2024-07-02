
import 'package:json_annotation/json_annotation.dart';

import '../place_metadata/metadata/place_metadata.dart';

part 'places_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PlacesModel {
  const PlacesModel({
    required this.predictions,
    required this.status,
  });

  final List<PlaceMetadata> predictions;

  final String status;

  factory PlacesModel.fromJson(Map<String, dynamic> json) =>
      _$PlacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesModelToJson(this);
}
