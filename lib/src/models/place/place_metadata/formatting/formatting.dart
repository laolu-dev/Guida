// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import '../sub_string/substring.dart';

part 'formatting.g.dart';

@JsonSerializable(explicitToJson: true)
class Formatting {

  Formatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
  });

  @JsonKey(name: 'main_text')
  final String mainText;

  @JsonKey(name: 'main_text_matched_substrings')
  final List<SubString> mainTextMatchedSubstrings;

    factory Formatting.fromJson(Map<String, dynamic> json) =>
      _$FormattingFromJson(json);

  Map<String, dynamic> toJson() => _$FormattingToJson(this);
}
