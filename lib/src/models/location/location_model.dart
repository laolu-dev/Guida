import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel {
  final String timestamp;
  final String wing;
  final String name;
  final String directions;
  final String image;

  const LocationModel({
    required this.timestamp,
    required this.wing,
    required this.name,
    required this.directions,
    required this.image,
  });

  List<String> get steps {
    // Split using regular expression with multiple patterns
    List<String> splitList = directions.split(RegExp(r',\n|\n•'));

    // Trim leading and trailing whitespace from each split direction
    splitList = splitList.map((direction) => direction.trim()).toList();

    return splitList;
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
