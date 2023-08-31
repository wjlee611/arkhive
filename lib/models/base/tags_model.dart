import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tags_model.g.dart';

// starts with @
class TagRichTextModel extends Equatable {
  final String color;

  // color: "<color=#0098DC>{0}</color>" => "0098DC"
  TagRichTextModel({
    String? value,
  }) : color = _extractColor(value);

  static String _extractColor(String? value) {
    RegExp pattern = RegExp(r'<color=#([0-9A-Fa-f]{6})>');
    Match? match = pattern.firstMatch(value ?? '');

    return match?.group(1) ?? '000000';
  }

  @override
  List<Object?> get props => [color];
}

// starts with $
@JsonSerializable()
class TagTermDescriptionModel extends Equatable {
  final String? termId;
  final String? termName;
  final String? description;

  const TagTermDescriptionModel({
    this.termId,
    this.termName,
    this.description,
  });

  factory TagTermDescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$TagTermDescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TagTermDescriptionModelToJson(this);

  @override
  List<Object?> get props => [
        termId,
        termName,
        description,
      ];
}
