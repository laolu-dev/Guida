import 'package:json_annotation/json_annotation.dart';

part 'substring.g.dart';

@JsonSerializable(explicitToJson: true)
class SubString {
  SubString({required this.length, required this.offset});

  final int length;

  final int offset;

  factory SubString.fromJson(Map<String, dynamic> json) =>
      _$SubStringFromJson(json);

  Map<String, dynamic> toJson() => _$SubStringToJson(this);
}
