import 'package:json_annotation/json_annotation.dart';

part 'terms.g.dart';

@JsonSerializable(explicitToJson: true)
class Terms {
  Terms({required this.offset, required this.value});

  final int offset;

  final String value;

  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);

  Map<String, dynamic> toJson() => _$TermsToJson(this);
}
