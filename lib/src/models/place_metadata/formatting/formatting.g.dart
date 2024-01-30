// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formatting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Formatting _$FormattingFromJson(Map<String, dynamic> json) => Formatting(
      mainText: json['main_text'] as String,
      mainTextMatchedSubstrings:
          (json['main_text_matched_substrings'] as List<dynamic>)
              .map((e) => SubString.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$FormattingToJson(Formatting instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'main_text_matched_substrings':
          instance.mainTextMatchedSubstrings.map((e) => e.toJson()).toList(),
    };
